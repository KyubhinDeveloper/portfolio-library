<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지작성</title>
<link rel="icon" href="/img/member/admin-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/adminPage/member/sendMail.css">
</head>
<body>
	<div class="mail-send-top">
		<p>회원님에게 공지를 발송하는 페이지입니다.</p>
	</div>
	<div class="mail-send-bg">
		<div class="title">
			<h5>공지작성</h5>
		</div>
		<div class="mail-send-main">
			<div class="mail-send-wrap">
				<div class="d-flex mail-send-item">
					<label>받으실 분</label>
					<div class="d-flex info-item-box">
						<c:choose>
							<c:when test="${ not empty idList }">
							<input class="info-input memo-input" type="text" value="${ idList }">
							</c:when>
							<c:otherwise>
							<input class="info-input memo-input" type="text">
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<textarea class="text-box" rows="10" name=""></textarea>
			<div class="d-flex send-bottom-box">
				<button class="btn send-btn">공지발송</button>
			</div>
		</div>
		
	</div>



	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/percent.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
	<script>
	
		//개인공지 발송 창닫기
		$('.close-btn').click(function(){
			window.close();
		})
		
		let idVal = $('.memo-input').val().replace('[','').replace(']','');
		$('.memo-input').val(idVal);
		
		//개인공지 발송
		$('.send-btn').click(function(){
			let sendConfirm = confirm("회원들에게 공지를 발송하시겠습니까?")
			
			if(sendConfirm) {
				let recipient = $('.memo-input').val();
				let content = $('.text-box').val();
				
				let recipientList = [];
				recipientList.push(recipient);
				
				var data = {id: recipientList}
				
				$.ajax({
					method: "POST",
					url: "/adminPage/member/sendMail?content=" + content,
					data: data
				}).done(function(){
					alert('공지가 발송되었습니다.')
					window.close();
				})
			} //if()
		})

	</script>
</body>

</html>