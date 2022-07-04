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
<link rel="stylesheet" href="/css/adminPage/book/reserveStatus.css">
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
				<h5>예약현황</h5>
				<div class="d-flex menu-route">
					<p>도서관리</p>
					<i class="fa-solid fa-angle-right"></i>
					<a href="/adminPage/book/reserveStatus">예약현황</a>
				</div>
			</div>
			<div class="admin-main-content">
				<div class="d-flex basic-background reserve-search-background " >
					<form action="/adminPage/book/reserveStatus" method="get">
						<ul class="d-flex reserve-search-box">
							<li>검색어</li>
							<div class="d-flex search-box">
								<select class="search-select" name="category">
									<option value="all" ${pageDto.category eq 'all' ? 'selected': '' }>전체</option>
									<option value="title" ${pageDto.category eq 'title' ? 'selected': '' }>도서명</option>
									<option value="bookNum" ${pageDto.category eq 'bookNum' ? 'selected': '' }>도서번호</option>
									<option value="name" ${pageDto.category eq 'name' ? 'selected': '' }>이름</option>
									<option value="id" ${pageDto.category eq 'id' ? 'selected': '' }>아이디</option>
								</select> 
								<input class="search-input" type="text" name="search" aria-label="Search" value="${ pageDto.search }">
							</div>
						</ul>
						<button class="search-btn">검색</button>
					</form>
				</div>
				<div class="reserve-list-wrap">
					<div class="reserve-count-box">
						<p>검색결과 : <span class="search-count">${ searchCount }</span> / 총 <span class="total-count">${ pageDto.totalCount eq null ? '0': pageDto.totalCount}</span>권</p>
					</div>
					<div class="basic-background reserve-list-background">
						<table>
							<thead>
								<tr>
									<th>번호</th>
									<th>아이디</th>
									<th>이름</th>
									<th>도서번호</th>
									<th>도서명</th>
									<th>예약일</th>
									<th>순번</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${ not empty reservationList  }">
								<c:forEach items="${ reservationList }" var="reservation" varStatus="status">
								<tr>
									<input class="reservation-num" type="hidden" value="${ reservation.num }"/>
									<td>${ pageDto.totalCount - (pageNum - 1) * pageDto.rowCount - status.index }</td>
									<td class="reservation-id">${ reservation.id }</td>
									<td>${ reservation.name  }</td>
									<td class="reservation-bookNum">${ reservation.bookNum }</td>
									<td>${ reservation.title }</td>
									<td>${ reservation.reserveDate }</td>
									<td>1</td>
									<td>
										<button class="basic-btn cancel-btn" type="button">예약취소</button>
									</td>
								</tr>
								</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<c:if test="${ not empty reservationList }">
					<div class="pagination-box">
						<nav class="reserve-list-pagination" aria-label="Page navigation">
							<ul class="pagination">
								<li class="page-item">
									<a class="page-link" href="/adminPage/book/reserveStatus?pageNum=1&category=${pageDto.category}&search=${pageDto.search}" aria-label="first">
										<span aria-hidden="true">
											<i class="fa-solid fa-backward"></i>
										</span>
									</a>
								</li>
								<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
								<li class="page-item">
									<a class="page-link" href="/adminPage/book/reserveStatus?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}" aria-label="Previous">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-left"></i>
										</span>
									</a>
								</li>
								</c:if>
								<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1"> 
								<li class="page-item">
									<a class="page-link ${ pageNum == i ? 'active' : ''}" href="/adminPage/book/reserveStatus?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}">
										${ i }
									</a>
								</li>
								</c:forEach>
								<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
								<li class="page-item">
									<a class="page-link" href="/adminPage/book/reserveStatus?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}" aria-label="Next">
										<span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
									</a>
								</li>
								</c:if>
								<li class="page-item">
									<a class="page-link" href="/adminPage/book/reserveStatus?pageNum=${ pageDto.pageCount }&category=${pageDto.category}&search=${pageDto.search}" aria-label="last">
										<span aria-hidden="true"><i class="fa-solid fa-forward"></i></span>
									</a>
								</li>
							</ul>
						</nav>
					</div>
					</c:if>	
				</div>

			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/percent.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
	<script>
		//예약신청 취소 이벤트
		$('.cancel-btn').click(function(){
			
			let cancelConfirm = confirm('도서예약을 취소하시겠습니까?');
			
			if(cancelConfirm) {
				
				let bookNum = $(this).parent().siblings('.reservation-bookNum').text();
				let id = $(this).parent().siblings('.reservation-id').text();
				
				$.ajax({
					method: 'DELETE',
					url:"/bookCollection/cancelReservation/"+ bookNum + "/" + id,	
				}).done(function(result){
					alert(result)
					location.reload();
				})
			}
		})

	</script>
</body>

</html>