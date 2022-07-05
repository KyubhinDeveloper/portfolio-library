var receiverId;
var preOnlineList;
var adminStatusContent;
var preadminStatus;
var adminStatus;

if (loginId != 'admin') {
	receiverId = 'admin';
}

//메시지 보내기 이벤트
$("#button-send").click(function(){
	send();
});

const websocket = new WebSocket("wss://"+location.host+"/ws/chat");
websocket.onmessage = onMessage;
websocket.onopen = onOpen;
websocket.onclose = onClose;

//메시지 보내기 함수
function send() {
	var message = $('#chat-message').val();

	if (message != "") {
		let msg = {
			'receiverId': receiverId,
			'message': message
		}

		if (msg != null) {
			websocket.send(JSON.stringify(msg));
		}
		
		$('#chat-message').val('');
	}
}

//채팅에서 나갔을 때
function onClose(evt) {
	console.log("채팅에서 나감");
}

//채팅에 접속했을 때
function onOpen(evt) {
	console.log("채팅에 접속");
}

//웹소캣으로 메시지 받았을 때(채팅 접속시, 메시지를 보냈을 때, 채팅 나갔을 때)
function onMessage(msg) {
	adminStatusContent = $("#admin-status");
	preadminStatus = adminStatusContent.val(); //현재 관리자 상태정보

	var data = JSON.parse(msg.data);
		
	adminStatus = data.adminStatus;
	var onlineList = data.onlineList; 
	var senderId = data.senderId; 
	var message = data.message; 
	var time = data.time; 
	var connectOne = data.connectOne; 
	var outOne = data.outOne;
	
	//관리자 상태 업데이트
	updateadminStatus();
	
	// 채팅에 유저 접속시
	if (connectOne != null) {		
		//관리자만 해당
		if (loginId == "admin" && connectOne == "admin") { //관리자 접속시
			console.log("관리자가 접속했습니다.")
			//접속유저 온라인 리스트 가져오기
			getOnlineList(onlineList);
		} else { //회원 접속시
			console.log("회원이 접속했습니다.")
			//접속시 온라인 리스트에 추가
			insertOnlineList(connectOne);
		}
	} 
		
	//관리자가 보낸 메시지 아니면 내용 전부 세션에 저장 
	if (senderId != 'admin' && receiverId != senderId) { 
		addStagingMessage(senderId, time, message);
	} 
	
	insertMessage(senderId, time, message);

	// 유저 접속 종료시
	if (outOne != null) {
		console.log("유저의 접속이 끊겼습니다. >>> ", outOne);
		deleteOnlieList(outOne);
	}
}

//관리자 상태 업데이트
function updateadminStatus() {
	console.log("관리자 상태 업데이트");
	if (preadminStatus != adminStatus) {
		var icon = $('#admin-status-icon');

		if (adminStatus == "online") {
			icon.removeClass('offline');
			icon.addClass('online');
		} else {
			icon.removeClass('online');
			icon.addClass('offline');
		}
		adminStatusContent.val(adminStatus);
	}
};

// 접속유저 온라인 가져오기 (관리자 접속시)
function getOnlineList(onlineList) {
	var connectList = $("#connect-user-list"); //접속한 유저 리스트
	connectList.html("");
	onlineList.forEach(user => {
		console.log("온라인 현황: " + user);
		insertOnlineList(user);
	});
}

//접속유저 온라인 리스트에 추가 
function insertOnlineList(user) {
	console.log('온라인 리스트 추가');
	if (document.getElementById(user) == null) { //접속한 아이디가 온라인 리스트에 업을경우 추가
		var connectList = $("#connect-user-list");
		
		let str;		
		str = `	<div class="d-flex user-box" onclick="activeToggle(this)">
					<div class="d-flex user-main">
						<img src="/img/chat/basic-user.png" alt="" />
						<div class="d-flex user-info">
							<h5 id="`+user+`" class="name">`+user+`</h5>
							<div id="user-status" class="d-flex status">
								<i id="user-status-icon" class="fa fa-circle online"></i> 
								<span id="user-status-content">온라인</span>
							</div>
						</div>
					</div>
					<div class="d-flex message-count-box d-none">
						<span class="count"></span>
					</div>
				</div>`
				
		connectList.append(str);
	}
};

// 관리자 접속 후에 유저들이 보낸 채팅내역 가져오기
function addStagingMessage(senderId, time, message) {

	var container = [];
	var data = {
		"time": time,
		"message": message,
		"senderId": senderId
	}
	
	//sessionStorage에 보낸사람 이름으로 메시지 저장
	if (sessionStorage.getItem(senderId) != null) { //이전에 메시지를 보냈을 경우 기존 session에 내용만 추가
		container = JSON.parse(sessionStorage.getItem(senderId));
		container.push(data);
	} else { 
		container.push(data);
	}
	
	sessionStorage.setItem(senderId, JSON.stringify(container));
	
	//안읽은 보낸 메시지 갯수 추가
	if (document.getElementById(senderId) != null) {
		var circle = $('#admin').parents('.user-main').siblings('.message-count-box');
		var count = $('#admin').parents('.user-main').siblings('.message-count-box').find('.count');
		var n = count.text();
		
		if (n == "") {
			n = 0
		}
		
		n++;
		circle.removeClass('d-none');
		count.text(n);
	}
}

// 자신의 채팅 내역 가져오기
function insertMessage(senderId, time, message) { //onMessage()
	console.log("자신의 채팅내역 가져오기 " + message);
	
	var chatContent = $("#chat-content");
	
	if (loginId == senderId) {
		if(message == '채팅 접속') {
			let str;
			str = `<li class="d-flex opponent-message-wrap">
						<div class="opponent-message-box">
							<p class="message other-message">안녕하세요. `+senderId+`님!<br>규빈개발자 도서관 상담채팅입니다!</p>
						</div>
						<p class="d-flex opponent-message-time">`+time+`</p>
					</li>`;
			chatContent.append(str);
			
			if($('#admin-status').val == 'online') {
				str = `<li class="d-flex opponent-message-wrap">
							<div class="opponent-message-box">
								<p class="message other-message">상담사와 연결되었습니다.</p>
							</div>
							<p class="opponent-message-time">`+time+`</p>
						</li>`;	
				chatContent.append(str);	
			} else {
				str = `<li class="d-flex opponent-message-wrap">
							<div class="opponent-message-box">
								<p class="message other-message">상담사와 연결 중입니다.<br>잠시만 기다려 주세요.</p>
							</div>
							<p class="d-flex opponent-message-time">`+time+`</p>
						</li>`;	
				chatContent.append(str);		
			} //else

		} else {

			let str;
			str = `<li class="d-flex my-message-wrap">
						<p class="d-flex my-message-time">`+ time + `</p>
						<div class="my-message-box">
							<p class="message my-message">`+ message + `</p>
						</div>	
					</li>`;
			chatContent.append(str);
		} //else
        
	} else {
		
		//상대가 보낸 메시지 출력
		let str;	
		str = `<li class="d-flex opponent-message-wrap">
					<div class="opponent-message-box">
						<p class="message other-message">`+message+`</p>
					</div>
					<p class="opponent-message-time">`+time+`</p>
				</li>`

		chatContent.appendChild(li);
	}
}

// 유저 아이콘 클릭
function activeToggle(element) { //insertOnlineList()
	console.log("activeToggle()")
		
	var preReceiverId = receiverId; //admin = null, 유저는 = admin
	receiverId = element.querySelector('.user-info > .name').textContent; // 클릭한 아이콘 이름
	console.log('<<<< activeToggle >>>>>')
	console.log('이전에 채팅하던 유저 이름 >>> ', preReceiverId);
	console.log('클릭한 유저 이름 >>> ', receiverId);
	
	setChatHistory(preReceiverId); //클릭시 현재 하던 채팅내용 저장
	document.getElementById('chat-content').innerHTML = "";
	getChatHistory(receiverId); // 클릭한 유저와의 채팅창 불러오기
	if (document.getElementById(receiverId).querySelector('.message-count-box') != null) {
		document.getElementById(receiverId).querySelector('.message-count-box > .count').textContent = "";
		document.getElementById(receiverId).querySelector('.message-count-box').classList.add('d-none');
	}	
	
	$('#chat-page').css('transform','translateX(0)');
}

//다른 유저 클릭시 현재 하던 채팅내용 저장  lve2514
function setChatHistory(name) { //activeToggle(preReceiverId)

	console.log('채팅 중이던 메시지 저장: ' + name);
	var value = [];
	
	document.querySelectorAll('.my-message-wrap').forEach(item => {

		var time = item.querySelector('.my-message-time').textContent;
		var message = item.querySelector('.message').textContent;
		var senderId;
		var type = item.querySelector('.message').classList[1];
		if (type == 'my-message') {
			senderId = loginId;
		} else {
			senderId = name;
		}

		data = {
			"time": time,
			"message": message,
			"senderId": senderId
		}		
		value.push(data);
	})
	
	sessionStorage.setItem(name, JSON.stringify(value));
};

// 클릭한 유저와의 기존 채팅창 불러오기
function getChatHistory(name) { //activeToggle()
	console.log('채팅창 불러올 대상: ' + name);
	var data = JSON.parse(sessionStorage.getItem(name));
	
	let str;
	str = `	<li class="chat-date-wrap">
				<div class="chat-date-box">
					<p id="now-date">`+year+`년 `+month+`월 `+date+`일 `+getTodayLabel()+`</p>
				</div>
			</li>`
	$('#chat-content').append(str);
	
	if (data != null) {
		data.forEach(item => {
			var time = item.time;
			var message = item.message;
			var senderId = item.senderId;

			insertMessage(senderId, time, message);
		})
	}
};

// delete outOne from onlineList
function deleteOnlieList(outOne) {
	var element = document.getElementById(outOne);
	element.parentNode.removeChild(element);
}
