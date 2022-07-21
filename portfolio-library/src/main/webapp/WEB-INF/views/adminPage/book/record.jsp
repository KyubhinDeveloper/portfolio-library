<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>예약내역 - AdminPage</title>
<link rel="icon" href="/img/member/admin-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/adminPage/book/record.css">
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
				<h5>도서기록</h5>
				<div class="d-flex menu-route-box">
					<p>도서관리</p>
					<i class="fa-solid fa-angle-right"></i>
					<a href="/adminPage/book/record">도서기록</a>
				</div>
			</div>
			<div class="d-flex admin-main-content">
				<div class="record-wrap">
					<h5>대출기록</h5>
					<div class="d-flex basic-background search-background">
					<form action="/adminPage/book/loanRecordeList" method="get">
						<ul class="d-flex type-wrap">
							<li>종류</li>
							<div class="d-flex check-list">
								<div class="d-flex check-box">
									<input class="type" type="checkbox" name="type" value=""/>
									<p>전체</p>
								</div>
								<div class="d-flex check-box">
									<input class="type" type="checkbox" name="type" value="정상반납" ${type eq '정상반납' ? 'checked': '' }/>
									<p>정상반납</p>
								</div>
								<div class="d-flex check-box">
									<input class="type" type="checkbox" name="type" value="연체반납" ${type eq '연체반납' ? 'checked': '' }/>
									<p>연체반납</p>
								</div>
								<div class="d-flex check-box">
									<input class="type" type="checkbox" name="type" value="분실반납" ${type eq '분실반납' ? 'checked': '' }/>
									<p>분실반납</p>
								</div>
							</div>
						</ul>
						<ul class="d-flex search-wrap">
							<li>검색어</li>
							<div class="d-flex search-box">
								<select class="loanRecord-search-select" name="category">
									<option value="all" ${pageDto.category eq 'all' ? 'selected': '' }>전체</option>
									<option value="title" ${pageDto.category eq 'title' ? 'selected': '' }>도서명</option>
									<option value="bookNum" ${pageDto.category eq 'bookNum' ? 'selected': '' }>도서번호</option>
									<option value="id" ${pageDto.category eq 'id' ? 'selected': '' }>아이디</option>
									<option value="name" ${pageDto.category eq 'name' ? 'selected': '' }>이름</option>
								</select> 
								<input class="search-input loanRecord-search-input" type="text" name="search" aria-label="Search" value="${ pageDto.search }">
							</div>
						</ul>
						<button type="button" class="search-btn loanRecord-search-btn">검색</button>
					</form>
					</div>
					<div class="record-list-box">
						<div class="record-count-box">
							<p>검색결과 : <span class="search-count loanRecord-search-count">13</span> / 총 <span class="loanRecord-totalCount">13</span>권</p>
						</div>
						<div class="basic-background loanRecord-list-table loan-record">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>아이디</th>
										<th>이름</th>
										<th>도서번호</th>
										<th>도서명</th>
										<th>대출일</th>
										<th>반납일</th>
										<th>종류</th>	
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="num">1</td>
										<td class="id">lve2514</td>
										<td class="name">한규빈</td>
										<td class="bookNum">K3928450</td>
										<td class="title">해리 포터와 비밀의 방 (미나리마 에디션)</td>
										<td class="loanDate">2022.04.17</td>
										<td class="returnDate">2022.04.30</td>
										<td class="status">정상반납</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="pagination-box loanRecord-pagination-box">
							<nav class="record-pagination" aria-label="Page navigation">
								<ul class="pagination">
									<li class="page-item">
										<a class="page-link" href="#" aria-label="first">
											<span aria-hidden="true"><i class="fa-solid fa-backward"></i></span>
										</a>
									</li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="Previous">
											<span aria-hidden="true"><i class="fa-solid fa-angle-left"></i></span>
										</a>
									</li>
									<li class="page-item"><a class="page-link active" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="Next">
											<span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
										</a>
									</li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="last">
											<span aria-hidden="true"><i class="fa-solid fa-forward"></i></span>
										</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
				<div class="record-wrap">
					<h5>연체기록</h5>
					<div class="d-flex basic-background search-background " >
						<div>
							<ul class="d-flex search-wrap">
								<li>검색어</li>
								<div class="d-flex search-box">
									<select class="overdueRecord-search-select" name="category">
										<option value="all" ${pageDto.category eq 'all' ? 'selected': '' }>전체</option>
										<option value="title" ${pageDto.category eq 'title' ? 'selected': '' }>도서명</option>
										<option value="bookNum" ${pageDto.category eq 'bookNum' ? 'selected': '' }>도서번호</option>
										<option value="id" ${pageDto.category eq 'id' ? 'selected': '' }>아이디</option>
										<option value="name" ${pageDto.category eq 'name' ? 'selected': '' }>이름</option>
									</select> 
									<input class="search-input overdueRecord-search-input" type="text" name="search" aria-label="Search" value="${ pageDto.search }">
								</div>
							</ul>
						</div>
						<div class="search-btn-box">
							<input class="search-btn overdueRecord-search-btn" type="button" value="검색">
						</div>
					</div>
					<div class="record-list-box">
						<div class="record-count-box">
							<p>검색결과 : <span class="search-count overdueRecord-search-count">13</span> / 총 <span class="totalCount overdueRecord-totalCount">13</span>권</p>
						</div>
						<div class="basic-background overdueRecord-list-table overdue-record">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>아이디</th>
										<th>이름</th>
										<th>도서번호</th>
										<th>도서명</th>
										<th>반납일</th>
										<th>연체일</th>
										<th>연체료</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="num">1</td>
										<td class="id">lve2514</td>
										<td class="name">한규빈</td>
										<td class="bookNum">K3928450</td>
										<td class="title">해리 포터와 비밀의 방 (미나리마 에디션)</td>
										<td class="returnDate">2022.04.30</td>
										<td><span class="overdueDate">28</span>일</td>
										<td><span class="latefee">2800</span>원</td>
									</tr>							
								</tbody>
							</table>
						</div>
						<div class="pagination-box overdueRecord-pagination-box">
							<nav class="record-pagination" aria-label="Page navigation">
								<ul class="pagination">
									<li class="page-item">
										<a class="page-link" href="#" aria-label="first">
											<span aria-hidden="true"><i class="fa-solid fa-backward"></i></span>
										</a>
									</li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="Previous">
											<span aria-hidden="true"><i class="fa-solid fa-angle-left"></i></span>
										</a>
									</li>
									<li class="page-item"><a class="page-link active" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="Next">
											<span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
										</a>
									</li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="last">
											<span aria-hidden="true"><i class="fa-solid fa-forward"></i></span>
										</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
				<div class="record-wrap">
					<h5>분실기록</h5>
					<div class="d-flex basic-background search-background " >
						<div>
							<ul class="d-flex search-wrap">
								<li>검색어</li>
								<div class="d-flex search-box">
									<select class="lossRecord-search-select" name="category">
										<option value="all" ${pageDto.category eq 'all' ? 'selected': '' }>전체</option>
										<option value="title" ${pageDto.category eq 'title' ? 'selected': '' }>도서명</option>
										<option value="bookNum" ${pageDto.category eq 'bookNum' ? 'selected': '' }>도서번호</option>
										<option value="id" ${pageDto.category eq 'id' ? 'selected': '' }>아이디</option>
										<option value="name" ${pageDto.category eq 'name' ? 'selected': '' }>이름</option>
									</select> 
									<input class="search-input lossRecord-search-input" type="text" name="search" aria-label="Search" value="${ pageDto.search }">
								</div>
							</ul>
						</div>
						<div class="search-btn-box">
							<input class="search-btn lossRecord-search-btn" type="button" value="검색">
						</div>
					</div>
					<div class="record-list-box">
						<div class="record-count-box">
							<p>검색결과 : <span class="search-count lossRecord-search-count">13</span> / 총 <span class="totalCount lossRecord-totalCount">13</span>권</p>
						</div>
						<div class="basic-background lossRecord-list-table loss-record">
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>아이디</th>
										<th>이름</th>
										<th>도서번호</th>
										<th>도서명</th>
										<th>분실일</th>
										<th>반납일</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="num">1</td>
										<td class="id">lve2514</td>
										<td class="name ">한규빈</td>
										<td class="bookNum">K3928450</td>
										<td class="title">해리 포터와 비밀의 방 (미나리마 에디션)</td>
										<td class="loanDate">2022.04.30</td>
										<td class="returnDate">2022.05.25</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="pagination-box lossRecord-pagination-box">
							<nav class="record-pagination" aria-label="Page navigation">
								<ul class="pagination">
									<li class="page-item">
										<a class="page-link" href="#" aria-label="first">
											<span aria-hidden="true"><i class="fa-solid fa-backward"></i></span>
										</a>
									</li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="Previous">
											<span aria-hidden="true"><i class="fa-solid fa-angle-left"></i></span>
										</a>
									</li>
									<li class="page-item"><a class="page-link active" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="Next">
											<span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
										</a>
									</li>
									<li class="page-item">
										<a class="page-link" href="#" aria-label="last">
											<span aria-hidden="true"><i class="fa-solid fa-forward"></i></span>
										</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/adminPage/book/record.js"></script>
</body>

</html>