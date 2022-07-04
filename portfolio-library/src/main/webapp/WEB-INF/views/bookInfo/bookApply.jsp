<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>희망도서 신청 - 규비개발자 도서관</title>
    <link rel="icon" href="/img/digital-library.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
        integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="/css/bookInfo/bookApply.css">
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
                        <a><span>도서이용안내</span></a>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/bookInfo/bookApply"><span>희망도서 신청</span></a>
                    </div>
                </div>
                <div class="main-bookInfo-wrap">
                    <div class="bookInfo-box">
                        <div class="bookInfo-title">
                            <h1>희망도서 신청</h1>
                            <a href="/myLibrary/applyPage">
                                <button class="btn application-btn">
                                    <i class="fa-solid fa-share"></i>희망도서 신청 바로가기
                                </button> 
                            </a>
                           
                        </div>   
                        
                        <div class="bookInfo-main">
                            <div class="main-wrap">
                                <div class="info-box">
                                    <div class="info-content active">
                                        <div class="info-item-box">
                                            <h5>이용대상</h5>
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>구분</th>
                                                        <th>상한금액(원)</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>일반회원</td>
                                                        <td>400,000</td>
                                                    </tr>
                                                    <tr>
                                                        <td>우대회원</td>
                                                        <td>600,000</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <ul>
                                                <li>개인별 신청 제한 기준 (연간, 당해연도 3월 ~ 익년 2월)</li>
                                                <li>국내서 / 국외서 포함</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>구입제한도서</h5>
                                            <ul>
                                                <li>만화, 청소년도서, 유아/아동용 도서</li>
                                                <li>판타지 / 로맨스 / 무협지 / 라이트 소설류</li>
                                                <li>초ㆍ중ㆍ고 교과서 및 참고서</li>
                                                <li>외설물</li>
                                                <li>문고본 및 낱장 형태의 자료</li>
                                                <li>전집 혹은 고가의 자료는 학과 추천서를 첨부하거나 도서관 내부 심의 후 구입 가능</li>
                                            </ul>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>유의사항</h5>
                                            <ul>
                                                <li>신청하고자 하는 자료가 도서관에 소장되어 있는지 확인 후 신청 (‘소장자료검색’ 이용)</li>
                                                <li>도서관에 소장되어 있지 않으나 수서과정에 있는 책(선정중, 주문중)을 신청한 경우에는 신청이 취소될 수 있음</li>
                                                <li>신청하는 자료의 서지정보(서명, 저자, 발행처, 발행년도, ISBN 등)를 정확하게 입력
                                                    <br>
                                                    입력한 사항이 부정확할 경우 신청이 취소될 수 있음
                                                </li>
                                                <li>신청한 자료가 입수되기까지 국내도서는 약 2~3주, 국외도서는 약 4~6주가 소요되나, 자료에 따라 입수기간이 많이 다를 수 있음</li>  
                                            </ul>
                                        </div>
                                    </div>
                                </div>               
                            </div>
                        </div>
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