<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>규빈개발자도서관 - Kyubhin Developer Library</title>
<link rel="icon" href="/img/main/digital-library.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet" media="all">
<link rel="stylesheet" href="/css/index.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
	<div class="library-bg">
		<jsp:include page="/WEB-INF/views/include/menu.jsp" />
		<div class="library-top-bg">
			<div class="main-top-wrap">
				<div id="carouselExampleIndicators" class="carousel slide info-carousel" data-bs-ride="carousel">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
						<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
						<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
						<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
					</div>
					<div class="carousel-inner info-carousel-img">
						<div class="carousel-item active">
							<img src="/img/main/banner/banner-1.jpg" class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/img/main/banner/banner-2.jpg" class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/img/main/banner/banner-3.jpg" class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/img/main/banner/banner-4.jpg" class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/img/main/banner/banner-5.jpg" class="d-block w-100" alt="...">
						</div>
					</div>
					<button class="carousel-control-prev carousel-btn carousel-left-btn" type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide="prev">
						<i class="fa-solid fa-angle-left" aria-hidden="true"></i> <span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next carousel-btn carousel-right-btn " type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide="next">
						<i class="fa-solid fa-angle-right" aria-hidden="true"></i> <span class="visually-hidden">Next</span>
					</button>
				</div>
				<div class="mini-myInfo-box">
					<c:choose>
						<c:when test="${ not empty sessionScope.id }">
							<div class="myInfo-inner-login">
								<div class="d-flex user-status-top">
									<c:choose>
										<c:when test="${ sessionScope.id eq 'admin' }">
											<h5>도서관 대출도서 정보</h5>
										</c:when>
										<c:otherwise>
											<h5>
												<span>${ sessionScope.name }</span>님의 도서관<span class="text"> 이용내역</span>
											</h5>
										</c:otherwise>
									</c:choose>
									<a href="/member/logout"><button type="button" class="btn button logout-btn">로그아웃</button></a>
								</div>
								<c:choose>
									<c:when test="${ sessionScope.id eq 'admin' }">
										<div class="user-status-main">
											<div class="status-main-box">
												<div class="status-item-group d-flex">
													<div class="item-box">
														<img class="info-icon" src="/img/main/info_icon01.png" alt="" /> <a class="status-item" href="/adminPage/book/loanStatus">총 대출권수: <span>${ totalLoanCount }권</span></a>
													</div>
													<div class="item-box">
														<img class="info-icon" src="/img/main/info_icon02.png" alt="" /> <a class="status-item" href="/adminPage/book/ercStatus">총 연체권수: <span>${ totalOverdueCnt }권</span></a>
													</div>
												</div>
												<div class="status-item-group d-flex">
													<div class="item-box">
														<img class="info-icon" src="/img/main/info_icon03.png" alt="" /> <a class="status-item" href="/adminPage/book/reserveStatus">총 예약권수: <span>${ reservationCnt }권</span></a>
													</div>
													<div class="item-box">
														<img class="info-icon" src="/img/main/info_icon04.png" alt="" /> <a class="status-item" href="/adminPage/book/hopeList">총 신청도서: <span>${ totalWishCnt }권</span></a>
													</div>
												</div>
											</div>
										</div>
										<div class="latefee-info-box">
											<p>
												현재 도서관 총 미반납 연채료는 <span class="library-total-latefee"></span>원 입니다.
											</p>
										</div>
									</c:when>
									<c:otherwise>
										<div class="status-main-box">
											<div class="status-item-group d-flex">
												<div class="item-box">
													<img class="info-icon" src="/img/main/info_icon01.png" alt="" /> <a class="status-item" href="/myLibrary/loanBook">대출권수: <span>${ loanCount }권</span></a>
												</div>
												<div class="item-box">
													<img class="info-icon" src="/img/main/info_icon02.png" alt="" /> <a class="status-item" href="/myLibrary/loanBook">연체권수: <span>${ overdueCnt }권</span></a>
												</div>
											</div>
											<div class="status-item-group d-flex">
												<div class="item-box">
													<img class="info-icon" src="/img/main/info_icon03.png" alt="" /> <a class="status-item" href="/myLibrary/reservationBook">예약권수: <span>${ reservationCnt }권</span></a>
												</div>
												<div class="item-box">
													<img class="info-icon" src="/img/main/info_icon04.png" alt="" /> <a class="status-item" href="/myLibrary/hopeBook">신청도서: <span>${ wishCount }권</span></a>
												</div>
											</div>
										</div>
										<div class="latefee-info-box">
											<p>
												현재 회원님의 미반납 누적 연채료는 <span class="user-latefee"></span>원 입니다.
											</p>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</c:when>
						<c:otherwise>
							<div class="myInfo-inner">
								<p>나의 도서관 이용내역을 보고 싶다면?</p>
								<a href="/member/login">
									<button class="btn button login-btn" type="button">로그인하러 가기</button>
								</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="tab-wrap">
			<div class="tab-inner">
				<a href="/libraryInfo/summary" class="tab-box"> <img src="/img/main/info.png" alt="">
					<h4 class="info-text">도서관 정보</h4>
				</a> <a href="/facilityInfo/memberInfo" class="tab-box"> <img src="/img/main/guid.png" alt="">
					<h4 class="guid-text">이용안내</h4>
				</a> <a href="/bookCollection/popularBook" class="tab-box"> <img src="/img/main/bookTalk.png" alt="">
					<h4 class="guid-text">북토크</h4>
				</a> <a href="/community/qaForum" class="tab-box"> <img src="/img/main/inquiry.png" alt="">
					<h4 class="inquiry-text">문의</h4>
				</a> <a href="/facilityInfo/readingRoom" class="tab-box"> <img src="/img/main/reading-room.png" alt="">
					<h4 class="room-text">열람실 좌석</h4>
				</a>
			</div>
		</div>
	</div>
	<div class="library-info-bg">
		<div class="d-flex library-info-wrap">
			<div class="info-wrap">
				<div class="d-flex notice-top">
					<h5>공지 및 행사</h5>
					<a href="/community/noticeForum"><button class="btn button more-btn">더보기</button></a>
				</div>
				<c:forEach items="${ noticeList }" var="notice" varStatus="status">
					<div class="notice-main">
						<div class="d-flex notice-box">
							<a href="/community/noticeContent?pageNum=1&num=${ notice.num }" class="text-box"> 
								<c:if test="${ timeList[status.index] le 1440}">
									<img src="/img/main/ico_new.gif" alt="" />
								</c:if>		
								<span class="notice-text">
									${ notice.subject }
								</span>					
							</a>
							<p class="notice-day">${ notice.regDate.substring(0,10) }</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="info-wrap">
				<div class="d-flex useInfo-top">
					<h5>이용시간</h5>
					<a href="/facilityInfo/openHour">
						<button class="btn button more-btn">더보기</button>
					</a>
				</div>
				<div class="useInfo-main">
					<div class="bookInfo-box">
						<div class="title-box">
							<p>책 대출/반납</p>
						</div>
						<div class="contents-box">
							<div class="info-box">
								<div class="info-day">
									<p>월-목</p>
								</div>
								<div class="info-time">
									<p>09:00 ~ 21:00</p>
								</div>
							</div>
							<div class="info-box">
								<div class="info-day">
									<p>금</p>
								</div>
								<div class="info-time">
									<p>09:00 ~ 18:00</p>
								</div>
							</div>
							<div class="info-box">
								<div class="info-day">
									<p>토요일</p>
								</div>
								<div class="info-time">
									<p>09:00 ~ 13:00</p>
								</div>
							</div>
							<div class="info-box">
								<div class="info-day">
									<p>일,공휴일</p>
								</div>
								<div class="info-time">
									<p>미운영</p>
								</div>
							</div>
						</div>
					</div>
					<div class="roomInfo-box">
						<div class="title-box">
							<p>그룹스터디룸</p>
						</div>
						<div class="contents-box">
							<div class="info-box">
								<div class="info-day">
									<p>월-목</p>
								</div>
								<div class="info-time">
									<p>09:00 ~ 21:00</p>
								</div>
							</div>
							<div class="info-box">
								<div class="info-day">
									<p>금</p>
								</div>
								<div class="info-time">
									<p>09:00 ~ 18:00</p>
								</div>
							</div>
							<div class="info-box">
								<div class="info-day">
									<p>토요일</p>
								</div>
								<div class="info-time">
									<p>09:00 ~ 13:00</p>
								</div>
							</div>
							<div class="info-box">
								<div class="info-day">
									<p>일,공휴일</p>
								</div>
								<div class="info-time">
									<p>미운영</p>
								</div>
							</div>
						</div>
					</div>
					<p>※ 개관시간은 코로나19 상황에 따라 조정될 수 있습니다.</p>
				</div>
			</div>
		</div>
	</div>
	<div class="book-chart-bg">
		<div class="book-chart-wrap">
			<div class="d-flex book-chart-text">
				<h4>인기대출도서</h4>
				<a href="/bookCollection/popularBook"><button class="btn button more-btn" type="button">더보기</button></a>
			</div>
			<div class="book-chart-list">
				<div class="d-flex">
					<c:forEach items="${ popularBookList }" var="popularBook" varStatus="status">
						<a href="/bookCollection/bookDetail?isbn=${ popularBook.isbn }" class="book-box"> <img class="book-img" src="${ popularBook.image }" alt="">
							<h4 class="book-name">${ popularBook.title }</h4>
						</a>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/js/all.min.js"></script>
	<script src="https://kit.fontawesome.com/87ad453cf1.js" crossorigin="anonymous"></script>
	<script src="/js/main.js"></script>
	<script>
		let latefee = '${ latefee }'.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		let totalLatefee = '${ totalLatefee }'.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		$('.user-latefee').text(latefee);
		$('.library-total-latefee').text(totalLatefee);
		
		//관리창 띄우기
		$('.chat-icon-box').click(function(){
			let id = "${ sessionScope.id }";
			console.log(id);
			if(id == '') {
				location.href = "/member/login";
			} else {
				window.open('/chat/chatPage',' _blank','top=150, left=20, width=400, height=650, status=no, menubar=no, toolbar=no, resizable=no');
			}
		})		
	</script>
</body>