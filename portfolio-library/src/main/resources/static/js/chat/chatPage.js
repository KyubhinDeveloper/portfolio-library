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

const websocket = new WebSocket("ws://"+location.host+"/ws/chat");
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
	console.log("채팅에서 나갔습니다.");
	window.close();
}

//채팅에 접속했을 때
function onOpen(evt) {
	console.log("채팅에 접속했습니다.");
}

//웹소캣으로 메시지 받았을 때(채팅 접속시, 메시지를 보냈을 때, 채팅 나갔을 때)
function onMessage(msg) {
	console.log("onMessage()");
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
		console.log('새로운 접속자가 있습니다.')
		//관리자만 해당
		if (loginId == "admin" && connectOne == "admin") { //관리자 접속시
			//접속유저 온라인 리스트 가져오기			
			getOnlineList(onlineList);
			console.log('getOnlineList()')
		} else if(loginId == 'admin' && connectOne != 'admin'){ //회원 접속시
			//접속시 온라인 리스트에 추가		
			insertOnlineList(connectOne);
			console.log('insertOnlineList()')
		}
	}  //if()
	console.log('senderId: ' + senderId);
	console.log('receiverId: ' + receiverId);
			
	//관리자가 보낸 메시지 아니면 내용 전부 세션에 저장 
	if (loginId == 'admin' && senderId != 'admin' && receiverId != senderId) {
		console.log('addStagingMessage()'); 
		addStagingMessage(senderId, time, message);
	} else {
		console.log('insertMessage()'); 
		insertMessage(senderId, time, message, adminStatus);
	}
	
	// 유저 접속 종료시
	if (outOne != null && loginId == 'admin') {
		console.log("유저의 접속이 끊겼습니다. >>> ", outOne);
		deleteOnlieList(outOne);
	}
}

//관리자 상태 업데이트
function updateadminStatus() {
	if (preadminStatus != adminStatus) { //패치전 상태 새로 받아온 상태
		var icon = $('#admin-status-icon');

		if (adminStatus == "online") {
			icon.removeClass('offline');
			icon.addClass('online');
		} else {
			icon.removeClass('online');
			icon.addClass('offline');
		}
		
		adminStatusContent.val(adminStatus);
		console.log("updateadminStatus()");
	} 
};

// 접속유저 온라인 가져오기 (관리자 접속시)
function getOnlineList(onlineList) {
	var connectList = $("#connect-user-list"); //접속한 유저 리스트
	connectList.html("");
	onlineList.forEach(user => {
		insertOnlineList(user);
	});
	console.log('getOnlineList()');
}

//접속유저 온라인 리스트에 추가 
function insertOnlineList(user) {
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
		console.log(insertOnlineList());
	}
};

// 관리자 접속 후에 유저들이 보낸 채팅저장
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
	if ($('#'+senderId+'') != null) {
		var circle = $('#'+senderId+'').parents('.user-main').siblings('.message-count-box');
		var count = $('#'+senderId+'').parents('.user-main').siblings('.message-count-box').find('.count');
		var n = count.text();
		
		if (n == "") {
			n = 0
		}
		
		n++;
		circle.removeClass('d-none');
		count.text(n);
		console.log('안 읽은 메시지 갯수를 추가.')
	} //if()
}

// 자신의 채팅 내역 가져오기
function insertMessage(senderId, time, message, adminStatus) { //onMessage()s
	var chatContent = $("#chat-content");
	
	if (loginId == senderId) {
		console.log('자신이 보낸 메시지를 채팅에 추가합니다.' + message);
		if(message == ''+senderId+'님이 채팅창에 접속했습니다.') {
			
			let str;
			
			str = `<li class="d-flex message-wrap opponent-message-wrap">
						<div class="message-box opponent-message-box">
							<p class="message opponent-message">안녕하세요. `+senderId+`님!<br>규빈개발자 도서관 상담채팅입니다!</p>
						</div>
						<p class="d-flex message-time opponent-message-time">`+time+`</p>
					</li>`;
					
			chatContent.append(str);
			
			if(adminStatus == 'online') {
				
				str = `<li class="d-flex message-wrap opponent-message-wrap">
							<div class="message-box opponent-message-box">
								<p class="message opponent-message">상담사와 연결되었습니다.</p>
							</div>
							<p class="d-flex message-time opponent-message-time">`+time+`</p>
						</li>`;	
						
				chatContent.append(str);	
			} else {
				
				str = `<li class="d-flex message-wrap opponent-message-wrap">
							<div class="message-box opponent-message-box">
								<p class="message opponent-message">상담사와 연결 중입니다.<br>잠시만 기다려 주세요.</p>
							</div>
							<p class="d-flex message-time opponent-message-time">`+time+`</p>
						</li>`;	
						
				chatContent.append(str);		
			} //else

		} else {

			let str;
			str = `<li class="d-flex message-wrap my-message-wrap">
						<p class="d-flex message-time my-message-time">`+ time + `</p>
						<div class="message-box my-message-box">
							<p class="message my-message">`+ message + `</p>
						</div>	
					</li>`;
			chatContent.append(str);
		} //else
        
	} else {
		console.log('상대가 보낸 메시지를 추가합니다.' + message);
		//상대가 보낸 메시지 출력
		let str;	
		str = `<li class="d-flex message-wrap opponent-message-wrap">
					<div class="message-box opponent-message-box">
						<p class="message opponent-message">`+message+`</p>
					</div>
					<p class="d-flex message-time opponent-message-time">`+time+`</p>
				</li>`

		chatContent.append(str);	
	}
}

// 유저 아이콘 클릭
function activeToggle(element) { //insertOnlineList()
	if (!element.classList.contains('active')) {
		element.classList.add('active');
	} else {
		element.classList.remove('active');
	};

	var preChattingId = $('#chat-target').val();
	clickId = element.querySelector('.user-info > .name').textContent; // 클릭한 아이콘 이름
	receiverId = clickId;
	$('.chat-target-id').text(clickId);
	$('#chat-target').val(clickId);

	console.log('<<<< activeToggle >>>>>')
	console.log('이전에 채팅하던 유저 이름 >>> ', preChattingId);
	console.log('클릭한 유저 이름 >>> ', clickId);

	//새로운 유저를 클릭함
	/*	if(preChattingId != admin && preChattingId != clickId) {
			setChatHistory(preChattingId); //다른 회원 클릭시 현재 하던 채팅내용 저장
			document.getElementById('chat-content').innerHTML = "";
			getChatHistory(clickId); // 클릭한 유저와의 채팅창 불러오기	
		} else if(preChattingId == admin && preChattingId != clickId) {}*/

	if (preChattingId != clickId) {
		
		$('#'+preChattingId+'').parents('.user-box').removeClass('active');
		
		setChatHistory(preChattingId); //다른 회원 클릭시 현재 채팅내용 저장
		document.getElementById('chat-content').innerHTML = "";
		getChatHistory(clickId); // 클릭한 유저와의 채팅창 불러오기	

	}

	if($('#'+clickId+'').parents('.user-main').siblings('.message-count-box') != null) {
		
		$('#'+clickId+'').parents('.user-main').siblings('.message-count-box').find('.count').text('');
		$('#'+clickId+'').parents('.user-main').siblings('.message-count-box').addClass('d-none');
	}
}

//다른 유저 클릭시 현재 하던 채팅내용 저장  lve2514
function setChatHistory(preChattingId) { //activeToggle(preReceiverId)

	console.log('채팅 중이던 메시지 저장: ' + preChattingId);
	var value = [];
	
	document.querySelectorAll('.message-wrap').forEach(item => {

		var time = item.querySelector('.message-time').textContent;
		var message = item.querySelector('.message-box .message').textContent;
		var senderId;
		var type = item.querySelector('.message-box .message').classList[1];
		console.log('type: ' + type);
		if (type == 'my-message') {
			senderId = loginId;
		} else {
			senderId = preChattingId;
		}

		data = {
			"time": time,
			"message": message,
			"senderId": senderId
		}		
		value.push(data);
	})
	
	sessionStorage.setItem(preChattingId, JSON.stringify(value));
};

// 클릭한 유저와의 기존 채팅창 불러오기
function getChatHistory(clickId) { //activeToggle()
	console.log('채팅창 불러올 대상: ' + clickId);
	var data = JSON.parse(sessionStorage.getItem(clickId));
	
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
	var userTag = $('#'+outOne+'').parents('.user-box');
	userTag.remove();
}

 // scroll down event
 function scrollDown() {
     var chatContent =  document.querySelector("#chat-content");
     chatContent.scrollTop = chatContent.scrollHeight;
 };
