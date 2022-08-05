<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>개인공지 - 규비개발자 도서관</title>
<link rel="icon" href="/img/main/digital-library.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/myLibrary/noticeContent.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
	<div class="library-bg">
		<jsp:include page="/WEB-INF/views/include/menu.jsp" />
		<div class="library-main-bg">
			<div class="library-main-wrap">
				<div class="main-top-wrap">
					<div class="d-flex top-box">
						<a href="/"> <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
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
										<a href="/myLibrary/personalNotice" class="active">개인공지</a>
									</div>
								</div>
								<div class="d-block d-lg-flex myLibrary-box">
									<h4>도서신청현황</h4>
									<div class="d-flex mt-3 item-box">
										<a href="/myLibrary/reservationBook">예약도서</a>
										<a href="/myLibrary/hopeBook">희망도서</a>
									</div>
								</div>
							</div>
							<div class="notice-content-wrap">
								<div class=content-top-wrap>
									<h3 class="notice-subject">
									<c:if test="${ noticeVo.type eq 1 }">
									[부산대 도서관] 자료반납 알림
									</c:if>
									<c:if test="${ noticeVo.type eq 2 }">
									[부산대 도서관] 미반납 도서 알림
									</c:if>
									<c:if test="${ noticeVo.type eq 3 }">
									[부산대 도서관] 반납예정일 알림
									</c:if>
									<c:if test="${ noticeVo.type eq 4 }">
									[부산대 도서관] 대출도서 예약 알림
									</c:if>
									<c:if test="${ noticeVo.type eq 5 }">
									[부산대 도서관] 예약도서 대출가능 알림
									</c:if>
									<c:if test="${ noticeVo.type eq 6 }">
									수동발송
									</c:if>
									</h3>
									<div class="d-flex top-info-box">
										<div class="d-flex date-box info-box">
											<p class="title">작성일</p>
											<p class="content">${ noticeVo.regDate }</p>
										</div>
										<div class="d-flex view-box info-box">
											<p class="title">읽은날</p>
											<p class="content">${ noticeVo.readDate }</p>
										</div>
									</div>
								</div>
								<div class="content-main-wrap">
									<c:choose>
									<c:when test="${ noticeVo.type eq 6 }">
										<p>${ noticeVo.content }</p>
									</c:when>
									<c:otherwise>
									<div class="content-box">
										<div class="top-wrap">
											<div class="top-text-box">
												<h2>규비개발자</h2>
												<h1><span>도서관</span>에서 알려드립니다.</h1>
											</div>
										</div>
										<div class="main-box">
											<div>
												<c:if test="${ noticeVo.type eq 1 }">
												<h2 class="personal-notice-title">자료반납 알림</h2>
												</c:if>
												<c:if test="${ noticeVo.type eq 2 }">
												<h2 class="personal-notice-title">미반납 도서 알림</h2>
												</c:if>
												<c:if test="${ noticeVo.type eq 3 }">
												<h2 class="personal-notice-title">반납예정일 알림</h2>
												</c:if>
												<c:if test="${ noticeVo.type eq 4 }">
												<h2 class="personal-notice-title">대출도서 예약 알림</h2>
												</c:if>
												<c:if test="${ noticeVo.type eq 5 }">
												<h2 class="personal-notice-title">예약도서 대출가능 알림</h2>
												</c:if>
												<c:if test="${ noticeVo.type eq 6 }">
												<h2 class="personal-notice-title">수동발송</h2>
												</c:if>
												
												<p>안녕하세요. <span class="member-name">${ name }</span>님</p>
												<c:if test="${ noticeVo.type eq 1 }">
												<p class="personal-notice-content">
													귀하께서 대출하신 자료가 정상적으로 반납되었음을 알려드립니다.
												</p>
												</c:if>
												<c:if test="${ noticeVo.type eq 2 }">
												<p class="personal-notice-content">
													대출하신 아래의 도서가 기한 내에 반납되지 않았습니다.<br>
													미반납 도서에는 1일 100원의 연체료가 부과되면, 대출 도서의 연장 및 추가 대출이 불가합니다.<br>
													빠른 반납 부탁드립니다.<br>
													자세한 대출 내역은 도서관 홈페이지 > My Library를 이용하세요
												</p>
												</c:if>
												<c:if test="${ noticeVo.type eq 3 }">
												<p class="personal-notice-content">
													대출하신 도서의 반납예정일이 도래하였습니다. 기한 내에 반납하여 주시기 바랍니다.<br>
													반납일이 경과하면 1일 100원의 연체료가 부과되면, 대출 도서의 연장 및 추가 대출이 불가합니다.<br>
													대출 연장은 도서관 홈페이지 > My Library를 이용하세요
												</p>
												</c:if>
												<c:if test="${ noticeVo.type eq 4 }">
												<p class="personal-notice-content">
													귀하께서 대출하신 도서가 다른 이용자에 의해 예약이 되었습니다.<br>
													예약된 도서는 대출연장이 불가하며, 반납예정일을 꼭 지켜주시기 바랍니다.
												</p>
												</c:if>
												<c:if test="${ noticeVo.type eq 5 }">
												<p class="personal-notice-content">
													귀하께서 예약하신 도서가 반납되어 대출 가능하오니, 대출승인기한(통보일 포함 2일) 내에 대출하여 주시기 바랍니다.
												</p>
												</c:if>
											</div>
											<table>
												<thead>
													<tr>
														<th></th>
														<th></th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td class="title">등록번호</td>
														<td class="content book-num">${ noticeVo.bookNum }</td>
													</tr>
													<tr>
														<td class="title">서명</td>
														<td class="content book-title">${ noticeVo.title }</td>
													</tr>
													<c:if test="${ noticeVo.type eq 3 || noticeVo.type eq 4}">
														<td class="title">대출일</td>
														<td class="content book-title">${ noticeVo.loanDate }</td>
													</c:if>
													<tr>
														<c:choose>
														<c:when test="${ noticeVo.type eq 1 }">
														<td class="title">반납일</td>
														</c:when>
														<c:when test="${ noticeVo.type eq 4 }">
														<td class="title ">만료일</td>
														</c:when>
														<c:when test="${ noticeVo.type eq 5 }">
														<td class="title ">대출승인만료일</td>
														</c:when>
														<c:otherwise>
														<td class="title">반납예정일</td>
														</c:otherwise>
														</c:choose>
														<c:choose>
														<c:when test="${ noticeVo.type eq 5 }">
														<td class="content submit-time">${ noticeVo.returnDate }</td>
														</c:when>
														<c:otherwise>
														<td class="content ${ noticeVo.type eq 4 ? 'end-date' : ''  }">${ noticeVo.returnDate }</td>
														</c:otherwise>
														</c:choose>
														
													</tr>
													<c:if test="${ noticeVo.type eq 2 }">
													<tr>
														<td class="title">연체일수</td>
														<td class="content book-title">${ noticeVo.overdueDate }</td>
													</tr>
													</c:if>
													<tr>
														<td class="title"></td>
														<td class="content"></td>
													</tr>
												</tbody>
											</table>
											<div class="bottom-box">
												<a href="/"><button type="button" class="btn home-btn">도서관 홈페이지 바로가기</button></a>
												<p>본 메일은 시스템에 의한 자동발송되는 발신 전용 메일입니다.</p>
											</div>
										</div>
										<div class="content-box-text">
											<p>(08281) 서울특별시 구로구 구로동로47길 17-8 (구로동) Tel. 010-8285-5819 / Fax. 010-8285-5819 </p>
											<p>© 2021 Kyubhin Han Developer Library. All Rights Reserved.</p>
										</div>
									</div>									
									</c:otherwise>
									</c:choose>
								</div>
								<div class="d-flex btn-box">
									<button class="btn delete-btn">삭제하기</button>
								</div>
								<div class="list-btn-box">
									<a href="/myLibrary/personalNotice?pageNum=${pageNum}"><button class="btn list-btn">목록보기</button></a>
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
		let now = new Date();
		let offset = now.getTime() + (1000 * 60 * 60 * 9);//toISOString()로 변환시 한국시간과 9시간 차이나서 9시간 더해줌.
		let dateOffset2 = new Date(offset + (1000 * 60 * 60 * 24 * 1)); 
		let submitTime = String(dateOffset2.toISOString()).replace('T',' ').substring(0, 10);
		console.log(submitTime);
		
		$('.submit-time').text(submitTime);
	
	</script>
</body>