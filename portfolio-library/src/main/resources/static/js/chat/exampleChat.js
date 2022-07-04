var receiverId;
var preOnlineList;
var adminStatusContent;
var preadminStatus;
var adminStatus;

if (loginId != 'admin') {
	receiverId = 'admin';
} else {
   	document.getElementById('myImg').src = "/img/chat/user-astronaut-solid.svg";
}

//창 닫기 이벤트
$("#disconn").click(function(){
	window.close();
});

//메시지 보내기 이벤트
$("#button-send").click(function(){
	send();
});

const websocket = new WebSocket("ws://localhost:8099/ws/chat");
websocket.onmessage = onMessage;
websocket.onopen = onOpen;
websocket.onclose = onClose;

//메시지 보내기 함수
function send() {
	var message = $('#msg').val();
	// don't send when content is empty
	if (message != "") {
		let msg = {
			'receiverId': receiverId,
			'message': message
		}

		if (msg != null) {
			websocket.send(JSON.stringify(msg));
		}
		
		$('#msg').val('');
	}
}

//on exit chat room
function onClose(evt) {
	console.log("채팅에서 나감");
}

//on entering chat room
function onOpen(evt) {
	console.log("채팅에 접속");
}

//웹소캣으로 메시지 받았을 때(채팅 접속시, 메시지를 보냈을 때, 채팅 나갔을 때)
function onMessage(msg) {
	console.log("받는사람 아이디: " + receiverId);
	adminStatusContent = $("#admin-status-content");
	preadminStatus = adminStatusContent.text(); //현재 관리자 상태정보

	var data = JSON.parse(msg.data);
		
	adminStatus = data.adminStatus;
	var onlineList = data.onlineList; 
	var senderId = data.senderId; 
	var message = data.message; 
	var time = data.time; 
	var connectOne = data.connectOne; 
	var outOne = data.outOne;
	
	// 채팅에 유저 접속시
	if (connectOne != null) {		
		//관리자만 해당
		if (loginId == 'admin' && connectOne == "admin") { //관리자 접속시
			console.log("관리자가 접속했습니다.")
			//접속유저 온라인 리스트 가져오기
			getOnlineList(onlineList);
		} else if (loginId == "admin" && connectOne != "admin") { //회원 접속시
			console.log("회원이 접속했습니다.")
			//접속시 온라인 리스트에 추가
			insertOnlineList(connectOne);
		}
	}
	
	//관리자가 접속한 이후에 보낸 메시지만 저장된다.
	//관리자로 로그인시 다른 유저가 보냈고 자기자신에게 보낸 메시지가 아닐경우 
	if (loginId == 'admin' && senderId != 'admin' && receiverId != senderId) { 
		addStagingMessage(senderId, time, message);
	} else { //자신의 채팅내역 가져오기		
		insertMessage(senderId, time, message);
	}
	
	// 유저 접속 종료시
	if (outOne != null && loginId == 'admin') {
		console.log("유저의 접속이 끊겼습니다. >>> ", outOne);
		deleteOnlieList(outOne);
	}
	
	//관리자 상태 업데이트
	updateadminStatus();
	// scroll down
	scrollDown();
}

// 접속유저 온라인 가져오기 (관리자 접속시)
function getOnlineList(onlineList) {
	var connectUser = $("#connect-user"); //접속한 유저 리스트
	connectUser.html("");
	onlineList.forEach(user => {
		insertOnlineList(user);
	});
}

//접속유저 온라인 리스트에 추가 
function insertOnlineList(user) {

	if (document.getElementById(user) == null) { //접속한 아이디가 온라인 리스트에 업을경우 추가
		var connectUser = $("#connect-user");
		
		//온라인 유저 리스트 태그 추가
		var li = document.createElement('li');
		li.classList.add('clearfix');
		li.setAttribute('onclick', 'activeToggle(this)');
		li.setAttribute('id', user);

		var img = document.createElement('img');
		var src = "/img/chat/reddit-alien-brands.svg";
		img.setAttribute('src', src);
		img.setAttribute('alt', 'guest');
		
		//온라인 유저 이름추가
		var aboutDiv = document.createElement('div');
		aboutDiv.classList.add('about');
		var name = document.createElement('div');
		name.classList.add('name');
		name.textContent = user;	
		aboutDiv.appendChild(name);
		
		//온라인 유저 online icon과 text 추가
		var statusDiv = document.createElement('div');
		statusDiv.classList.add('status');
		var icon = document.createElement('i');
		icon.setAttribute('id', 'admin-status-icon');
		icon.classList.add('fa', 'fa-circle', 'online');	
		var span = document.createElement('span');
		span.setAttribute('id', 'admin-status-content');
		span.textContent = 'online';
		
		statusDiv.appendChild(icon);
		statusDiv.appendChild(span);
		
		aboutDiv.appendChild(statusDiv);
		li.appendChild(img);
		li.appendChild(aboutDiv);
		
		//안읽은 보낸 메시지 개수 추가
		var alertDiv = document.createElement('div');
		alertDiv.classList.add('circle', 'd-flex', 'align-items-center', 'justify-content-center', 'd-none');
		aspan = document.createElement('span');
		aspan.classList.add('staging-count');
		
		alertDiv.appendChild(aspan);
		li.appendChild(alertDiv);
		connectUser.appendChild(li);
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
	if (sessionStorage.getItem(senderId) != null) { //이전에 메시지를 보냈을 경우 기존 session에 추가
		container = JSON.parse(sessionStorage.getItem(senderId));
		container.push(data);
	} else { 
		container.push(data);
	}
	
	sessionStorage.setItem(senderId, JSON.stringify(container));
	
	//안읽은 보낸 메시지 갯수 추가
	if (document.getElementById(senderId) != null) {
		var circle = document.getElementById(senderId).querySelector('.circle');
		var count = document.getElementById(senderId).querySelector('.circle > .staging-count');
		var n = count.textContent;
		
		if (n == "") {
			n = 0
		}
		
		n++;
		circle.classList.remove('d-none');
		count.textContent = n;
	}
}

// 자신의 채팅 내역 가져오기
function insertMessage(senderId, time, message) { //onMessage()
	var chatContent = $("#chat-content");
	if (loginId == senderId) {
        //내가 보낸 메시지 출력
		var li = document.createElement('li');
		li.classList.add('message-li', 'clearfix', 'float-right');
		
		var infoDiv = document.createElement('div');
		infoDiv.classList.add('message-data');		
		li.appendChild(infoDiv);
		
		var timeSpan = document.createElement('span');
		timeSpan.classList.add('message-data-time');
		timeSpan.textContent = time;
		infoDiv.appendChild(timeSpan);
		
		var msgDiv = document.createElement('div');
		msgDiv.classList.add('message', 'my-message');
		msgDiv.textContent = message;
		li.appendChild(msgDiv);

		chatContent.append(li);
	} else {
		//상대가 보낸 메시지 출력
		var li = document.createElement('li');
		li.classList.add('message-li', 'clearfix');
		
		var infoDiv = document.createElement('div');
		infoDiv.classList.add('message-data');
		li.appendChild(infoDiv);
		
		var timeSpan = document.createElement('span');
		timeSpan.classList.add('message-data-time');
		timeSpan.textContent = time;
		infoDiv.appendChild(timeSpan);
		
		var msgDiv = document.createElement('div');
		msgDiv.classList.add('message', 'other-message');
		msgDiv.textContent = message;
		li.appendChild(msgDiv);

		chatContent.appendChild(li);
	}
}

// 유저 아이콘 클릭
function activeToggle(element) { //insertOnlineList()
	// 클릭시 active 없으면 
	if (!element.classList.contains('active')) {
		element.classList.add('active');
	} else {
		element.classList.remove('active');
	}; 
	
	var preReceiverId = receiverId; //admin = null, 유저는 = admin
	receiverId = element.querySelector('.about > .name').textContent; // 클릭한 아이콘 이름
	console.log('<<<< activeToggle >>>>>')
	console.log('클릭한 유저 이름 >>> ', receiverId);
	console.log('이전에 채팅하던 유저 이름 >>> ', preReceiverId);
	
	//이전 채팅자 비활성화
	if (receiverId != preReceiverId && preReceiverId != null) {
		document.getElementById(preReceiverId).classList.remove('active');
	}
	
	setChatHistory(preReceiverId); //클릭시 현재 하던 채팅내용 저장
	document.getElementById('chat-content').innerHTML = "";
	getChatHistory(receiverId); // 클릭한 유저와의 채팅창 불러오기
	divideChatSection(receiverId); // 대화시작 태그 넣기
	if (document.getElementById(receiverId).querySelector('.circle') != null) {
		document.getElementById(receiverId).querySelector('.circle > .staging-count').textContent = "";
		document.getElementById(receiverId).querySelector('.circle').classList.add('d-none');
	}
}

//다른 유저 클릭시 현재 하던 채팅내용 저장
function setChatHistory(name) { //activeToggle(preReceiverId)
	var value = [];
	
	document.querySelectorAll('.message-li').forEach(item => {

		var time = item.querySelector('.message-data > .message-data-time').textContent;
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
	var data = JSON.parse(sessionStorage.getItem(name));

	if (data != null) {
		data.forEach(item => {
			var time = item.time;
			var message = item.message;
			var senderId = item.senderId;

			insertMessage(senderId, time, message);
		})
	}
};

// 대화시작 태그 넣기
function divideChatSection(receiverId) { //activeToggle()
	var div = document.createElement('div');
	div.classList.add('clearfix');
	var str = receiverId + '님과의 대화 시작 ';
	var hr = document.createElement('hr');

	div.textContent = str;
	div.appendChild(hr);
	var chatContent = document.querySelector("#chat-content");
	chatContent.appendChild(div);

	scrollDown();
};

// delete outOne from onlineList
function deleteOnlieList(outOne) {
	var element = document.getElementById(outOne);
	element.parentNode.removeChild(element);
}

//관리자 상태 업데이트
function updateadminStatus() {
	if (preadminStatus != adminStatus) {
		var icon = $('#admin-status-icon');

		if (adminStatus == "online") {
			icon.removeClass('offline');
			icon.addClass('online');
		} else {
			icon.removeClass('online');
			icon.addClass('offline');
		}
		adminStatusContent.text(adminStatus);
	}
};


// scroll down event
function scrollDown() {
	var chatContent = document.querySelector("#chat-content");
	chatContent.scrollTop = chatContent.scrollHeight;
};