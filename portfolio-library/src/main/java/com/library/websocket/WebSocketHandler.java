package com.library.websocket;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.java.Log;

//소켓서버 클래스
@Log
@Component
public class WebSocketHandler extends org.springframework.web.socket.handler.TextWebSocketHandler {
	
	
	private static List<String> onlineList = new ArrayList<>();
	private static List<WebSocketSession> sessionList = new ArrayList<>();
	Map<String, WebSocketSession> userSession = new HashMap<>();

	ObjectMapper json = new ObjectMapper();
		
	//클라이언트가 웹소켓과 처음 연결 되었을 때(채팅창에 접속했을 때) 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {	
		log.info("afterConnectionEstablished() 실행");
		//세션에서 로그인 아이디 가져오기
		//TextWebSocketConfig.java 에서 httpSession값을 WebSocketSession으로 복사해오도록 함.
		String senderId = (String)session.getAttributes().get("id"); //채팅 접속자 아이디
		log.info(senderId + "님이 채팅창에 접속했습니다.");
		sessionList.add(session); //접속한 세션 세션리스트에 추가
		userSession.put(senderId, session); //세션에 로그인 아이디 mapping
		onlineList.add(senderId); //온라인리스트에 추가
		
		if(senderId.equals("admin")) { //접속자가 관리자면
			log.info("관리자 접속 메시지 전체 발송 이벤트 작동");
			TextMessage msg = new TextMessage("상담사와 연결되었습니다.");
			sendToAll(msg, "admin"); //회원 전체에게 관리자 접속 메시지 전송
		} else {
			log.info("일반회원 접속 메시지 발송 이벤트 작동 (대상은 관리자)");
			Map<String, Object> data = new HashMap<>();
			data.put("message", senderId + "님이 채팅창에 접속했습니다.");
			data.put("receiverId", "admin"); //받는사람 관리자
			data.put("connectOne", senderId); //새로 접속한 사람 아이디 저장
			
			TextMessage msgToAdmin = new TextMessage(json.writeValueAsString(data));
			handleMessage(session, msgToAdmin); //handleTextMessage()로 전송
		} //else
	}
		
	// 클라이언트가 웹소켓 서버로 메시지(요청)를 전송했을 때 실행 (receiverId, message 전송됨)
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("소켓에서 메시지 보내는 이벤트 작동");
		Map<String, Object> dataMap = new HashMap<>();
		
		// 관리자 접속상태
		String adminStatus = null;
		
		if(userSession.containsKey("admin")) {
			adminStatus = "online";
		} else {
			adminStatus = "offline";
		}
		
		// 메시지를 보낸시간
		LocalDateTime currentTime = LocalDateTime.now();
		String time = currentTime.format(DateTimeFormatter.ofPattern("a hh:mm"));
		
		// 메시지 정보
		String senderId = (String) session.getAttributes().get("id"); //보낸 사람 로그인 아이디
		String payload = message.getPayload();
			
		dataMap = jsonToMap(payload); //받은 메시지 정보를 활용해서 새로운 정보 추가
		dataMap.put("senderId", senderId);
		dataMap.put("time", time);
		dataMap.put("adminStatus", adminStatus);
		dataMap.put("onlineList", onlineList);

		String receiverId = (String)dataMap.get("receiverId"); //보낸 데이터에서 받는사람 아이디 가져오기
		log.info("메시지 받는사람: " + receiverId);
		log.info("메시지 보내는사람: " + senderId);
		log.info("보낼 메시지 최종 정보: " + dataMap);

		// 데이터 정보 보내기
		String msg = json.writeValueAsString(dataMap);

		if (userSession.get(receiverId) != null) { //만약 받는사람이 온라인일 경우		
			userSession.get(receiverId).sendMessage(new TextMessage(msg)); // send to receiver
			log.info("받는사람이 온라인이라 메시지 전송");
		}

		// 보낸 사람과 받는사람이 같지 않으면 자신에게도 메시지 보내기(관리자는 위에서 보내고 자기 자신에게 한번 더 보내지지 않는다)
		if(!senderId.equals(receiverId)) {
			dataMap.put("receiverId", senderId);
			msg = json.writeValueAsString(dataMap);
			session.sendMessage(new TextMessage(msg)); // send to myself
			log.info("자신이 보낸 메시지 본인에게도 발송");
		}
	}
	
	// websocket 연결 종료 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		String senderId = (String) session.getAttributes().get("id");
		sessionList.remove(session);
		onlineList.remove(senderId);
		userSession.remove(senderId);
		
		// as admin send to all
		if (senderId.equals("admin")) {
			log.info("관리자가 채팅에서 퇴장했습니다.");
			TextMessage msg = new TextMessage("관리자님이 퇴장했습니다.");
			sendToAll(msg, senderId);
		} else {
			log.info("일반유저가 채팅에서 퇴장했습니다.");
			Map<String, Object> data = new HashMap<>();
			data.put("message", senderId + "님이 퇴장하셨습니다.");
			data.put("receiverId", "admin");
			data.put("outOne", senderId );
			
			TextMessage msg = new TextMessage(json.writeValueAsString(data));
			handleMessage(session, msg);
		}
	}
	
	// 관리자 접속 전체알림
	public void sendToAll(TextMessage message, String senderId) throws Exception {
				
		Map<String, Object> dataMap = new HashMap<>();

		// 관리자 접속상태
		String adminStatus = null;
		
		if (userSession.containsKey("admin")) {
			adminStatus = "online";
		} else {
			adminStatus = "offline";
		}

		// sending time
		LocalDateTime currentTime = LocalDateTime.now();
		String time = currentTime.format(DateTimeFormatter.ofPattern("a hh:mm"));

		// message data
		String payload = message.getPayload();

		dataMap.put("message", message.getPayload());
		dataMap.put("senderId", senderId);
		dataMap.put("time", time);
		dataMap.put("adminStatus", adminStatus);
		dataMap.put("onlineList", onlineList);	// user online status
		dataMap.put("connectOne", "admin");
	
		log.info("관리자 접속 전체 발송 메시지 dataMap 정보: " + dataMap);

		//세션에 저장되어 있는 온라인인 사람들에게 알림전송
		for (String sessionId : userSession.keySet()) {
			dataMap.put("receiverId", sessionId);			
			String msg = json.writeValueAsString(dataMap);
			//클라이언트로 dataMap 보내기
			userSession.get(sessionId).sendMessage(new TextMessage(msg));
			log.info(sessionId + "에게 관리자 접속 메시지 발송완료");
		}
	}
	
	// json string parsing to map
	public Map<String, Object> jsonToMap(String jsonString) throws JsonMappingException, JsonProcessingException {
		Map<String, Object> map = new HashMap<>();
		ObjectMapper jmapper = new ObjectMapper();
		map = jmapper.readValue(jsonString, new TypeReference<Map<String, Object>>() {
		});

		return map;
	}


}
