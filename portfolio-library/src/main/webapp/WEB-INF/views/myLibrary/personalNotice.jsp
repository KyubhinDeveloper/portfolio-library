<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>개인공지 - 규비개발자 도서관</title>
<link rel="icon" href="/img/digital-library.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/myLibrary/personalNotice.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
	<div class="library-bg">
		<jsp:include page="/WEB-INF/views/include/menu.jsp" />
		<div class="library-main-bg">
			<div class="library-main-wrap">
				<div class="main-top-wrap">
					<div class="d-flex top-box">
						<a href="/"> <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-house-door"
								viewBox="0 0 16 16">
                                <path
									d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
                            </svg>
						</a> <i class="fa-solid fa-angle-right"></i> 
						<a href="/myLibrary/myLibrary"><span>My Library</span></a> 
						<i class="fa-solid fa-angle-right"></i> 
						<a href="/myLibrary/personalNotice"><span class="page-now">개인공지</span></a>
					</div>
				</div>
				<div class="main-myLibrary-wrap">
					<div class="main-myLibrary-box">
						<div class="myLibrary-title">
							<h1>개인공지</h1>
						</div>
						<div class="myLibrary-main">
							<div class="main-wrap">
								<div class="d-block d-lg-flex myLibrary-box">
									<h4>내서재/정보관리</h4>
									<div class="d-flex mt-3 item-box">
										<a href="/myLibrary/bookmark">내서재</a> 
										<a href="/myLibrary/loanBook">대출중인 도서</a>
										<a href="/myLibrary/overdueRecord">연체/제재</a> 
										<a href="/myLibrary/loanRecord">대출기록</a> 
										<a href="/myLibrary/lossRecord">분실기록</a> 
										<a href="/myLibrary/changeInfo">개인정보변경</a> 
										<a class="active" href="/myLibrary/personalNotice">개인공지</a>
									</div>
								</div>
								<div class="d-block d-lg-flex myLibrary-box">
									<h4>도서신청현황</h4>
									<div class="d-flex mt-3 item-box">
										<a href="/myLibrary/reservationBook">예약도서</a> <a href="/myLibrary/hopeBook">희망도서</a>
									</div>
								</div>
							</div>
							<c:choose>
								<c:when test="${ not empty sessionScope.id }">
									<div class="bottom-notice-wrap">
										<div class="notice-count-box">
											<p>
												총 <span class="notice-count">${ pageDto.totalCount }</span>건
											</p>
										</div>
										<c:if test="${ !not empty noticeList  }">
										<div class="no-list-box">
											<div class="no-notice-box">
												<h5>개인공지가 없습니다.</h5>
											</div>
										</div>
										</c:if>
										<c:if test="${ not empty noticeList }">
										<table>
											<thead>
												<tr>
													<th>번호</th>
													<th>제목</th>
													<th>작성일</th>
													<th>읽은날</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${ noticeList }" var="notice" varStatus="status">
												<tr>
													<td>
														<div class="td-title">번호</div>
														${ pageDto.totalCount - (pageNum - 1) * pageDto.rowCount - status.index }
													</td>
													<td class="notice-name">
														<div class="td-title">제목</div>
														<c:if test="${ notice.type eq 1 }">
														<a href="/myLibrary/noticeContent?num=${ notice.num }&pageNum=${ pageNum }">[부산대 도서관] 자료반납 알림</a>
														</c:if>
														<c:if test="${ notice.type eq 2 }">
														<a href="/myLibrary/noticeContent?num=${ notice.num }&pageNum=${ pageNum }">[부산대 도서관] 미반납 도서 알림</a>
														</c:if>
														<c:if test="${ notice.type eq 3 }">
														<a href="/myLibrary/noticeContent?num=${ notice.num }&pageNum=${ pageNum }">[부산대 도서관] 반납예정일 알림</a>
														</c:if>
														<c:if test="${ notice.type eq 4 }">
														<a href="/myLibrary/noticeContent?num=${ notice.num }&pageNum=${ pageNum }">[부산대 도서관] 대출도서 예약 알림</a>
														</c:if>
														<c:if test="${ notice.type eq 5 }">
														<a href="/myLibrary/noticeContent?num=${ notice.num }&pageNum=${ pageNum }">[부산대 도서관] 예약도서 대출가능 알림</a>
														</c:if>
														<c:if test="${ notice.type eq 6 }">
														<a href="/myLibrary/noticeContent?num=${ notice.num }&pageNum=${ pageNum }">수동발송</a>
														</c:if>
													</td>
													<td class="loss-date">
														<div class="td-title">작성일</div>
														${ notice.regDate }
													</td>
													<td>
														<div class="td-title">읽은날</div>
														${ notice.readDate }
													</td>
												</tr>
												</c:forEach>
											</tbody>
										</table>
										</c:if>
									</div>
									<c:if test="${ pageDto.pageCount gt 0 }">
										<nav class="Page navigation" aria-label="Page navigation">
											<ul class="pagination notice-list-pagination">
												<li class="page-item first">
													<a class="page-link" href="/myLibrary/personalNotice" aria-label="first">
														<span aria-hidden="true">
															<i class="fa-solid fa-backward"></i>
														</span>
													</a>
												</li>
												<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
												<li class="page-item prev">
													<a class="page-link" href="/myLibrary/personalNotice?pageNum=${ pageDto.startPage - pageDto.pageBlock }" aria-label="Previous">
														<span aria-hidden="true">
															<i class="fa-solid fa-angle-left"></i>
														</span>
													</a>
												</li>
												</c:if>
												<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1"> 
												<li class="page-item ${ pageNum == i ? 'active' : ''}">
													<a class="page-link number" href="/myLibrary/personalNotice?pageNum=${ i }">
														${ i }
													</a>
												</li>
												</c:forEach>
												<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
												<li class="page-item next">
													<a class="page-link" href="/myLibrary/personalNotice?pageNum=${ pageDto.startPage + pageDto.pageBlock }" aria-label="Next">
														<span aria-hidden="true">
															<i class="fa-solid fa-angle-right"></i>
														</span>
													</a>
												</li>
												</c:if>
												<li class="page-item last">
													<a class="page-link" href="/myLibrary/personalNotice?pageNum=${ pageDto.pageCount }" aria-label="last">
														<span aria-hidden="true">
															<i class="fa-solid fa-forward"></i>
														</span>
													</a>
												</li>
											</ul>
										</nav>
									</c:if>
								</c:when>
								<c:otherwise>
									<div class="bottom-login-wrap">
										<h2>로그인 필요</h2>
										<div class="login-text-box">
											<p>로그인이 필요한 메뉴입니다.</p>
											<p>로그인인 상태라도 세션이 종료된 경우 개인화 페이지(MY LIBRARY)는 재로그인이 필요합니다.</p>
										</div>
										<a href="/member/login"><button class="btn login-btn">로그인</button></a>
									</div>
								</c:otherwise>
							</c:choose>
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
</body>