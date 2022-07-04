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
<link rel="stylesheet" href="/css/adminPage/board/manageNotice.css">
</head>
<body>
	<div class="notice-manage-background">
		<div class="title">
			<h5>공지 관리</h5>
		</div>
		<div class="notice-content-wrap">
			<div class=content-top-wrap>
				<h5>${notice.subject}</h5>
				<div class="d-flex content-data-box">
					<input class="notice-num" type="hidden" value="${ notice.num }"/>
					<div class="d-flex writer-box data-box">
						<p class="title">작성자</p>
						<p class="content">${notice.name}</p>
					</div>
					<div class="d-flex date-box data-box">
						<p class="title">작성일</p>
						<p class="content">${notice.regDate}</p>
					</div>
					<div class="d-flex view-box data-box">
						<p class="title">조회수</p>
						<p class="content">${notice.views}</p>
					</div>
				</div>
				<div class="attachments-wrap">
					<c:forEach var="file" items="${ fileList }">
						<div class="d-flex attachments-box">
							<c:choose>
								<c:when test="${ file.filename.substring(file.filename.length()-3, file.filename.length()) eq 'hwp' }">
									<img src="/img/community/hwp.gif">
								</c:when>
								<c:when test="${ file.filename.substring(file.filename.length()-3, file.filename.length()) eq 'jpg' }">
									<img src="/img/community/jpg.gif">
								</c:when>
								<c:when test="${ file.filename.substring(file.filename.length()-3, file.filename.length()) eq 'pdf' }">
									<img src="/img/community/pdf.gif">
								</c:when>
								<c:when test="${ file.filename.substring(file.filename.length()-3, file.filename.length()) eq 'png' }">
									<img src="/img/community/png.gif">
								</c:when>
								<c:otherwise>
									<img class="fileImg" src="/img/community/file.png">
								</c:otherwise>
							</c:choose>
							<a class="upload" href="/community/download?uuid=${ file.uuid }"> ${ file.filename } </a><br>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="content-main-wrap">${notice.content}</div>
			<div class="btn-box">
				<a href="/adminPage/board/editNotice?num=${ notice.num }">
					<button class="btn edit-btn">수정하기</button>
				</a> 
				<button class="btn delete-btn">삭제하기</button>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/summernote-lite.js"></script>
 	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
 	<script>
 		//공지글 삭제
 		$('.delete-btn').click(function(){
 			let deleteConfirm = confirm("공지글을 삭제하시겠습니까?")
 			
 			if(deleteConfirm) {
 	 			let num = $('.notice-num').val();
 	 			
 	 			$.ajax({
 	 				method:"DELETE",
 	 				url:"/community/deleteNotice/"+ num
 	 			}).done(function(result){	
 	 				alert(result);
 	 				opener.parent.location.reload();
 	 				window.close();
 	 			})
 			} //if()
 		})
 	</script>
</body>

</html>