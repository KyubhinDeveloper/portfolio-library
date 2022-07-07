<%@ page language="java" contentType="text; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="shadow move-top-icon">
	<i class="fa-solid fa-arrow-up"></i>
</div>
<div class="shadow chat-icon-box">
	<i class="fa-solid fa-headset"></i>
	<p>상담챗</p>
</div>
<nav class="navbar navbar-bg">
	<div class="d-flex navbar-container">
		<a href="/" class="d-flex navbar-brand library-brand"> <img class="brand-img" src="/img/main/digital-library.png" alt="">
			<div class="d-none d-lg-block brand-text">
				<h4>규비개발자 도서관</h4>
				<p>KYUBHIN HAN DEVELOPER LIBRARY</p>
			</div>
		</a>
		<div class="d-flex menu-search-box">
			<input id="menu-book-search" class="me-2 book-search" type="text" value="${ pageDto.search }">
			<button id="btn-search" class="btn search-btn" type="button">
				<i class="fa-solid fa-magnifying-glass"></i>
			</button>
		</div>
		<div class="d-flex align-items-center">
			<c:choose>
				<c:when test="${ empty sessionScope.id }">
					<div class="d-none d-lg-block join-box ">
						<a href="/member/join">회원가입</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="d-none d-lg-block user-id-box">
						<a href="/member/logout">로그아웃</a>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="d-flex navbar-icon-box">
				<c:if test="${ empty sessionScope.id }">
					<a href="/member/login" class="d-block login-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="로그인"> 
						<svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
						  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
						</svg>
					</a>
				</c:if>
				<c:if test="${ not empty sessionScope.id and sessionScope.id ne 'admin'}">
					<div class="my-icon-box">
						<a class="d-block d-lg-none my-icon-sm" href="javascript:void(0)">
							<button class="button">MY</button> 
							<svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
						  		<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
							</svg>
						</a>
						<a class="d-none d-lg-block my-icon" href="#">
							<c:if test="${ wishCount gt 0 }">
							<div class="d-flex my-noticeCnt-box"><span class="count">${ wishCount }</span></div>
							</c:if>
							<button class="btn button my-btn" type="button">MY</button>
						</a>
						<div class="shadow my-hover-box hover-box">
							<div class="my-hover-title">
								<h5>
									<span class="user-name">${ sessionScope.name }</span>님
								</h5>
							</div>
							<div class="my-hover-main">
								<a class="icon-item" href="/myLibrary/myLibrary">전체메뉴 보기</a> 
								<a class="icon-item" href="/myLibrary/bookmark">내 서제</a> 
								<a class="icon-item" href="/myLibrary/overdueRecord">연체/제재</a> 
								<a class="icon-item" href="/myLibrary/loanBook">대출 현황</a> 
								<a class="icon-item" href="/myLibrary/reservationBook">예약 도서</a> 
								<a class="icon-item" href="/myLibrary/changeInfo">정보 변경</a>
							</div>
							<a href="/member/logout"><button class="btn my-logout-btn">로그아웃</button></a>
						</div>
					</div>
				</c:if>
				<c:if test="${ not empty sessionScope.id and sessionScope.id eq 'admin'}">
					<div class="admin-icon-box">
						<a class="d-block d-lg-none admin-icon-sm" href="javascript:void(0)">
							<button class="button">Admin</button> 
							<svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
						  		<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
							</svg>
						</a>
						<a class="d-none d-lg-block admin-icon" href="/adminPage/dashboard">
							<button class="btn button admin-btn" type="button">Admin</button>
						</a>
						<div class="shadow admin-hover-box hover-box">
							<div class="admin-hover-title">
								<h5>
									<span class="user-name">${ sessionScope.name }</span>님
								</h5>
							</div>
							<div class="admin-hover-main">
								<a class="icon-item" href="/adminPage/dashboard">관리자 페이지</a>
								<a class="icon-item" href="/community/noticeForum">공지사항</a>
								<a class="icon-item" href="/community/inquiryForum">게시판 문의</a>    
							</div>
							<a href="/member/logout"><button class="btn admin-logout-btn">로그아웃</button></a>
						</div>
					</div>
				</c:if>
				<div class="community-icon-box">
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-quote d-none d-lg-block" viewBox="0 0 16 16">
                                <path
							d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z" />
                                <path
							d="M7.066 6.76A1.665 1.665 0 0 0 4 7.668a1.667 1.667 0 0 0 2.561 1.406c-.131.389-.375.804-.777 1.22a.417.417 0 0 0 .6.58c1.486-1.54 1.293-3.214.682-4.112zm4 0A1.665 1.665 0 0 0 8 7.668a1.667 1.667 0 0 0 2.561 1.406c-.131.389-.375.804-.777 1.22a.417.417 0 0 0 .6.58c1.486-1.54 1.293-3.214.682-4.112z" />
                    </svg>
					<div class="community-hover-container hover-container">
						<div class="shadow community-hover-box hover-box">
							<a class="icon-item" href="/community/noticeForum">공지 및 행사</a> 
							<a class="icon-item" href="/community/inquiryForum">게시판 문의</a> 
							<a class="icon-item" href="/community/qaForum">자주묻는 질문</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</nav>
<nav class="nav navbar-light menu-bg">
	<div class="d-flex">
		<div class="menu-container">
			<div class="d-flex menu-item-box">
				<button class="btn menu-item" id="menu-item-dropdown0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					<a href="/bookCollection/searchBook">자료검색</a>
				</button>
				<ul class="dropdown-menu menu-item-dropdown" aria-labelledby="menu-item-dropdown0">
					<div class="d-flex dropdown-item-box">
						<li><a class="dropdown-item item" href="/bookCollection/searchBook"><p>통합검색</p></a></li>
						<li><a class="dropdown-item item" href="/bookCollection/popularBook"><p>인기도서</p></a></li>
					</div>
				</ul>
				<button class="btn menu-item" type="button" id="menu-item-dropdown1" data-bs-toggle="dropdown" aria-expanded="false">
					<a href="/bookInfo/returnOfLoan">도서이용안내</a>
				</button>
				<ul class="dropdown-menu menu-item-dropdown" aria-labelledby="menu-item-dropdown1">
					<div class="d-flex dropdown-item-box" style="padding-left: 117px;">
						<li><a class="dropdown-item item" href="/bookInfo/returnOfLoan"><p>대출/반납</p></a></li>
						<li><a class="dropdown-item item" href="/bookInfo/bookApply"><p>희망도서 신청</p></a></li>
					</div>
				</ul>
				<button class="btn menu-item" type="button" id="menu-item-dropdown2" data-bs-toggle="dropdown" aria-expanded="false">
					<a href="/facilityInfo/openHour">시설이용안내</a>
				</button>
				<ul class="dropdown-menu menu-item-dropdown" aria-labelledby="menu-item-dropdown2">
					<div class="d-flex dropdown-item-box" style="padding-left: 245px;">
						<li><a class="dropdown-item item" href="/facilityInfo/openHour"><p>개관시간</p></a></li>
						<li><a class="dropdown-item item" href="/facilityInfo/memberInfo"><p>이용자별안내</p></a></li>
						<li><a class="dropdown-item item" href="/facilityInfo/readingRoom"><p>열람실</p></a></li>
					</div>
				</ul>
				<button class="btn menu-item" type="button" id="menu-item-dropdown3" data-bs-toggle="dropdown" aria-expanded="false">
					<a href="/libraryInfo/summary">도서관소개</a>
				</button>
				<ul class="dropdown-menu menu-item-dropdown" aria-labelledby="menu-item-dropdown3">
					<div class="d-flex dropdown-item-box" style="padding-left: 495px;">
						<li><a class="dropdown-item item" href="/libraryInfo/summary"><p>개요</p></a></li>
						<li><a class="dropdown-item item" href="/libraryInfo/location"><p>오시는길</p></a></li>
					</div>
				</ul>
				<button class="btn menu-item" type="button" id="menu-item-dropdown4" data-bs-toggle="dropdown" aria-expanded="false">
					<a href="/community/noticeForum">커뮤니티</a>
				</button>
				<ul class="dropdown-menu menu-item-dropdown" aria-labelledby="menu-item-dropdown4">
					<div class="d-flex dropdown-item-box" style="padding-left: 554px;">
						<li><a class="dropdown-item item" href="/community/noticeForum"><p>공지&행사</p></a></li>
						<li><a class="dropdown-item item" href="/community/inquiryForum"><p>게시판 문의</p></a></li>
						<li><a class="dropdown-item item" href="/community/qaForum"><p>자주묻는 질문</p></a></li>
					</div>
				</ul>
				<c:choose>
				 <c:when test="${ sessionScope.id eq 'admin' }">
				 	<button class="btn menu-item menu-admin" type="button" id="menu-item-dropdown5" data-bs-toggle="dropdown" aria-expanded="false">
						<a href="/adminPage/dashboard">Admin Page</a>
					</button>
				 </c:when>
				 <c:otherwise>
					<button class="btn menu-item" type="button" id="menu-item-dropdown5" data-bs-toggle="dropdown" aria-expanded="false">
						<a href="/myLibrary/myLibrary">My Library</a>
					</button>
					<ul class="dropdown-menu menu-item-dropdown" aria-labelledby="menu-item-dropdown5">
						<div class="d-flex dropdown-item-box" style="justify-content: end; padding-right: 100px;">
							<li><a class="dropdown-item item" href="/myLibrary/bookmark"><p>내서재</p></a></li>
							<li><a class="dropdown-item item" href="/myLibrary/loanBook"><p>대출중인 도서</p></a></li>
							<li><a class="dropdown-item item" href="/myLibrary/overdueRecord"><p>연체/제재</p></a></li>
							<li><a class="dropdown-item item" href="/myLibrary/reservationBook"><p>예약도서</p></a></li>
							<li><a class="dropdown-item item" href="/myLibrary/changeInfo"><p>정보 변경</p></a></li>
						</div>
					</ul>
				</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="hamberger-box">
			<button class="hamberger" type="button">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</div>
</nav>