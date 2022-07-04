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
<link rel="stylesheet" href="/css/adminPage/book/hopeList.css">
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
				<h5>희망도서</h5>
				<div class="d-flex menu-route">
					<p>도서관리</p>
					<i class="fa-solid fa-angle-right"></i>
					<a href="/adminPage/book/hopeList">희망도서</a>
				</div>
			</div>
			<div class="admin-main-content">
				<div class="d-flex basic-background hopeBook-search-background " >
					<form action="/adminPage/book/hopeList" method="get">
						<ul class="d-flex hopeBook-status-box">
							<li>상태</li>
							<div class="d-flex check-list">
								<div class="d-flex check-box">
									<input class="status" type="checkbox" />
									<p>전체</p>
								</div>
								<div class="d-flex check-box">
									<input class="status" type="checkbox" name="status" value="대기중" ${status eq '대기중' ? 'checked': '' }/>
									<p>대기중</p>
								</div>
								<div class="d-flex check-box">
									<input class="status" type="checkbox" name="status" value="처리중" ${status eq '처리중' ? 'checked': '' }/>
									<p>처리중</p>
								</div>
								<div class="d-flex check-box">
									<input class="status" type="checkbox" name="status" value="정리중" ${status eq '정리중' ? 'checked': '' }/>
									<p>정리중</p>
								</div>
								<div class="d-flex check-box">
									<input class="status" type="checkbox" name="status" value="소장완료" ${status eq '소장완료' ? 'checked': '' }/>
									<p>소장완료</p>
								</div>
								<div class="d-flex check-box">
									<input class="status" type="checkbox" name="status" value="신청거부" ${status eq '신청거부' ? 'checked': '' }/>
									<p>신청거부</p>
								</div>
							</div>
						</ul>
						<ul class="d-flex hopeBook-search-box">
							<li>검색어</li>
							<div class="d-flex search-box">
								<select class="search-select" name="category">
									<option value="all" ${pageDto.category eq 'all' ? 'selected': '' }>전체</option>
									<option value="id" ${pageDto.category eq 'id' ? 'selected': '' }>아이디</option>
									<option value="title" ${pageDto.category eq 'title' ? 'selected': '' }>도서명</option>
								</select> 
								<input class="search-input" type="text" name="search" aria-label="Search" value="${ pageDto.search }">
							</div>
						</ul>
						<button class="search-btn">검색</button>
					</form>
				</div>
				<div class="hopeBook-list-wrap">
					<div class="hopeBook-count-box">
						<p>검색결과 : <span class="search-count">${ searchCount }</span> / 총 <span class="total-count">${ pageDto.totalCount eq null ? '0': pageDto.totalCount}</span>권</p>
					</div>
					<div class="basic-background hopeBook-list-background">
						<table>
							<thead>
								<tr>
									<th><input class="checkbox" type="checkbox" /></th>
									<th>번호</th>
									<th>아이디</th>
									<th>도서명</th>
									<th>저자</th>
									<th>출판사</th>
									<th>출판일</th>
									<th>isbn</th>
									<th>가격</th>
									<th>신청일</th>
									<th>상태</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${ hopeList }" var="hopeBook" varStatus="status">
								<tr>
									<input class="hopeBook-num" type="hidden" value="${ hopeBook.num }"/>
									<td><input class="checkbox hopeBook-check" type="checkbox" /></td>
									<td>${ pageDto.totalCount - (pageNum - 1) * pageDto.rowCount - status.index }</td>
									<td>${ hopeBook.id }</td>
									<td>${ hopeBook.title }</td>
									<td>${ hopeBook.author }</td>
									<td>${ hopeBook.publisher }</td>
									<td>${ hopeBook.pubdate }</td>
									<td>${ hopeBook.isbn }</td>
									<td>
										<c:if test="${ not empty hopeBook.price && hopeBook.price ne 0 }">
											<span>${ hopeBook.price }</span>
										</c:if>
									</td>
									<td>${ hopeBook.applyDate }</td>
									<td class="hopeBook-status">${ hopeBook.status }</td>
									<td>
										<c:if test="${ hopeBook.status eq '대기중' }">
											<button class="basic-btn approve-btn" type="button">신청승인</button>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="pagination-box">
						<nav class="hopeBook-list-pagination" aria-label="Page navigation">
							<ul class="pagination">
								<li class="page-item">
									<a class="page-link" href="/adminPage/book/hopeList?pageNum=1&category=${pageDto.category}&search=${pageDto.search}&status=${status}" aria-label="first">
										<span aria-hidden="true">
											<i class="fa-solid fa-backward"></i>
										</span>
									</a>
								</li>
								<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
								<li class="page-item">
									<a class="page-link" href="/adminPage/book/hopeList?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}&status=${status}" aria-label="Previous">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-left"></i>
										</span>
									</a>
								</li>
								</c:if>
								<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1"> 
								<li class="page-item">
									<a class="page-link ${ pageNum == i ? 'active' : ''}" href="/adminPage/book/hopeList?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}&status=${status}">
										${ i }
									</a>
								</li>
								</c:forEach>
								<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
								<li class="page-item">
									<a class="page-link" href="/adminPage/book/hopeList?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}&status=${status}" aria-label="Next">
										<span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
									</a>
								</li>
								</c:if>
								<li class="page-item">
									<a class="page-link" href="/adminPage/book/hopeList?pageNum=${ pageDto.pageCount }&category=${pageDto.category}&search=${pageDto.search}&status=${status}" aria-label="last">
										<span aria-hidden="true"><i class="fa-solid fa-forward"></i></span>
									</a>
								</li>
							</ul>
						</nav>
					</div>
					<div class="basic-background management-background">
						<div class="d-flex management-box">
							<h5>희망도서일괄처리</h5>
							<button class="basic-btn receive-btn" type="button">도서입고</button>
							<button class="basic-btn complete-btn" type="button ">소장완료</button>
							<button class="basic-btn refusal-btn" type="button">신청거부</button>
							<p class="info">※체크한 희망도서만 처리됩니다.</p>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="/js/adminPage/book/hope.js"></script>
</body>

</html>