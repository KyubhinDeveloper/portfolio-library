<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="/css/myLibrary/overdueRecord.css">
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
						 <a href="/myLibrary/delinquency"><span class="page-now">연체/제재</span></a>
					</div>
				</div>
				<div class="main-myLibrary-wrap">
					<div class="main-myLibrary-box">
						<div class="myLibrary-title">
							<h1>연체/제재</h1>
						</div>
						<div class="myLibrary-main">
							<div class="main-wrap">
								<div class="d-block d-lg-flex myLibrary-box">
									<h4>내서재/정보관리</h4>
									<div class="d-flex mt-3 item-box">
										<a href="/myLibrary/bookmark">내서재</a> 
										<a href="/myLibrary/loanBook">대출중인 도서</a> 
										<a href="/myLibrary/overdueRecord" class="active">연체/제재</a> 
										<a href="/myLibrary/loanRecord">대출기록</a> 
										<a href="/myLibrary/lossRecord">분실기록</a> 
										<a href="/myLibrary/changeInfo">개인정보변경</a> 
										<a href="/myLibrary/personalNotice">개인공지</a>
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
									<div class="bottom-delinquency-wrap">
										<h2>미반납 연체현황</h2>
										<p>미반납 도서의 연체료 현황입니다. 미반납 도서의 자세한 정보는 대출 현황에서 확인하세요.</p>
										<div class="delinquency-count-box">
											<p>
												총 <span class="delinquency-count">${ overdueCnt }</span>건
											</p>
										</div>
										<c:if test="${ overdueCnt eq 0 }">
											<div class="no-list-box">
												<div class="no-book-box">
													<h5>결과가 없습니다.</h5>
												</div>
											</div>
										</c:if>
										<c:if test="${ overdueCnt gt 0 }">
										<table>
											<thead>
												<tr>
													<th>번호</th>
													<th>서명/저자</th>
													<th class="processing-date">연체일수</th>
													<th>연체료</th>
												</tr>
											</thead>
											<c:forEach items="${ overdueList }" var="overdueBook1" varStatus="status">
												<tbody>
													<tr>
														<td>
															<div class="td-title">번호</div>
															${ overdueCnt - status.index }
														</td>
														<td class="overdueBook-text">
															<input class="book-isbn" type="hidden" value="${ overdueBook1.isbn }"/>
															<div class="td-title">서명/저자</div>
															<a href="#">
																<span>${ overdueBook1.title }</span>, <span>${ overdueBook1.author }</span>, <span>${ overdueBook1.publisher }</span>, <span>${ overdueBook1.pubdate.substring(0,4) }</span>
															</a>
														</td>
														<td>
															<div class="td-title">연체일</div>
															${ overdueBook1.overdueDate }
														</td>
														<td>
															<div class="td-title">연체료</div>
															${ overdueBook1.overdueDate * 100 }원
														</td>
													</tr>
												</tbody>
											</c:forEach>
										</table>
										</c:if>
									</div>
									<div class="bottom-delinquency-wrap">
										<h2>연체료 납부 이력</h2>
										<p>도서반납 후, 연체료 납부 현황입니다. 미반납 도서의 연체 현황은 대출 현황에서 확인하세요.</p>
										<div class="delinquency-count-box">
											<p>
												총 <span class="delinquency-count">${ recordCnt }</span>건
											</p>
										</div>
										<c:if test="${ recordCnt eq 0 }">
											<div class="no-list-box">
												<div class="no-book-box">
													<h5>결과가 없습니다.</h5>
												</div>
											</div>
										</c:if>
										<c:if test="${ recordCnt gt 0 }">
										<table>
											<thead>
												<tr>
													<th>번호</th>
													<th>서명/저자</th>
													<th class="processing-date">처리일</th>
													<th>연체일수</th>
												</tr>
											</thead>
											<c:forEach items="${ overdueRecordList }" var="overdueBook2" varStatus="status">
												<tbody>
													<tr>
														<td>
															<div class="td-title">번호</div>
															${ recordCnt - status.index }
														</td>
														<td class="overdueBook-text">
															<input class="book-isbn" type="hidden" value="${ overdueBook2.isbn }"/>
															<div class="td-title">서명/저자</div>
															<a href="#">
																<span>${ overdueBook2.title }</span>, <span>${ overdueBook2.author }</span>, <span>${ overdueBook2.publisher }</span>, <span>${ overdueBook2.pubdate.substring(0,4) }</span>
															</a>
														</td>
														<td>
															<div class="td-title">납부일</div>
															${ overdueBook2.returnDate }
														</td>
														<td>
															<div class="td-title">연체일</div>
															${ overdueBook2.overdueDate }
														</td>
													</tr>
												</tbody>
											</c:forEach>
										</table>
										</c:if>
									</div>
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
	<script>
		//대출도서 도서정보 상세보기 이벤트
		$('.overdueBook-text').click(function(){
			let isbn = $(this).children('.book-isbn').val();
			console.log(isbn);
			location.href="/bookCollection/bookDetail?isbn="+isbn;
		}) 
	</script>
</body>