<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="/css/community/noticeForum.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
	<div class="library-bg">
		<jsp:include page="/WEB-INF/views/include/menu.jsp" />
		<div class="library-main-bg">
			<div class="library-main-wrap">
				<div class="main-top-wrap">
					<div class="d-flex top-box">
						<a href="/"> <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="indexColor" class="bi bi-house-door" viewBox="0 0 16 16">
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
					<div class="community-box">
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
						<div class="notice-wrap">
							<div class="notice-search-wrap">
								<form class="d-flex search-box" action="/community/noticeForum" method="get">
									<div class="d-flex">
										<select class="search-select" name="category">
											<option value="all" ${pageDto.category eq 'all' ? 'selected': '' }>전체</option>
											<option value="subject" ${pageDto.category eq 'subject' ? 'selected' : '' }>제목</option>
											<option value="content" ${pageDto.category eq 'content' ? 'selected' : '' }>내용</option>
										</select> 
										<input class="me-2 book-search" type="text" name="search" aria-label="Search" placeholder="검색어를 입력해주세요" value="${pageDto.search}">
									</div>
									<button class="btn search-btn" type="submit">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</form>
							</div>
							<div class="notice-list-wrap">
							<c:if test="${ not empty noticeList }">
								<c:forEach items="${ noticeList }" var="notice" varStatus="status">
									<div class="d-flex notice-box">
										<div class="thumbnail">
											<c:set var="beginIndex" value="${ fn:indexOf(thumbnailList[status.index].path, 'upload') }" />
											<c:set var="length" value="${ fn:length(thumbnailList[status.index].path) }" />
											<c:set var="path" value="${ fn:substring(thumbnailList[status.index].path, beginIndex, length) }" />
											<c:choose>
												<c:when test="${ thumbnailList[status.index] ne null }">
													<a href="/community/noticeContent?pageNum=${ pageNum }&num=${ notice.num }"> 
														<img src="/${ path }/s_${ thumbnailList[status.index].uuid }_${ thumbnailList[status.index].filename }">
													</a>
												</c:when>
												<c:otherwise>
													<a href="/community/noticeContent?pageNum=${ pageNum }&num=${ notice.num }"> 
														<img src="../img/community/noticeImg.png">
													</a>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="notice-info-box">
											<a href="/community/noticeContent?pageNum=${ pageNum }&num=${ notice.num }">${ notice.subject }
												<c:if test="${ timeList[status.index] le 1440}">
													<span class="new-icon">N</span>
												</c:if>
											</a>
											
											<div class="d-flex notice-text-box">
												<p class="writer">
													<span class="writer">${ notice.name }</span>
												</p>
												<p>
													작성일 : <span>${ notice.regDate.substring(0,10)}</span>
												</p>
												<p>
													조회 : <span>${ notice.views }</span>
												</p>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:if>
							</div>
							<c:if test="${ not empty noticeList }">
								<nav aria-label="Page navigation">
									<ul class="pagination notice-pagination">
										<li class="page-item first">
											<a class="page-link" href="/community/noticeForum?pageNum=1&category=${pageDto.category}&search=${pageDto.search}">
												<i class="fa-solid fa-backward"></i>
											</a>
										</li>
										<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
											<li class="page-item prev">
												<a class="page-link" href="/community/noticeForum?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}" aria-label="Previous"> 
													<span aria-hidden="true"><i class="fa-solid fa-angle-left"></i></span>
												</a>
											</li>
										</c:if>
										<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
											<li class="page-item ${ pageNum == i ? 'active' : ''}"><a class="page-link number"
												href="/community/noticeForum?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}"> ${ i } </a></li>
										</c:forEach>
										<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
											<li class="page-item next">
												<a class="page-link" href="/community/noticeForum?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}" aria-label="Next"> 
													<span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
												</a>
											</li>
										</c:if>
										<li class="page-item last">
											<a class="page-link" href="/community/noticeForum?pageNum=${pageDto.pageCount}&category=${pageDto.category}&search=${pageDto.search}">
												<i class="fa-solid fa-forward"></i>
											</a>
										</li>
									</ul>
								</nav>
							</c:if>
							<c:if test="${ id eq 'admin' }">
								<div class="write-box">
									<a href="/community/writeNotice?pageNum=${pageNum}"><button class="btn write-btn">글쓰기</button></a>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
		
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/main.js"></script>
	<script>
	</script>
</body>