<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>인기도서 - 규비개발자 도서관</title>
    <link rel="icon" href="/img/main/digital-library.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/bookCollection/popularBook.css">
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
                        <span>자료검색</span>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/bookCollection/popularBook"><span>인기도서</span></a>
                    </div>
                </div>
                <div class="main-collection-wrap">
                    <div class="main-collection-box">
                        <div class="collection-title">
                            <h1>인기도서</h1>
                        </div>    
                        <div class="collection-main">
                            <div class="main-content">
                                <div class="content-box">
                                    <div class="d-flex book-count-wrap">
                                    	<div>
                                        	총 <span class="popular-list-count">${ listCount }</span> 권
                                        </div>
                                        <select class="select-count" name="popular-list-count">
											<option class="option" value="10" ${ listCount eq 10 ? 'selected' : '' }>10</option>
											<option class="option" value="15" ${ listCount eq 15 ? 'selected' : '' }>15</option>
											<option class="option" value="20" ${ listCount eq 20 ? 'selected' : '' }>20</option>
											<option class="option" value="30" ${ listCount eq 30 ? 'selected' : '' }>30</option>
											<option class="option" value="50" ${ listCount eq 50 ? 'selected' : '' }>50</option>
										</select>
                                    </div>
                                    <div class="d-flex book-list-box">
                                    	<c:forEach items="${ popularBookList }" var="popularBook">
                                        <a href="/bookCollection/bookDetail?isbn=${ popularBook.isbn }" class="book-box">
                                            <img src="${ popularBook.image }" alt="">
                                            <h5>${ popularBook.title }</h5>
                                            <p class="writer">${ popularBook.author }</p>
                                            <div class="loan-count-box">
                                                <p>대출횟수: <span class="count">${ popularBook.loanCount }</span></p>   
                                            </div>
                                        </a>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
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
	  //보여줄 도서리스트 갯수 선택시 수정 이벤트
	    $('.select-count').on('change', function(){
	    	var listCount = $('.select-count option:selected').val();
	    	location.href = '/bookCollection/popularBook?listCount='+ listCount;
	    })
    </script>
</body>