<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>작성글</title>
<link rel="icon" href="/img/member/admin-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/adminPage/member/postList.css">
</head>
<body>
	<div class="post-info-top">
		<p><span>${ name }</span>(<span>${ id }</span>)님의 회원정보입니다.</p>
	</div>
	<div class="post-info-main">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link info-tab" aria-current="page" href="/adminPage/member/info?id=${ id }">회원정보</a></li>
			<li class="nav-item"><a class="nav-link postList-tab active" href="/adminPage/member/postList?id=${ id }">작성글</a></li>
		</ul>
		<div class="post-info-background">
			<div class="title">
				<h5>게시물 리스트</h5>
			</div>
			<div class="post-search-wrap">
				<form class="post-list-box" action="/adminPage/member/postList" method="get">
					<div class="d-flex post-search-item">
						<label>검색조건</label>
						<div class="d-flex search-item-box">
							<div class="d-flex search-box">
								<input type="hidden" name="id" value="${ id }"/>
								<select class="search-select" name="category">
									<option value="all" ${ pageDto.category eq 'all' ? 'selected' : '' }>전체</option>
									<option value="subject" ${ pageDto.category eq 'subject' ? 'selected' : '' }>제목</option>
									<option value="content" ${ pageDto.category eq 'content' ? 'selected' : '' }>내용</option>
								</select> 
								<input class="search-input" type="text" name="search" aria-label="Search" value="${ pageDto.search }">
							</div>
						</div>
					</div>
					<div class="d-flex search-bottom-box">
						<button class="btn info-btn search-btn">검색</button>
					</div>
				</form>
			</div>

			<div class="post-list-wrap">
				<div class="post-count-box">
					<c:if test="${ not empty inquiryList }">
					<p>검색결과 : <span class="search-count">${ searchCount }</span> / 총 <span class="total-count">${ pageDto.totalCount }</span>권</p>
					</c:if>
					<c:if test="${ empty inquiryList }">
					<p>검색결과 : <span class="search-count">0</span> / 총 <span class="total-count">0</span>권</p>
					</c:if>
				</div>
				<div class="basic-background post-list-background">
					<table>
						<thead>
							<tr>
								<th><input class="checkbox all-check" type="checkbox"></th>
								<th>번호</th>
								<th>제목</th>
								<th>등록일</th>
								<th>조회수</th>
								<th>댓글수</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${ not empty inquiryList }">
							<c:forEach items="${ inquiryList }" var="inquiry" varStatus="status"> 
							<tr>
								<input class="post-num" type="hidden" value="${ inquiry.num }"/>
								<td><input class="checkbox post-check" type="checkbox"></td>
								<td>${ pageDto.totalCount - (pageNum - 1) * pageDto.rowCount - status.index }</td>
								<td>${ inquiry.subject }</td>
								<td>${ inquiry.regDate.substring(0,10) }</td>
								<td>${ inquiry.views }</td>
								<td>${ cmCountList[status.index] }</td>
							</tr>
							</c:forEach>
							</c:if>
						</tbody>
					</table>
					<c:if test="${ empty inquiryList }">
					<div class="memo-none-box">
						<p>작성한 글이 없습니다.</p>
					</div>
					</c:if>
				</div>
				<c:if test="${ pageDto.pageCount gt 0 }">
				<div class="pagination-box">
					<nav class="post-list-pagination" aria-label="Page navigation">
						<ul class="pagination">
							<li class="page-item">
								<a class="page-link" href="/adminPage/member/postList?pageNum=1&category=${pageDto.category}&search=${pageDto.search}&id=${id}" aria-label="first">
									<span aria-hidden="true">
										<i class="fa-solid fa-backward"></i>
									</span>
								</a>
							</li>
							<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<li class="page-item">
								<a class="page-link" href="/adminPage/member/pageList?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}&id=${id}" aria-label="Previous">
									<span aria-hidden="true">
										<i class="fa-solid fa-angle-left"></i>
									</span>
								</a>
							</li>
							</c:if>
							<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1"> 
							<li class="page-item">
								<a class="page-link ${ pageNum == i ? 'active' : ''}" href="/adminPage/member/postList?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}&id=${id}">
									${ i }
								</a>
							</li>
							</c:forEach>
							<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<li class="page-item">
								<a class="page-link" href="/adminPage/member/postList?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}&id=${id}" aria-label="Next">
									<span aria-hidden="true">
										<i class="fa-solid fa-angle-right"></i>
									</span>
								</a>
							</li>
							</c:if>
							<li class="page-item">
								<a class="page-link" href="/adminPage/member/postList?pageNum=${ pageDto.pageCount }&category=${pageDto.category}&search=${pageDto.search}&id=${id}" aria-label="last">
									<span aria-hidden="true">
										<i class="fa-solid fa-forward"></i>
									</span>
								</a>
							</li>
						</ul>
					</nav>
				</div>
				</c:if>
				<div class="d-flex management-box">
					<h5>작성글일괄처리</h5>
					<button class="basic-btn delete-btn" type="button">작성글삭제</button>
					<p class="info">※체크한 작성글만 처리됩니다.</p>
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
	
		$('.close-btn').click(function(){
			window.close();
		})
		
		// 전체선택 이벤트
		$('.all-check').click(function(){
			
			if($(this).is(':checked')) {
				$('.post-check').prop('checked', true);
			} else {
				$('.post-check').prop('checked', false);
			}
		})
		
		//체크글 삭제
		$('.delete-btn').click(function(){
			
			let deleteConfirm = confirm('선택하신 글을 삭제 처리하겠습니까?');
			
			if(deleteConfirm) {
				
				let length = $('.post-check:checked').length;
				let numList = [];
				
				if(length > 0) {
					$('.post-check:checked').each(function(e){
						
						let num = $(this).parent().siblings('.post-num').val();
						numList.push(num);
					});
					
					var data = {num: numList}
					
					$.ajax({
						method: "DELETE",
						url: "/adminPage/member/deletePost",
						data: data
					}).done(function(){
						
						alert("선택하신 글이 삭제되었습니다.")
						location.reload();
						
					})
				}
			}
		})

	</script>
</body>

</html>