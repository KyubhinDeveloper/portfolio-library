<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>규비개발자 도서관 - Kyubhin Developer Library</title>
<link rel="icon" href="/img/digital-library.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/community/noticeContent.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
	<div class="library-bg">
		<jsp:include page="/WEB-INF/views/include/menu.jsp" />
		<div class="library-main-bg">
			<div class="library-main-wrap">
				<div class="main-top-wrap">
					<div class="d-flex top-box">
						<a href="/"> <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
                                <path
									d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
                            </svg>
						</a> 
						<i class="fa-solid fa-angle-right"></i>
						<span>커뮤니티</span>
						<i class="fa-solid fa-angle-right"></i> 
						<a href="/community/noticeForum"><span>공지 & 행사</span></a>
					</div>
				</div>
				<div class="main-community-wrap">
					<div class="community--box">
						<div class="community-title">
							<h1>공지 & 행사</h1>
						</div>
						<div class="community-tab-bg">
							<div class="community-tab-wrap">
								<div class="d-flex community-tab-box">
									<a href="/community/noticeForum" class="tab active">
										<p>공지 & 행사</p>
									</a> <a href="/community/inquiryForum" class="tab">
										<p>게시판 문의</p>
									</a> <a href="/community/qaForum" class="tab">
										<p>자주묻는 질문</p>
									</a>
								</div>
							</div>
						</div>
						<div class="notice-content-wrap">
							<div class=content-top-wrap>
								<h5>${notice.subject}</h5>
								<div class="d-flex content-data-box">
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
													<img src="../img/community/hwp.gif">
												</c:when>
												<c:when test="${ file.filename.substring(file.filename.length()-3, file.filename.length()) eq 'jpg' }">
													<img src="../img/community/jpg.gif">
												</c:when>
												<c:when test="${ file.filename.substring(file.filename.length()-3, file.filename.length()) eq 'pdf' }">
													<img src="../img/community/pdf.gif">
												</c:when>
												<c:when test="${ file.filename.substring(file.filename.length()-3, file.filename.length()) eq 'png' }">
													<img src="../img/community/png.gif">
												</c:when>
												<c:otherwise>
													<img class="fileImg" src="../img/community/file.png">
												</c:otherwise>
											</c:choose>
											<a class="upload" href="/community/download?uuid=${ file.uuid }"> ${ file.filename } </a><br>
										</div>
									</c:forEach>
								</div>
							</div>
							<div class="content-main-wrap">${notice.content}</div>
							<c:if test="${ notice.id eq id }">
								<div class="btn-box">
									<a href="/community/editNotice?pageNum=${ pageNum }&num=${ notice.num }">
										<button class="btn edit-btn">수정하기</button>
									</a> 
									<button class="btn delete-btn">삭제하기</button>
								</div>
							</c:if>
							<div class="list-btn-box">
								<a href="/community/noticeForum?pageNum=${ pageNum }"><button class="btn list-btn">목록</button></a>
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
	<script>
		var num = "${notice.num}";
	
		$('.delete-btn').click(function(){
			
			let deleteConfirm = confirm('게시물을 삭제하시겠습니까?'); 
			
			if(deleteConfirm){
				$.ajax({
					method: 'DELETE',
					url: '/community/deleteNotice/' + num
				}).done(function(result){
					alert(result);
					window.location.href = "/community/noticeForum";
				}).fail(function(errorThrown){
					console.log(errorThrown);
				});	
			}
		});	
	</script>
</body>