<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>통합검색 - 규비개발자 도서관</title>
<link rel="icon" href="/img/main/digital-library.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/bookCollection/searchBook.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
	<div class="library-bg">
		<jsp:include page="/WEB-INF/views/include/menu.jsp" />
		<div class="library-main-bg">
			<div class="library-main-wrap">
				<div class="main-top-wrap">
					<div class="d-flex top-box">
						<a href="/"> <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-house-door"
								viewBox="0 0 16 16">
                                <path
									d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
                            </svg>
						</a> <i class="fa-solid fa-angle-right"></i>
						<span>자료검색</span>
						<i class="fa-solid fa-angle-right"></i>
						<a href="/bookCollection/searchBook"><span>통합검색</span></a>
					</div>
				</div>
				<div class="main-collection-wrap">
					<div class="main-collection-box">
						<div class="collection-title">
							<h1>통합검색</h1>
						</div>
						<div class="collection-main">
							<div class="main-wrap">
								<div class="d-flex search-box">
									<input id="book-search" class="me-2 book-search" type="text" placeholder="검색어 입력" value="${pageDto.search}">
									<button class="btn search-btn" type="button">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</div>
							</div>
						</div>
						<c:if test="${ not empty bookList }">
							<div class="collection-list-box">
								<div class="d-flex list-title">
									<div class="d-flex">
										<h4>소장자료(Catalog)</h4>
										<span class="badge rounded-pill">${pageDto.totalCount}</span>
									</div>
								</div>
								<div class="list-title-sub">
									<div class="d-flex">
										<div class="d-flex select-all-box ">
											<input id="all-check" class="mt-0 all-check" type="checkbox" >
											<label for="all-check">전체선택</label>
										</div>
										<div class="d-flex bookmark-box ">
											<i class="fa-solid fa-bookmark"></i>
											<p>내 서재 담기</p>
										</div>
									</div>
									<div class="d-flex select-count-box">
										<select class="select-count" name="list-count">
											<option class="option" value="10" ${ pageDto.rowCount == 10 ? 'selected' : '' }>10</option>
											<option class="option" value="15" ${ pageDto.rowCount == 15 ? 'selected' : '' }>15</option>
											<option class="option" value="20" ${ pageDto.rowCount == 20 ? 'selected' : '' }>20</option>
											<option class="option" value="30" ${ pageDto.rowCount == 30 ? 'selected' : '' }>30</option>
											<option class="option" value="30" ${ pageDto.rowCount == 50 ? 'selected' : '' }>50</option>
										</select>
										<i class="fa-solid fa-angle-down"></i>
									</div>
								</div>
								<div class="list-content">
									<c:forEach items="${ bookList }" var="book" varStatus="status">
										<div class="list-item">
											<div class="item-box">
												<div class="d-flex book-img-box">
													<input class="form-check-input mt-0 bookmark-check" type="checkbox">
													<input class="isbn" type="hidden" value="${ book.isbn.split(' ')[1] }"/> 
													<a href="/bookCollection/bookDetail?pageNum=${ pageNum }&rowCount=${ pageDto.rowCount }&search=${ pageDto.search }&isbn=${book.isbn.split(' ')[1]}">
														<img src="${ book.image }" onError="this.src='/img/bookCollection/none-book-img.jpg'" alt="book-img">
													</a>
												</div>
												<div class="book-detail-box">
													<div>
														<a class="title" href="/bookCollection/bookDetail?pageNum=${ pageNum }&rowCount=${ pageDto.rowCount }&search=${ pageDto.search }&isbn=${book.isbn.split(' ')[1]}">${ book.title }</a>
														<p>
															<span class="author">${ book.author }</span>
															<span class="publisher">${ book.publisher }</span>,
															<c:choose>
															<c:when test="${ book.pubdate ne ''}">
																<span class="pubdate" data-pubdate="${ book.pubdate }">${ book.pubdate.substring(0,4) }</span>
															</c:when>
															<c:otherwise>
																<span class="pubdate" data-pubdate="${ book.pubdate }">${ book.pubdate }</span>
															</c:otherwise>
															</c:choose> 
														</p>
													</div>
													<div class="book-btn-box">
														<c:if test="${ stopCheck[status.index] eq true }">
															<button type="button" class="btn loan-stop-btn">대출불가능</button>
														</c:if>
														<c:if test="${ stopCheck[status.index] eq false }">
															<button type="button" class="btn loan-btn">대출가능</button>
														</c:if>
														<c:if test="${ sessionScope.id eq 'admin' }">
															<c:if test="${ stopCheck[status.index] eq true }">
																<button type="button" class="btn use-all-btn">이용복구</button>
															</c:if>
															<c:if test="${ stopCheck[status.index] eq false }">
																<button type="button" class="btn stop-all-btn">이용중지</button>
															</c:if>
														</c:if>
													</div>
													<div class="d-flex icon-wrap">
														<div class="d-flex icon-box book-status-icon">
															<input class="isbn" type="hidden" value="${ book.isbn.split(' ')[1] }"/>
															<i class="fa-solid fa-list-check"></i>
															<p>소장정보</p>
														</div>
														<div class="d-flex icon-box book-summary-icon">
															<i class="fa-solid fa-book"></i>
															<p>요약보기</p>
														</div>
														<div class="d-flex icon-box bookmark-icon">
															<i class="fa-solid fa-bookmark"></i>
															<p>내 서재 담기</p>
														</div>
													</div>
												</div>
											</div>
											<div class="book-loan-status">
												<div class="loan-status-box">
													<table>
														<thead>
															<tr>
																<th>등록번호</th>
																<th>도서상태</th>
																<th>반납예정일</th>
																<th>서비스</th>
																<c:if test="${ sessionScope.id eq 'admin' }">
																	<th>기능</th>
																</c:if>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td class="bookNum">K${ book.isbn.split(' ')[1].substring(6) }</td>
																<td class="loan-status">대출가능</td>
																<td class="loan-endDay"></td>
																<td class="book-service">
																	<button class="btn loan-btn">대출하기</button>
																</td>
																<c:if test="${ sessionScope.id eq 'admin' }">
																	<td class="book-function">
																		<button class="btn stop-btn">이용중지</button>
																	</td>
																</c:if>
															</tr>
															<tr>
																<td class="bookNum">K${ book.isbn.split(' ')[1].substring(6) }-1</td>
																<td class="loan-status">대출가능</td>
																<td class="loan-endDay"></td>
																<td class="book-service">
																	<button class="btn loan-btn">대출하기</button>
																</td>
																<c:if test="${ sessionScope.id eq 'admin' }">
																	<td class="book-function">
																		<button class="btn stop-btn">이용중지</button>
																	</td>
																</c:if>
															</tr>
															<tr>
																<td class="bookNum">K${ book.isbn.split(' ')[1].substring(6) }-2</td>
																<td class="loan-status">대출가능</td>
																<td class="loan-endDay"></td>
																<td class="book-service">
																	<button class="btn loan-btn">대출하기</button>
																</td>
																<c:if test="${ sessionScope.id eq 'admin' }">
																	<td class="book-function">
																		<button class="btn stop-btn">이용중지</button>
																	</td>
																</c:if>
															</tr>
														</tbody>
													</table>
												</div>
											</div>
											<div class="book-summary-box">
												<p>${ book.description }</p>
											</div>
										</div>
									</c:forEach>	
								</div>
							</div>
						</c:if>
						<c:if test="${ not empty bookList }">
							<nav class="navigation" aria-label="Page navigation">
								<ul class="pagination book-list-pagination">
									<li class="page-item first">
										<a class="page-link" href="/bookCollection/searchBook?rowCount=${ pageDto.rowCount }&pageNum=1&search=${pageDto.search}">
											<i class="fa-solid fa-backward"></i>
										</a>
									</li>
									<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
										<li class="page-item prev">
											<a class="page-link" href="/bookCollection/searchBook?rowCount=${ pageDto.rowCount }&pageNum=${ pageDto.startPage - pageDto.pageBlock }&search=${pageDto.search}" aria-label="Previous"> 
												<span aria-hidden="true"><i class="fa-solid fa-angle-left"></i></span>
											</a>
										</li>
									</c:if>
									<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
										<li class="page-item ${ pageNum == i ? 'active' : ''}">
											<a class="page-link number" href="/bookCollection/searchBook?rowCount=${ pageDto.rowCount }&pageNum=${ i }&search=${pageDto.search}"> ${ i } </a>
										</li>
									</c:forEach>
									<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
										<li class="page-item next">
											<a class="page-link" href="/bookCollection/searchBook?rowCount=${ pageDto.rowCount }&pageNum=${ pageDto.startPage + pageDto.pageBlock }&search=${pageDto.search}" aria-label="Next"> 
												<span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
											</a>
										</li>
									</c:if>
									<li class="page-item last">
										<a class="page-link" href="/bookCollection/searchBook?rowCount=${ pageDto.rowCount }&pageNum=${pageDto.pageCount}&search=${pageDto.search}">
											<i class="fa-solid fa-forward"></i>
										</a>
									</li>
								</ul>
							</nav>
						</c:if>
					</div>
				</div>
				<div class="bottom-wrap">
					<div class="d-flex bottom-box">
						<div class="d-flex bottom-title item">
							<div class="icon-box">
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
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
		
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/main.js"></script>
	<script src="/js/bookCollection/searchBook.js"></script>
	<script>
		var search = "${pageDto.search}";
		var pageNum = "${pageNum}";
		var id = "${sessionScope.id}"
	</script>
	
</body>