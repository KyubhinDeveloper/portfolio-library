<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 - 규빈개발자도서관</title>
<link rel="icon" href="/img/main/digital-library.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/member/login.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
	<div class="library-bg">
		<div class="shadow move-top-icon">
			<i class="fa-solid fa-arrow-up"></i>
		</div>
		<div class="shadow chat-icon-box">
			<img src="/img/main/chat-icon.png" alt="" />
		</div>
		<jsp:include page="/WEB-INF/views/include/menu.jsp" />
		<div class="library-main-bg">
			<div class="library-main-wrap">
				<div class="main-top-wrap">
					<div class="d-flex top-box">
						 <a href="/">
							<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
	                            <path
									d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
	                        </svg>
                        </a>
						<i class="fa-solid fa-angle-right"></i>
						<a href="/memeber/login">
							<span>로그인</span>
						</a>
					</div>
				</div>
				<div class="main-contents-wrap">
					<div class="contents-box">
						<div class="contents-title">
							<h1>로그인</h1>
						</div>
						<div class="contents-main">
							<form class="d-flex login-wrap" action="/member/login/" method="post">
								<div class="login-input-box">
									<div class="input-tag id">
										<h5>아이디</h5>
									</div>
									<input id="id-input" type="text" name="id">
								</div>
								<div class="login-input-box">
									<div class="input-tag password">
										<h5>비밀번호</h5>
									</div>
									<input id="pwd-input" type="password" name="password">
								</div>
								<div class="d-flex login-bottom-box">
									<div class="d-flex login-keep-box">
										<input class="keep-check" type="checkbox" name="keepLogin"/>
										<p class="login-keep-text">로그인 상태 유지</p>
									</div>
									<a href="/member/join">회원가입</a>									
								</div>
								<p class="login-tip"></p>
								<button type="button" class="btn btn-primary login-btn">로그인 하기(Login)</button>
							</form>
							<div class="inquiry-wrap">
								<div class="d-flex inquiry-box">
									<div class="d-flex inquiry-title item">
										<div class="">
											<i class="fa-solid fa-question"></i>
										</div>
										<h4>문의하기</h4>
									</div>
									<div class="d-flex inquiry-phone item">
										<i class="fa-solid fa-headphones"></i>
										<h5>010-8285-5819</h5>
									</div>
									<div class="d-flex inquiry-location item">
										<i class="fa-solid fa-location-dot"></i>
										<h5>규비개발자 도서관</h5>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/main.js"></script>
	<script>
	
		$('.login-btn').click(function(){
			
			let idVal = $('#id-input').val();
			let pwdVal = $('#pwd-input').val();
			
			console.log(idVal);
			
			if(idVal == ""){
				$('.login-tip').text('아이디를 입력해주세요.')
			} else if(pwdVal == "") {
				$('.login-tip').text('비밀번호를 입력해주세요.')
			} else {
				
				$.ajax({
					method: 'GET',
					url: '/member/loginCheck/' + idVal + '/'+ pwdVal
				}).done(function(result){
					
					console.log(result)
					if(result != 1) {
						
						$('.login-tip').text('아이디 또는 비밀번호를 잘못 입력하셨습니다.');
					} else {
						
						$('.login-wrap').submit();
					}
				})
			}	 
		})
		
	
	</script>
</body>