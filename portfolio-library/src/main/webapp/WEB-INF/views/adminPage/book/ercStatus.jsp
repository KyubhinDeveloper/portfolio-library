<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>기타현황 - AdminPage</title>
<link rel="icon" href="/img/member/admin-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/adminPage/book/ercStatus.css">
</head>
<body>
	<div class="d-flex admin-page-wrap">
		<div class="admin-side-menu">
			<div class="side-title">
				<h3>
					<span>KYUBHIN</span><span>LIBRARY</span>
				</h3>
				<p>d e v e l o p e r</p>
				<span>규빈도서관</span>
			</div>
			<div class="side-item-wrap">
				<div class="side-item-box">
					<a href="/adminPage/dashboard" class="d-flex dashboard-box"> 
						<i class="fa-brands fa-deezer"></i> 
						<span>대시보드</span>
					</a>
				</div>
				<div class="side-item-box">
					<a href="/adminPage/member/management" class="d-flex userManagement-box"> 
						<i class="fa-solid fa-user-gear"></i> 
						<span>회원관리</span>
					</a>
				</div>
				<div class="side-item-box">
					<p class="item-box-title">도서관리</p>
					<div class="d-flex bookManagement-box">
						<a href="/adminPage/book/loanStatus">대출현황</a> 
						<a href="/adminPage/book/reserveStatus">예약현황</a> 
						<a href="/adminPage/book/ercStatus">기타현황</a>
						<a href="/adminPage/book/hopeList">희망도서</a>
						<a href="/adminPage/book/record">도서기록</a> 
					</div>
				</div>
				<div class="side-item-box">
					<p class="item-box-title">게시글관리</p>
					<div class="d-flex boardManagement-box">
						<a href="/adminPage/board/notice">공지사항</a>  
						<a href="/adminPage/board/inquiry">게시판문의</a>
					</div>
				</div>
				<div class="side-item-box return-box">
					<a href="/" class="d-flex userManagement-box">
						<i class="fa-solid fa-right-from-bracket"></i> 
					</a>
				</div>
			</div>
		</div>
		<div class="admin-main-wrap">
			<div class="d-flex admin-title-box">
				<h5>기타현황</h5>
				<div class="d-flex menu-route">
					<p>도서관리</p>
					<i class="fa-solid fa-angle-right"></i>
					<a href="/adminPage/book/ercStatus">기타현황</a>
				</div>
			</div>
			<div class="d-flex admin-main-content">
				<div class="overdue-status-wrap">
					<h5>연체현황</h5>
					<div class="d-flex basic-background overdue-search-background " >
						<div>
							<ul class="d-flex overdue-search-wrap">
								<li>검색어</li>
								<div class="d-flex search-box">
									<select class="search-select overdue-select" name="category">
										<option value="all">전체</option>
										<option value="title">도서명</option>
										<option value="bookNum">도서번호</option>
										<option value="name">이름</option>
										<option value="id">아이디</option>
									</select> 
									<input class="search-input overdue-search-input" type="text" name="search" aria-label="Search" value="">
								</div>
							</ul>
						</div>
						<div class="search-btn-box">
							<input class="search-btn overdue-search-btn" type="button" value="검색">
						</div>
					</div>
					<div class="overdue-list-wrap">
						<div class="overdue-count-box">
							<p>검색결과 : <span class="overdue-search-count">13</span> / 총 <span class="overdue-totalCount">13</span>권</p>
						</div>
						<div class="basic-background overdue-list-background">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>아이디</th>
										<th>이름</th>
										<th>도서번호</th>
										<th>도서명</th>
										<th>반납예정일</th>
										<th>연체일</th>
										<th>연체료</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
						<div class="overdue-pagination-box">
						</div>
					</div>
				</div>
				<div class="loss-status-wrap">
					<h5>분실현황</h5>
					<div class="d-flex basic-background loss-search-background " >
						<div>
							<ul class="d-flex loss-search-wrap">
								<li>검색어</li>
								<div class="d-flex search-box">
									<select class="search-select loss-select" name="category">
										<option value="all">전체</option>
										<option value="title">도서명</option>
										<option value="bookNum">도서번호</option>
										<option value="name">이름</option>
										<option value="id">아이디</option>
									</select> 
									<input class="search-input loss-search-input" type="text" name="search" aria-label="Search" value="">
								</div>
							</ul>
						</div>
						<div class="search-btn-box">
							<input class="search-btn loss-search-btn" type="button" value="검색">
						</div>
					</div>
					<div class="loss-list-wrap">
						<div class="loss-count-box">
							<p>검색결과 : <span class="loss-search-count">13</span> / 총 <span class="loss-totalCount">13</span>권</p>
						</div>
						<div class="basic-background loss-list-background">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>아이디</th>
										<th>이름</th>
										<th>도서번호</th>
										<th>도서명</th>
										<th>분실일</th>
										<th>반납예정일</th>
										<th>연체일</th>
										<th>연체료</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="loss-pagination-box">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/adminPage/book/ercStatus.js"></script>
	<script>

	</script>
</body>

</html>