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
    <link rel="stylesheet" href="/css/facilityInfo/memberInfo.css">
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
                        <span>시설이용안내</span>
                        <i class="fa-solid fa-angle-right"></i>
                       <a href="/facilityInfo/memberInfo"><span>이용자별안내</span></a>
                    </div>
                </div>
                <div class="main-useInfo-wrap">
                    <div class="useInfo-box">
                        <div class="useInfo-title">
                            <h1>이용자별안내</h1>
                        </div>    
                        <div class="useInfo-main">
                            <div class="main-wrap">
                                <div class="info-box">
                                    <div class="d-flex info-title" style="border-top: 1px solid #cfcfda">
                                        <h4>일반회원</h4>
                                        <i class="fa-solid fa-angle-down i-active"></i>
                                    </div>
                                    <div class="info-content active">
                                        <div class="info-item-box">
                                            <h5>대출 책수 및 기간</h5>
                                            <ul>
                                                <li>3책 이내, 책당 10일, 1회 연장 가능</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>이용 가능한 도서</h5>
                                            <ul>
                                                <li>도서관에서 제공하는 대부분의 도서 이용 가능</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>이용 가능한 서비스</h5>
                                            <ul>
                                                <li>희망도서 신청</li>
                                                <li>좌석배정(열람실), 그룹스터디룸 예약</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="info-box">
                                    <div class="d-flex info-title">
                                        <h4>우대회원</h4>
                                        <i class="fa-solid fa-angle-down"></i>
                                    </div>
                                    <div class="info-content">
                                        <div class="info-item-box">
                                            <h5>대출 책수 및 기간</h5>
                                            <ul>
                                                <li>5책 이내, 책당 20일, 2회 연장 가능</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>이용 가능한 도서</h5>
                                            <ul>
                                                <li>도서관에서 제공하는 대부분의 도서 이용 가능</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>이용 가능한 서비스</h5>
                                            <ul>
                                                <li>희망도서 신청</li>
                                                <li>좌석배정(열람실), 그룹스터디룸 예약</li>
                                            </ul>
                                        </div>
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
        $('.info-title').click(function(){
            if($(this).parent().children('.info-content').css('display') === 'none'){
                $('.info-content').slideUp();
                $('.fa-angle-down').css('transform','none');
                $(this).children('.fa-angle-down').css('transform','rotate(180deg)');
                $(this).parent().children('.info-content').slideToggle();
            } else {
                $('.fa-angle-down').css('transform','none');
                $(this).parent().children('.info-content').slideUp();
            } 
        })


    </script>
</body>