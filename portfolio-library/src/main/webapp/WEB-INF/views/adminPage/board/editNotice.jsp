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
<link rel="stylesheet" href="/css/adminPage/board/editNotice.css">
</head>
<body>
	<div class="notice-edit-background">
		<div class="title">
			<h5>공지수정</h5>
		</div>
		<form class="notice-edit-wrap" action="/community/editNotice?num=${ notice.num }" method="post" enctype="multipart/form-data">
			<input type="hidden" name="_method" value="put" />
			<div class="edit-top-box">
				<div class="d-flex tag-box">
					<label for="subject-input">제목</label> 
					<input id="subject-input" class="title-input" type="text" name="subject" value="${ notice.subject }">
				</div>
				<div class="d-flex tag-box">
					<label for="file-input">썸네일</label>
					<c:if test="${ thumbnail eq null }">
						<input id="thumbnail-input" class="file-input" type="file" name="newThumbnail">
					</c:if>
					<c:if test="${ thumbnail ne null}">
						<input type="hidden" name="oldThumbnail" value="${ thumbnail.uuid }">
						<div class="d-flex thumbnail-box">
							<p class="oldThumbnail">${ thumbnail.filename }</p> <i class="fa-solid fa-xmark thumbnail-delete-btn"></i>
						</div>
					</c:if>
				</div>
				<div class="d-flex tag-box">
					<label for="file-input">파일</label>
					<div class="d-flex file-box">
						<button class="btn file-add-btn" type="button">파일 추가하기</button>
						<c:forEach var="attachments" items="${ attachments }">
							<input type="hidden" name="oldFile" value="${ attachments.uuid }">
							<div class="d-flex old-file-box">
								<p class="oldFile">${ attachments.filename }</p> 
								<i class="fa-solid fa-xmark oldFile-delete-btn"></i>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="edit-main-box">
				<textarea id="summernote" name="content">${ notice.content }</textarea>
			</div>
		</form>
		<div class="d-flex edit-bottom-box">
			<button class="btn close-btn">닫기</button>
			<button class="btn edit-btn" type="button">수정하기</button>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/summernote-lite.js"></script>
 	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	<script src="/js/adminPage/board/editNotice.js"></script>
</body>

</html>