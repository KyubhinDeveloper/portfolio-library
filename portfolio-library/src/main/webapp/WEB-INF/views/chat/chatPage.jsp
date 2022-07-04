<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>규비개발자 상담 채팅</title>
<link rel="icon" href="/img/main/chat-title-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/chat/chatPage.css">
</head>
<body>
	<div id="chat-list" class="connect-list-background">
		<div class="d-flex list-title-box">
			<div class="d-flex list-title">
				<img src="/img/chat/chat-icon.png" alt="" />
				<h5>온라인 목록</h5>
			</div>
			<div class="list-search-box">
				<input class="search-bar" type="text" />
				<i class="fa-solid fa-magnifying-glass"></i>
			</div>		
		</div>
		<div id="connect-user-list" class="list-main-box">
		</div>
	</div>
	<div id="chat-page" class="chat-background">
		<div class="d-flex chat-title-box">
			<c:if test="${ sessionScope.id eq 'admin' }">
			<i class="fa-solid fa-chevron-left"></i>
			</c:if>
			<div class="d-flex chat-title">
				<img src="/img/chat/chat-icon.png" alt="" />
				<h5>규비개발자 상담 채팅</h5>
				<input id="admin-status" type="hidden" value="offline"/>
				<i id="admin-status-icon" class="fa fa-circle offline"></i>
			</div>
			<div id="button-disconnect" class="d-flex chat-disconnect-box">
				<i class="fa-solid fa-right-from-bracket"></i>
				<h5>채팅종료</h5>
			</div>
		</div>
		<ul id="chat-content" class="chat-main-box">				
		</ul>
		<div class="chat-bottom-wrap">
			<div class="chat-bottom-box">
				<input id="chat-message" type="text" placeholder="궁금한 점을 입력해 주세요!"/>
				<img id="button-send" src="/img/chat/btn_send-img.png" alt="" />
			</div>
		</div>	
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
	<script>
		var loginId = "${ sessionScope.id }";
		
		if(loginId == 'admin') {
			$('#chat-page').css('display','none');
		} else {
			$('#chat-list').css('display','none');
		}
		
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1; 
		var date = now.getDate();
		function getTodayLabel(){        
			let week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');        
			let today = new Date().getDay();
		    let todayLabel = week[today];        
			return todayLabel;
		}
		
		var str = ""+year+"년 "+month+"월 "+date+"일 "+getTodayLabel()+"";
		$('.now-date').text(str);
		
		$('.fa-chevron-left').click(function(){
			$('#chat-page').fadeOut(600);
			$('#chat-list').css('display','block');
			
		})
		
	</script>
	<script type="text/javascript" src="/js/chat/chatPage.js"></script>
</body>

</html>