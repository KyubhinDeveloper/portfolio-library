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
    <link rel="stylesheet" href="/css/community/qaForum.css">
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
                        <a href="/community/qaForum"><span>자주묻는 질문</span></a>
                    </div>
                </div>
                <div class="main-community-wrap">
                    <div class="community-box">
                        <div class="community-title">
                            <h1>자주묻는 질문</h1>
                        </div>
                        <div class="community-tab-bg">
                            <div class="community-tab-wrap">
                                <div class="d-flex community-tab-box">
                                    <a href="/community/noticeForum" class="tab">                                
                                        <p>공지 & 행사</p> 
                                    </a>
                                    <a href="/community/inquiryForum" class="tab">
                                        <p>게시판 문의</p>
                                    </a>
                                    <a href="/community/qaForum" class="tab active">
                                        <p>자주묻는 질문</p>
                                    </a>
                                </div>         
                            </div>
                        </div>    
                        <div class="questions-main">
                            <div class="main-wrap">
                                <div class="questions-box">
                                    <div class="d-flex questions-title">
                                        <h4>희망도서 신청 방법은?</h4>
                                     	<i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="answer-content">
                                        <div class="answer-item-box">
                                            <h5>희망도서 신청</h5>
                                            <ul>
                                                <li>신청하고자 하는 자료가 도서관에 소장되어 있는지 확인 후 신청.</li>
                                                <li>만화 / 판타지 / 로맨스 / 무협지 / 라이트 소설류 등은 구입이 제한됩니다.</li>
                                                <li>자세한 사항은 <a class="answer-link" href="/bookInfo/bookApply">희망도서 신청</a> 을 참고하세요.</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="questions-box">
                                    <div class="d-flex questions-title">
                                        <h4>대출 가능 책수, 기간, 대출/반납 방법은 어떻게 되나요?</h4>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="answer-content">
                                        <div class="answer-item-box">
                                            <h5>대출 책수 및 기간</h5>
                                            <ul>
                                                <li>대출 기간은 토요일, 공휴일 및 도서관 휴관일 등을 포함하여 계산됩니다. 신분별 대출 가능 책수, 기간은 <a class="answer-link" href="/bookInfo/returnOfLoan">대출 가능 책수, 기간</a> 링크를 참고하세요. </li>
                                            </ul>
                                        </div>
                                        <div class="answer-item-box">
                                            <h5>대출/반납</h5>
                                            <ul>
                                                <li>대출한 자료는 반납 예정일 내에 대출 하였던 도서관에 반납하는 것을 원칙으로 합니다. 자세한 사항은 <a class="answer-link" href="/bookInfo/returnOfLoan">대출/반납</a> 링크를 참고하세요.</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="questions-box">
                                    <div class="d-flex questions-title">
                                        <h4>도서 대출 연장, 예약 방법은 어떻게 되나요?</h4>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="answer-content">
                                        <div class="answer-item-box">
                                            <h5>대출 연장</h5>
                                            <ul>
                                                <li>대출한 자료는 1회에 한하여 연장 가능합니다. 자세한 사항은 <a class="answer-link" href="/bookInfo/returnOfLoan">대출 연장</a> 링크를 참고 하세요.</li>
                                            </ul>
                                        </div>
                                        <div class="answer-item-box">
                                            <h5>도서 예약</h5>
                                            <ul>
                                                <li>도서 예약은 중앙도서관의 단행본만 예약이 가능합니다. 자세한 사항은 <a class="answer-link" href="/bookInfo/returnOfLoan">도서 예약</a> 링크를 참고 하세요.</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <c:forEach items="${ qaVo }" var="qa">
                                 <div class="questions-box">
                                    <div class="d-flex questions-title">
                                        <h4>${ qa.question }</h4>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="answer-content">
                                        <div class="answer-item-box">
                                        	<ul>
                                        		<li>${ qa.answer }</li>
                                        	</ul>
                                        	<c:if test="${ id eq 'admin' }">
	                                        	<div class="d-flex">
	                                        		<input type="hidden" value="${ qa.num }"/>
	                                        		<button class="btn delete-btn">삭제하기</button>
	                                        	</div>
                                        	</c:if>
                                        </div>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>
                        </div>
                        <c:if test="${ id eq 'admin' }">
	                        <div class="question-write-wrap">
	                            <form class="write-box" action="/community/writeQa" method="post">
	                                <div class="d-flex question-box">
	                                    <label for="question-input">질문</label>
	                                    <input id="question-input" class="question-input" name="question" type="text">
	                                </div>
	                                <div class="d-flex answer-box">
	                                    <label for="answer-input">답변</label>
	                                    <textarea id="answer-input" class="answer-input" name="answer" cols="160" rows="10"></textarea>
	                                </div>
	                            </form>
	                            <div class="write-bottom-box">
	                                <button class="btn register-btn">등록하기</button>
	                            </div>
	                        </div>
                        </c:if>
                    </div>
                </div>
                <div class="inquiry-wrap">
                    <div class="d-flex inquiry-box">
                        <div class="d-flex inquiry-title item">
                            <div class="">
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
        $('.questions-title').click(function(){
            if($(this).parent().children('.answer-content').css('display') === 'none'){
                $('.answer-content').slideUp();
                $('.fa-angle-down').css('transform','none');
                $(this).children('.fa-angle-down').css('transform','rotate(180deg)');
                $(this).parent().children('.answer-content').slideToggle();
            } else {
                $('.fa-angle-down').css('transform','none');
                $(this).parent().children('.answer-content').slideUp();
            } 
        })
        
        $('.register-btn').click(function(){
        	
        	if($('#question-input').val() == "" || $('#answer-input').val() == "") {
        		
        		alert('질문과 답변을 모두 입력해 주세요');
  
        	} else {
  	      		
    			$('.write-box').submit();    		
        	}
        })
        
        $('.delete-btn').click(function(){
        	
        	let deleteConfirm = confirm('정말로 질문을 삭제하시겠습니까?'); 
        	
        	if(deleteConfirm){
        		
        		let num = $(this).prev().val();
        		
        		$.ajax({
            		method:"DELETE",
            		url:"/community/deleteQa/" + num
            	}).done(function(result){
            		alert(result);
            		location.reload(true);
            	})
        		
        	}      	
        })


    </script>
</body>