<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지작성 - AdminPage</title>
<link rel="icon" href="/img/member/admin-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link href="/css/summernote/summernote-lite.css" rel="stylesheet">
<link rel="stylesheet" href="/css/adminPage/board/writeNotice.css">
</head>
<body>
	<div class="notice-write-background">
		<div class="title">
			<h5>공지작성</h5>
		</div>
		<form class="notice-write-wrap" action="/community/writeNotice" method="post" enctype="multipart/form-data">
			<div class="write-top-box">
				<div class="d-flex tag-box">
					<label for="subject-input">제목</label> 
					<input id="subject-input" class="title-input" type="text" name="subject">
				</div>
				<div class="d-flex tag-box">
					<label for="file-input">썸네일</label> 
					<input id="thumbnail-input" class="file-input" type="file" name="thumbnailname">
				</div>
				<div class="d-flex tag-box">
					<label for="file-input">파일</label>
					<div class="d-flex file-box">
						<button class="btn file-add-btn" type="button">파일 추가하기</button>
						<div class="d-flex file-input-box">
							<input id="file-input" class="file-input" type="file" name="filename"> 
							<i class="fa-solid fa-xmark file-delete-btn"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="write-main-box">
				<textarea id="summernote" name="content"></textarea>
			</div>
		</form>
		<div class="d-flex btn-box">
			<button class="btn close-btn">닫기</button>
			<button class="btn save-btn" type="button">등록하기</button>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/summernote-lite.js"></script>
 	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
 	<script src="/js/adminPage/board/writeNotice.js"></script>
</body>

</html>