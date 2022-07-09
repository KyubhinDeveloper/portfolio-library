package com.library.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.mapper.MemberMapper;
import com.library.service.InquiryService;
import com.library.service.MemberService;
import com.library.service.MyLibraryService;
import com.library.vo.MemberVo;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private MyLibraryService myLibararyService;
	
	@GetMapping("/login")
	public void login(){
		
	}
	
	@GetMapping("/join")
	public void join(){
		
	}
	
	@GetMapping("/loginCheck/{idVal}/{pwdVal}")
	public ResponseEntity<Integer> loginCheck(@PathVariable("idVal") String id, @PathVariable("pwdVal") String password){
		
		Integer checkResult = memberService.loginCheck(id, password);
	
		return new ResponseEntity<Integer>(checkResult, HttpStatus.OK);
	} //loginCheck()
	
	@GetMapping("/pwdCheck/{nowPwd}")
	public ResponseEntity<Map<String, Object>> pwdCheck(@PathVariable("nowPwd") String nowPwd, HttpSession session) {
		
		String id = (String)session.getAttribute("id");
		
		Map<String, Object> result = new HashMap<>();
		
		boolean check = memberService.pwdCheckById(id,nowPwd);
		String pwd = memberService.getPasswordById(id);
		
		result.put("checkResult", check);
		result.put("password", pwd);
		
		return new ResponseEntity<Map<String, Object>>(result, HttpStatus.OK);		
	} //pwdCheck()
	
	
	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestParam(defaultValue = "false") boolean keepLogin, String id,
			HttpSession session, HttpServletResponse response) {
			
			String name = memberService.getNameById(id);
		
			session.setAttribute("id", id);
			session.setAttribute("name", name);
			
			if (keepLogin) {
				Cookie idCookie = new Cookie("id", id);
				idCookie.setMaxAge(60 * 1440);
				idCookie.setPath("/");
				response.addCookie(idCookie);
			}
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("location", "/"); // redirect 경로 위치 지정
			
			return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	}//login()
	
	@GetMapping("/logout")
	public ResponseEntity<String> logout(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {

		// 세션값 초기화
		session.invalidate();

		// 로그인 상태유지용 쿠키가 존재하면 삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("id")) {
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
				}
			}
		}

		HttpHeaders header = new HttpHeaders();

		header.add("location", "/");

		return new ResponseEntity<String>(header, HttpStatus.FOUND);
	} // logout()
	
	
	@PostMapping("/join")
	public ResponseEntity<String> join(MemberVo memberVo) {
		
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
		memberVo.setRegDate(date);
		
		String birth = memberVo.getBirth();
		birth = birth.replaceAll(",", "/");
		memberVo.setBirth(birth);
		
		memberService.join(memberVo);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		StringBuilder sb = new StringBuilder();

		sb.append("<script>");
		sb.append("location.href = '/';");
		sb.append("alert('규빈이개발자 도서관 회원이 되신 것을 환영합니다.');");
		sb.append("</script>");

		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
	}
	
	@GetMapping("/idDupCheck/{id}")
	public ResponseEntity<Boolean> idDupCheck(@PathVariable("id") String id) {
		
		boolean checkResult = memberService.idDupCheck(id);
		
		return new ResponseEntity<Boolean>(checkResult, HttpStatus.OK);

	}//idDupCheck()
	
	@GetMapping("/emailDupCheck/{email}")
	public ResponseEntity<Boolean> emailDupCheck(@PathVariable("email") String email) {
		
		boolean checkResult = memberService.emailDupCheck(email);
		
		return new ResponseEntity<Boolean>(checkResult, HttpStatus.OK);

	}//idDupCheck()
	
	@GetMapping("/sendEmail/{email}")
	public ResponseEntity<Integer> sendEmail(@PathVariable("email") String email) throws MessagingException {

		// 회원가입을 위한 랜덤번호 생성
		Random random = new Random();
		int randomNum = random.nextInt(899999) + 100000; // 6자리 정수 생성
		
		// HTML로 보낼 메일내용 작성
		StringBuffer emailcontent = new StringBuffer();

		emailcontent.append("<!DOCTYPE html>");
		emailcontent.append("<html>");
		emailcontent.append("<head>");
		emailcontent.append("</head>");
		emailcontent.append("<body>");
		emailcontent.append(" <div"
				+ "	style=\"font-family: 'Apple SD Gothic Neo', 'sans-serif' !important; width: 700px; height: 600px; border-top: 4px solid #3251ed; margin: 100px auto; padding: 20px 0; box-sizing: border-box;\">"
				+ "	<h1 style=\"margin: 0; padding: 0 5px; font-size: 28px; font-weight: 400;\">"
				+ "		<span style=\"font-size: 15px; color: #5f5d5d; margin: 0 0 10px 3px;\"><b>GYUBIN DEVELOPER LIBRARY</b></span><br />"
				+ "		<span style=\"color: #3251ed\">인증번호를</span> 확인해주세요." + "	</h1>\n"
				+ "	<p style=\"font-size: 13px; line-height: 26px; margin-top: 30px; padding: 0 5px;\">"
				+ "		안녕하세요. 규빈개발자 도서관입니다.<br />"
				+ "		회원님께서 입력하신 이메일의 소유확인을 위해 아래 6자리 인증번호를 회원가입 화면에 입력해 주세요.<br />" + "		감사합니다." + "	</p>"
				+ "	<p style=\"font-size: 15px; line-height: 26px; margin-top: 30px; padding: 0 5px;\">"
				+ "		<b>6자리 인증코드</b>" + "	</p>" + "	<p"
				+ "		style=\"display: inline-block; width: 210px; height: 45px; margin: 30px 5px 40px; margin-top: 5px; border: 1px solid #cbd2d9; color: #6c7580; line-height: 45px; text-align: center; font-size: 20px;\">"
				+ "			<b>" + randomNum + "</b></p>"
				+ "	<div style=\"border-top: 1px solid #DDD; padding: 5px;\"></div>" + " </div>");
		emailcontent.append("</body>");
		emailcontent.append("</html>");
		
		memberService.sendEmail(email, "[규빈개발자 도서관] 이메일 확인을 위한 안내 메일입니다.", emailcontent.toString());

		return new ResponseEntity<Integer>(randomNum, HttpStatus.OK);

	} // sendEmail()
	
	@PostMapping("/updatePwd/{newPwd}/{id}")
	public ResponseEntity<String> updatePwd(@PathVariable("newPwd") String password, 
											@PathVariable("id") String id, HttpSession session) {
		
		memberService.updatePwd(password,id);
		
		return new ResponseEntity<String>("비밀번호가 수정되었습니다.", HttpStatus.OK);

	} //updatePwd()
	
	@PostMapping("/updateInfo/{emailVal}/{phoneVal}/{id}")
	public ResponseEntity<String> updateInfo(@PathVariable("emailVal") String email,
											 @PathVariable("phoneVal") String phone,
											 @PathVariable("id") String id, HttpSession session) {
		
		MemberVo memberVo = new MemberVo();
		
		memberVo.setEmail(email);
		memberVo.setId(id);
		memberVo.setPhone(phone);
		
		memberService.updateInfo(memberVo);
		
		return new ResponseEntity<String>("회원정보가 수정되었습니다.", HttpStatus.OK);
		
	}
	
	@GetMapping("/getMemberInfo")
	public ResponseEntity<Map<String,Object>> getMemberInfo() {
		
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		String today = now.format(formatter);
		//회원정보
		Map<String, Object> memberInfo = new HashMap<>();
		int totalCount = memberService.getTotalCount();//cnt == count
		int todayJointCnt = memberService.getTodayJointCnt(today);
		memberInfo.put("totalCount", totalCount);
		memberInfo.put("todayJointCnt", todayJointCnt);
		//희망도서 정보
		Map<String, Object> hopeBookInfo = new HashMap<>();
		int hopeBookCnt = myLibararyService.totalApplicationCnt();
		int todayApplicationCnt = myLibararyService.todayApplicationCnt(today);
		hopeBookInfo.put("hopeBookCnt", hopeBookCnt);
		hopeBookInfo.put("todayApplicationCnt", todayApplicationCnt);
		
		Map<String, Object> result = new HashMap<>();
		result.put("memberInfo", memberInfo);
		result.put("hopeBookInfo", hopeBookInfo);
	
		return new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);
	} //getMemberInfo()
}