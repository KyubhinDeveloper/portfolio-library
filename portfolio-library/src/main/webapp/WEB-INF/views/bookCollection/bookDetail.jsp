<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서상세 - 규비개발자 도서관</title>
    <link rel="icon" href="/img/main/digital-library.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/bookCollection/bookDetail.css">
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
                        <span>자료검색</span>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/bookCollection/searchBook"><span>통합검색</span></a>
                    </div>
                </div>
                <div class="main-collection-wrap">
                    <div class="main-collection-box">
                        <div class="collection-title">
                            <h1>도서상세</h1>
                        </div>    
                        <div class="collection-detail-box">
                            <div class="d-flex list-top-bg">
                                <div class="d-flex list-top-wrap">
                                    <div class="d-flex">
                                        <a href="#" class="d-flex list-top-item back">
                                            <i class="fa-solid fa-arrow-rotate-left"></i>
                                            <span>검색결과 돌아가기</span>
                                        </a>
                                        <a href="/bookCollection/searchBook" class="d-flex list-top-item">
                                            <i class="fa-solid fa-magnifying-glass"></i>
                                            <span>검색화면</span>
                                        </a>
                                    </div>
                                    <div class="d-flex list-top-item bookmark-item">
                                        <i class="fa-solid fa-bookmark"></i>
                                        <p>내 서재 담기</p>
                                    </div>
                                </div>
                            </div>
                            <div class="detail-content-bg">
                                <div class="d-flex detail-content-box">
                                    <img src="${book.image}" alt="">
                                    <div class="detail-text">
                                        <h3>${book.title}</h3>
                                        <div class="d-flex text-box">
                                            <p class="label">서명/책임사항</p>
                                            <p class="content title">${book.title}</p>
                                        </div>
                                         <div class="d-flex text-box">
                                            <p class="label">개인저자</p>
                                            <p class="content author">${book.author}</p>
                                        </div>
                                        <div class="d-flex text-box">
                                            <p class="label">발행사항</p>
                                            <p class="content"><span class="publisher">${book.publisher}</span> , <span class="pubdate" data-pubdate="${ book.pubdate }">${book.pubdate.substring(0,4)}</span></p>
                                        </div> 
                                        <div class="d-flex text-box">
                                            <p class="label">ISBN</p>
                                            <p class="content isbn">
                                                ${book.isbn.substring(book.isbn.length() - 17, book.isbn.length())}
                                            </p>
                                        </div>
                                        <c:if test="${ sessionScope.id eq 'admin' }">
	                                        <div class="d-flex text-box">
	                                        	<p class="label">기능</p>
	                                        <c:if test="${ check eq true }">
	                                  			<button type="button" class="btn use-all-btn">이용복구</button>
	                                  		</c:if>
	                                  		<c:if test="${ check eq false }">
												<button type="button" class="btn stop-all-btn">이용중지</button>
											</c:if>
	                                        </div>
                                        </c:if>	
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="book-loan-status">
                            <h3>소장정보</h3>
                            <div class="loan-status-box">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>등록번호</th>
                                            <th>도서상태</th>
                                            <th>반납예정일</th>
                                            <th>서비스</th>
                                            <c:if test="${ sessionScope.id eq 'admin' }">
                                            	<th>기능</th>
                                            </c:if>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="bookNum">K${ book.isbn.substring(book.isbn.length() - 11,book.isbn.length())}</td>
                                            <td class="loan-status">대출가능</td>
                                            <td class="loan-endDay"></td>
                                            <td class="book-service"><button class="btn loan-btn">대출하기</button></td>
                                            <c:if test="${ sessionScope.id eq 'admin' }">
                                            <td class="book-function"><button class="btn stop-btn">이용중지</button></td>
                                        	</c:if>
                                        </tr>
                                        <tr>
                                            <td class="bookNum">K${ book.isbn.substring(book.isbn.length() - 11,book.isbn.length())}-1</td>
                                            <td class="loan-status">대출가능</td>
                                            <td class="loan-endDay"></td>
                                            <td class="book-service"><button class="btn loan-btn">대출하기</button></td>
                                            <c:if test="${ sessionScope.id eq 'admin' }">
                                            	<td class="book-function"><button class="btn stop-btn">이용중지</button></td>
                                        	</c:if>
                                        </tr>
                                        <tr>
                                            <td class="bookNum">K${ book.isbn.substring(book.isbn.length() - 11,book.isbn.length())}-2</td>
                                            <td class="loan-status">대출가능</td>
                                            <td class="loan-endDay"></td>
                                            <td class="book-service"><button class="btn loan-btn">대출하기</button></td>
                                            <c:if test="${ sessionScope.id eq 'admin' }">
                                            	<td class="book-function"><button class="btn stop-btn">이용중지</button></td>
                                        	</c:if>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="book-summary-wrap">
                        	 <h3>줄거리</h3>
                        	 <p>19년 뒤의 킹스크로스역에서 다시 시작되는 이야기!J.K. 롤링과 잭 손, 존 티퍼니가 쓴 원작을 토대로 잭 손이 각색하여 탄생시킨 희곡 『해리포터와 저주받은 아이』 제1부.
                        	  79개 국어로 번역돼 4억 5,000만 부가 팔리며 유례를 찾기 힘들 만큼 폭발적인 반응을 일으킨 「해리 포터」 시리즈가 무려 9년 만에...</p>
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
    	var id = "${sessionScope.id}"
    	var isbn = "${book.isbn.substring(book.isbn.length() - 17, book.isbn.length()).replace('</b>','')}"
    
    </script>
    <script src="/js/bookCollection/bookDetail.js"></script>
</body>