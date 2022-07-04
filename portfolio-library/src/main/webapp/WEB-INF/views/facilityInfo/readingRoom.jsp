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
    <link rel="stylesheet" href="/css/facilityInfo/readingRoom.css">
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
                        <span>시설이용안내</span>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/facilityInfo/readingRoom"><span>열람실</span></a>
                    </div>
                </div>
                <div class="main-bookInfo-wrap">
                    <div class="bookInfo-box">
                        <div class="bookInfo-title">
                            <h1>열람실</h1>
                            <div class="info-item-box">
                                <h5>이용안내</h5>
                                <ul>
                                    <li>열람 좌석 이용은 도서관 홈페이지를 통해 배정받은 좌석만 이용 가능하며, 좌석 미배정 이용 시 도서관 이용이 제한될 수 있습니다.</li>
                                    <li>열람실 이용현황을 확인하거나 예약을 하시려면 <span style="color: #555; font-weight: bold;">열람실 이용현황 보기</span>를 이용하시기 바랍니다.
                                        <br>
                                        ※ 일부 열린 열람공간도 있습니다.(좌석 배정 없이 이용 가능)
                                    </li>
                                </ul>
                            </div>
                            <a href="/facilityInfo/roomStatus">
                                <button class="btn usageStatus-btn">
                                    <i class="fa-solid fa-arrow-up-right-from-square"></i>열람실 이용현황 보기
                                </button> 
                            </a>
                            
                        </div>   
                        
                        <div class="bookInfo-main">
                            <div class="main-wrap">
                                <div class="info-box">
                                    <div class="info-content active">
                                        <div class="info-item-box">
                                            <h5>열람실 현황</h5>
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>층 구분</th>
                                                        <th>열람실 구분</th>
                                                        <th>좌석 수</th>
                                                        <th>이용자격</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>2층</td>
                                                        <td>1열람실
                                                            <br>
                                                            (오픈형 열람실)
                                                        </td>
                                                        <td>154</td>
                                                        <td> 
                                                            <ul>
                                                                <li>자유 좌석제 운영</li>
                                                                <li>회원 가입자: 출입회원, 일반회원, 우대회원
                                                                    <br>
                                                                    <span class="tip">※ 일반회원은 <span style="color: red;">1열람실만 이용 가능</span></span> 
                                                                </li>
                                                                <li>지역주민: 1층 안내데스크에서 일일 출입증 발급</li>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>3층</td>
                                                        <td>2열람실
                                                            <br>
                                                            (칸막이 열람실)
                                                        </td>
                                                        <td>108</td>
                                                        <td> 
                                                            <ul>
                                                                <li>좌석배정시스템으로 운영(지정좌석제)</li>
                                                                <li>회원 가입자: 우대회원</li>
                                                                
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="info-item-box">
                                            <h5>이용문의</h5>
                                            <ul>
                                                <li>규빈개발자도서관 : 010-8285-5819</li>
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