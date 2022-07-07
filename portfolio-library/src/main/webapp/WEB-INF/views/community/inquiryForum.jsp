<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/community/inquiryForum.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
    <div class="library-bg">
        <jsp:include page="/WEB-INF/views/include/menu.jsp" />
        <div class="library-main-bg">
            <div class="library-main-wrap">
                <div class="main-top-wrap">
                    <div class="d-flex top-box">
                        <a href="/">
                            <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
                                <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
                            </svg>
                        </a>
                        <i class="fa-solid fa-angle-right"></i>
                        <span>커뮤니티</span>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/community/inquiryForum"><span>게시판 문의</span></a>
                    </div>
                </div>
                <div class="main-community-wrap">
                    <div class="community-box">
                        <div class="community-title">
                            <h1>게시판 문의</h1>
                        </div>   
                        <div class="community-tab-bg">
                            <div class="community-tab-wrap">
                                <div class="d-flex community-tab-box">
                                    <a href="/community/noticeForum" class="tab">                                
                                        <p>공지 & 행사</p> 
                                    </a>
                                    <a href="/community/inquiryForum" class="tab active">
                                        <p>게시판 문의</p>
                                    </a>
                                    <a href="/community/qaForum" class="tab">
                                        <p>자주묻는 질문</p>
                                    </a>
                                </div>         
                            </div>
                        </div>
                        <div class="inquiry-table-wrap">
                            <div class="inquiry-search-wrap">
								<form class="d-flex search-box" action="/community/inquiryForum" method="get">
									<div class="d-flex">
										<select class="search-select" name="category">
											<option value="all" ${pageDto.category eq 'all' ? 'selected': '' }>전체</option>
											<option value="subject" ${pageDto.category eq 'subject' ? 'selected' : '' }>제목</option>
											<option value="content" ${pageDto.category eq 'content' ? 'selected' : '' }>내용</option>
										</select> 
										<input class="me-2 book-search" type="text" name="search" aria-label="Search" placeholder="검색어를 입력해주세요" value="${pageDto.search}">
									</div>
									<button class="btn search-btn" type="submit">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</form>
                            </div>
                            <div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>제목</th>
                                            <th>글쓴이</th>
                                            <th>작성일</th>
                                            <th>답변</th>
                                            <th>조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
	                                    <c:if test="${ not empty inquiryList  }">
											<c:forEach items="${ inquiryList }" var="inquiry" varStatus="status">
		                                        <tr>
		                                        	<input id="inquiry-num" type="hidden" value="${ inquiry.num }"/>
		                                            <td>${ pageDto.totalCount - (pageNum - 1) * pageDto.rowCount - status.index }</td>
		                                            <td class="title">
		                                                <a class="subject" href="#">${ inquiry.subject }</a> 
		                                                <c:if test="${ timeList[status.index] lt 1440}">
															<img class="icon" src="/img/community/ico_new.gif" alt="">
														</c:if>
		                                                <c:if test="${ inquiry.secret eq '비밀글' }"> 
	                                                		<img class="icon lock" src="/img/community/ico_lock.gif" alt="">
	                                                	</c:if>
		                                            </td>
		                                            <td>
		                                            	<input id="inquiry-id" type="hidden" value="${ inquiry.id }"/>
	                                            		<span class="id-box">${ nameList[status.index] } </span>
		                                            </td>
		                                            <td>${ inquiry.regDate.substring(0,10)}</td>
		                                            <td>
														${ inquiry.status }                                        
	                                            	</td>
		                                            <td>${ inquiry.views }</td>
		                                        </tr>
	                                        </c:forEach>
                                    	</c:if>           
                                    </tbody>
                                </table>
							<c:if test="${ not empty inquiryList }">
								<nav aria-label="Page navigation">
									<ul class="pagination inquiry-pagination">
										<c:if test="${ pageDto.pageCount ge 3}">
											<li class="page-item first">
												<a class="page-link" href="/community/inquiryForum?pageNum=1&category=${pageDto.category}&search=${pageDto.search}">
													<b><span>« </span>첫 페이지</b>
												</a>
											</li>
										</c:if>
										<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
											<li class="page-item prev"><a class="page-link"
												href="/community/inquiryForum?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}"
												aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>
										<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
											<li class="page-item ${ pageNum == i ? 'active' : ''}">
												<a class="page-link number" href="/community/inquiryForum?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}"> ${ i } </a>
											</li>
										</c:forEach>
										<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
											<li class="page-item next"><a class="page-link"
												href="/community/inquiryForum?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
										</c:if>
										<c:if test="${ pageDto.pageCount ge 3}">
											<li class="page-item last"><a class="page-link"
												href="/community/inquiryForum?pageNum=${pageDto.pageCount}&category=${pageDto.category}&search=${pageDto.search}"><b>끝 페이지 <span>»</span></b></a></li>
										</c:if>
									</ul>
								</nav>
							</c:if>
							<c:if test="${ not empty sessionScope.id }">
                                <div class="write-box"> 
                                    <a href="/community/writeInquiry"><button class="btn write-btn">글쓰기</button></a>
                                </div>
                            </c:if>    
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bottom-wrap">
                    <div class="d-flex bottom-box">
                        <div class="d-flex bottom-title item">
                            <div class="icon-box">
                                <i class="fa-solid fa-question"></i>
                            </div>
                            <h4>문의하기</h4>
                        </div>
                        <div class="d-flex inquiry-phone item">
                            <i class="fa-solid fa-headphones"></i>
                            <h5>010-8285-5819</h5>
                        </div>
                        <div class="d-flex inquiry-location item">
                            <i class="fa-solid fa-location-dot"></i>
                            <h5>규비개발자 도서관</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/include/footer.jsp" />
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/main.js"></script>
    <script>  
      	// += "*".repeat(inquiry.name.length() - 1)
    	$(".subject").click(function(){
    		
    		if($(this).parent().children('img').hasClass('lock')) {
    			
    			let sessionId = "${ sessionScope.id }";
        		let id = $(this).parent().siblings('.id-box').children('#inquiry-id').val();
        		
			 	if(id == sessionId || sessionId == 'admin'){
			 		let num = $(this).parent().siblings('#inquiry-num').val();
        			$(this).prop("href","/community/inquiryContent?num="+ num +"&pageNum=${pageNum}");
        		} else {
        			alert("비공개 문의내역은 작성자 본인만 확인하실 수 있습니다.");
        		} 
    		} else {
    			
    			let num = $(this).parent().siblings('#inquiry-num').val();
    			$(this).prop("href","/community/inquiryContent?num="+ num +"&pageNum=${pageNum}");
    		} 
    	})
    	
    	let length = $('.id-box').length;
      	let id;     	
      	let str;
      	
      	for(let i = 0; i < length; i++) {
      		id = $('.id-box').eq(i);
      		str = '*'.repeat(id.text().length - 2);
      		console.log(str);
      		let editStr = id.text().substring(0,1).concat(str);
      		id.text(editStr)
      	}
    	
    </script>
</body>