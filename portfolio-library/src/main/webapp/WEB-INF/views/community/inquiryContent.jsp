<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <link rel="stylesheet" href="/css/community/inquiryContent.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
    <div class="library-bg">
        <div class="shadow move-top-icon">
            <i class="fa-solid fa-arrow-up"></i>
        </div>
		<div class="shadow chat-icon-box">
			<img src="/img/main/chat-icon.png" alt="" />
		</div>
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
                        <div class="inquiry-content-wrap">
                            <div class=content-top-wrap>
                            	<input class="inquiry-num" type="hidden" value="${ inquiry.num }"/>
                                <h5>${ inquiry.subject }</h5>
                                <div class="d-flex content-data-box">
                                    <div class="d-flex data-box">
                                        <p class="title">작성자</p>
                                        <p class="content writer">${ inquiry.name.substring(0,1)+= "*".repeat(inquiry.name.length() - 1)}</p>
                                    </div>
                                    <div class="d-flex date-box data-box">
                                        <p class="title">작성일</p>
                                        <p class="content">${ inquiry.regDate.substring(0,10)}</p>
                                    </div>
                                    <div class="d-flex view-box data-box">
                                        <p class="title">조회수</p>
                                        <p class="content">${ inquiry.views }</p>
                                    </div>
                                </div>
                            </div>
                            <div class="content-main-wrap">
                                <p>${ inquiry.content }</p>
                            </div>
                            <c:if test="${ sessionScope.id eq inquiry.id or sessionScope.id eq 'admin'}">
	                            <div class="d-flex btn-box">
	                            	<a href="/community/editInquiry?pageNum=${pageNum}&num=${inquiry.num}"><button class="btn edit-btn">수정하기</button></a>
	                                <button class="btn delete-btn">삭제하기</button>
	                            </div>
                            </c:if>
                			<div class="list-btn-box">
                                <a href="/community/inquiryForum?pageNum=${pageNum}"><button class="btn list-btn">목록보기</button></a>
                            </div>
                            <div class="comment-wrap">
                                <div class="comment-list-wrap">
                                </div>
                                <nav class="navigation" aria-label="Page navigation">
                                </nav>
                            </div>
                            <c:if test="${ not empty sessionScope.id  }">
	                            <div class="comment-write-wrap">
	                                <h4>댓글 쓰기</h4>
	                                <div class="d-flex">
	                                    <textarea id="comment" cols="210" rows="2"></textarea>
	                                    <button class="comment-btn register-btn">등록</button>
	                                </div>
	                            </div>
                            </c:if>
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
    	var bno = "${inquiry.num}"; //페이지 글 번호
    	var id = "${sessionScope.id}" //로그인 아이디
    	var cmId = "${ inquiry.id }" //cmId == commentId 자성자 아이디
    	var name = "${sessionScope.name}" //로그인 이름
    	var pageNum = "${pageNum}" 
    	
    	$('.delete-btn').click(function(){
    		
    		let deleteConfirm = confirm('문의 글을 삭제하시겠습니까?')
    		
    		if(deleteConfirm) {
    			
        		let num = $('.inquiry-num').val();
        		
        		$.ajax({
        			method:"DELETE",
        			url:"/community/deleteInquiry?num=" + num + "&pageNum=" + pageNum 
        		}).done(function(){
        			alert('문의 글이 삭제되었습니다.');
        			location.href = "/community/inquiryForum";
        		})
        		
    		} //if()
    	})
    	
    </script>
   	<script src="/js/community/comment.js"></script>
</body>