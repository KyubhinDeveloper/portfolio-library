<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="/css/chat/exampleChat.css">
</head>
<body>
	<div class="container">
		<div class="row clearfix">
			<div class="col-lg-12">
				<div class="card chat-app">
					<div id="plist" class="people-list">
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fa fa-search"></i></span>
							</div>
							<input type="text" class="form-control" placeholder="Search...">
						</div>
						<ul id="online-user" class="list-unstyled chat-list mt-2 mb-0">
							<!-- admin status -->
							<li class="clearfix" onclick="activeToggle(this)" id="admin">
								<img src="/img/chat/user-astronaut-solid.svg" alt="admin">
								<div class="about">
									<div id="admin" class="name">admin</div>
									<div id="admin-status" class="status">
										<i id="admin-status-icon" class="fa fa-circle offline"></i> 
										<span id="admin-status-content">offline </span>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<!-- chat section -->
					<div class="chat">
						<div class="chat-header clearfix">
							<div class="row">
								<div class="col-lg-6">
									<a href="javascript:void(0);" data-toggle="modal" data-target="#view_info"> 
									<img id="myImg" src="/img/chat/reddit-alien-brands.svg" alt="me">
									</a>
									<div class="chat-about">
										<span id="myId" class="m-b-0" th:text="${session.sessionId}"></span>
									</div>
								</div>
							</div>
						</div>
						<div class="chat-history">
							<ul style="overflow: scroll; height: 100%;" id="chat-content" class="m-b-0">


							</ul>
						</div>
						<div class="chat-message clearfix">
							<div class="input-group-prepend d-flex mb-0">
								<input id="msg" type="text" onkeydown="if(event.keyCode==13){send()}" class="form-control" placeholder="Enter text here...">
								<button id="button-send" type="button" class="input-group-text" data-toggle="tooltip" data-placement="top" title="send a message">
									<i class="fas fa-paper-plane"></i>
								</button>
								<button id="disconn" type="button" class="input-group-text" data-toggle="tooltip" data-placement="top" title="Out from chat">
									<i class="fas fa-sign-out-alt"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
	<script>
		var loginId = "${ sessionScope.id }";
	</script>
	<script type="text/javascript" src="/js/chat/exampleChat.js"></script>
</body>

</html>