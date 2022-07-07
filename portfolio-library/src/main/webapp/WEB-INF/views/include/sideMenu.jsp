<%@ page language="java" contentType="text; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="side-menu-bg">
	<div class="side-menu-wrap">
		<div class="d-block d-lg-none side-menu2">
			<div class="d-flex side-login-wrap">
				<c:choose>
					<c:when test="${ not empty sessionScope.id }">
						<div class="logout-box">
							<img src="/img/main/user_thumb_basic.png" alt=""> 
							<div>
								<span>${ sessionScope.name }</span>님
							</div>
							<a href="/member/logout"><button class="btn button logout-btn">로그아웃</button></a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="login-box">
							<img src="/img/main/user_thumb_basic.png" alt=""> 
							<a href="/member/login">로그인하세요</a>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="side-menu-close">
					<i class="fa-solid fa-xmark"></i>
				</div>
			</div>
			<div class="d-flex side-menu-main2">
				<div class="side-menu-tab2">
					<a href="#" id='bookCollection' class="tab-title2">
						<h3>자료검색</h3>
					</a> 
					<a href="#" id='bookInfo' class="tab-title2">
						<h3>도서이용안내</h3>
					</a> 
					<a href="#" id="roomInfo" class="tab-title2">
						<h3>시설이용안내</h3>
					</a> 
					<a href="#" id="libraryInfo" class="tab-title2">
						<h3>도서관소개</h3>
					</a> 
					<a href="#" id="community" class="tab-title2">
						<h3>커뮤니티</h3>
					</a> 
					<c:if test="${ not empty sessionScope.id and sessionScope.id ne 'admin' }">
						<a href="#" id="myLibrary" class="tab-title2">
							<h3>My Library</h3>
						</a>
					</c:if>
					<c:if test="${ not empty sessionScope.id and sessionScope.id eq 'admin' }">
						<a href="/adminPage/dashboard" id="Admin Library" class="tab-title2">
							<h3>Admin Library</h3>
						</a>
					</c:if>
				</div>
				<div class="tab-contents-wrap">
					<ul id='bookCollection' class="tab-contents2">
						<li><a href="/bookCollection/searchBook">통합검색</a></li>
						<li><a href="/bookCollection/popularBook">인기도서</a></li>
					</ul>
					<ul id='bookInfo' class="tab-contents2">
						<li><a href="/bookInfo/returnOfLoan">대출/반납</a></li>
						<li><a href="/bookInfo/bookApply">희망도서 신청</a></li>
					</ul>
					<ul id='roomInfo' class="tab-contents2 ">
						<li><a href="/facilityInfo/openHour">개관시간</a></li>
						<li><a href="/facilityInfo/memberInfo">이용자별안내</a></li>
						<li><a href="/facilityInfo/readingRoom">열람실</a></li>
					</ul>
					<ul id='libraryInfo' class="tab-contents2">
						<li><a href="/libraryInfo/summary">개요</a></li>
						<li><a href="/libraryInfo/location">오시는길</a></li>
					</ul>
					<ul id='community' class="tab-contents2">
						<li><a href="/community/noticeForum">공지&행사</a></li>
						<li><a href="/community/inquiryForum">게시판 문의</a></li>
						<li><a href="/community/qaforum">자주묻는 질문</a></li>
					</ul>
					<ul id='myLibrary' class="tab-contents2">
						<li><a href="/myLibrary/bookmark">내서재</a></li>
						<li><a href="/myLibrary/loanBook">대출중인 도서</a></li>
						<li><a href="/myLibrary/overdueRecord">연체/제재</a></li>
						<li><a href="/myLibrary/reservationBook">예약도서</a></li>
						<li><a href="/myLibrary/changeInfo">정보 변경</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="d-none d-lg-block side-menu">
			<div class="side-menu-top">
				<div class="d-none d-lg-block side-menu-close">
					<i class="fa-solid fa-xmark"></i>
				</div>
				<div class="d-none d-lg-flex justify-content-center">
					<a class="d-flex navbar-brand library-brand" href="/">
						<img class="brand-img" src="/img/main/digital-library.png" alt="">
						<div class="brand-text">
							<h4>규비개발자 도서관</h4>
							<p>KYUBHIN HAN DEVELOPER LIBRARY</p>
						</div>
					</a>
				</div>
			</div>
			<div class="d-flex side-menu-main">
				<div class="side-menu-tab">
					<a href="/bookCollection/searchBook" class="tab-title">
						<h3>자료검색</h3>
					</a>
					<div class="tab-contents">
						<li><a href="/bookCollection/searchBook">통합검색</a></li>
						<li><a href="/bookCollection/popularBook">인기도서</a></li>
					</div>
				</div>
				<div class="side-menu-tab">
					<a href="/bookInfo/returnOfLoan" class="tab-title">
						<h3>도서이용안내</h3>
					</a>
					<ul class="tab-contents">
						<li><a href="/bookInfo/returnOfLoan">대출/반납</a></li>
						<li><a href="/bookInfo/bookApply">희망도서 신청</a></li>
					</ul>
				</div>
				<div class="side-menu-tab">
					<a href="/facilityInfo/openHour" class="tab-title">
						<h3>시설이용안내</h3>
					</a>
					<ul class="tab-contents">
						<li><a href="/facilityInfo/openHour">개관시간</a></li>
						<li><a href="/facilityInfo/memberInfo">이용자별안내</a></li>
						<li><a href="#">열람실</a></li>
					</ul>
				</div>
				<div class="side-menu-tab">
					<a href="/libraryInfo/summary" class="tab-title">
						<h3>도서관소개</h3>
					</a>
					<ul class="tab-contents">
						<li><a href="/libraryInfo/summary">개요</a></li>
						<li><a href="/libraryInfo/location">오시는길</a></li>
					</ul>
				</div>
				<div class="side-menu-tab">
					<a href="/community/noticeForum" class="tab-title">
						<h3>커뮤니티</h3>
					</a>
					<ul class="tab-contents">
						<li><a href="/community/noticeForum">공지&행사</a></li>
						<li><a href="/community/inquiryForum">게시판 문의</a></li>
						<li><a href="/community/qaforum">자주묻는 질문</a></li>
					</ul>
				</div>
				<c:if test="${ not empty sessionScope.id and sessionScope.id ne 'admin' }">
					<div class="side-menu-tab">
						<a href="/myLibrary/myLibrary" class="tab-title">
							<h3>My Library</h3>
						</a>
						<ul class="tab-contents">
							<li><a href="/myLibrary/bookmark">내서재</a></li>
							<li><a href="/myLibrary/loanBook">대출중인 도서</a></li>
							<li><a href="/myLibrary/overdueRecord">연체/제재</a></li>
							<li><a href="/myLibrary/reservationBook">예약도서</a></li>
							<li><a href="/myLibrary/changeInfo">정보 변경</a></li>
						</ul>
					</div>
				</c:if>
				<c:if test="${ not empty sessionScope.id and sessionScope.id eq 'admin' }">
					<div class="side-menu-tab">
						<a href="/adminPage/dashboard" class="tab-title">
							<h3>Admin Library</h3>
						</a>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>