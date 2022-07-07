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
    <link rel="stylesheet" href="/css/libraryInfo/libraryInfo.css">
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
                        <span>도서관소개</span>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/libraryInfo/location"><span>오시는길</span></a>
                    </div>
                </div>
                <div class="main-contents-wrap">
                    <div class="contents-box">
                        <div class="contents-title">
                            <h1>오시는길</h1>
                            <p>규빈개발자 도서관으로 오시는 길 안내입니다.</p>
                        </div>    
                        <div class="contents-main">
                            <div class="d-flex contents-location-top">
                                <div class="d-flex location-text-box text-box">
                                    <div class="location-icon">
                                        <i class="fa-solid fa-signs-post fa-2x"></i>
                                    </div>
                                    <h5>(08281) 서울특별시 구로구 구로동로47길 17-8 (구로동) 귺빈개발자 도서관</h5>
                                </div>
                                <div class="d-flex phone-text-box text-box">
                                    <div class="phone-icon">
                                        <i class="fa-solid fa-mobile-screen-button fa-2x"></i>
                                    </div>
                                    <h5>대표전화 : 010-8285-5819 / Fax. 02-000-0000</h5>
                                </div>
                            </div>
                            <div class="d-flex contents-location-main">
                                <div class="d-flex location-main-box main-box">
                                    <div class="map-icon">
                                        <i class="fa-solid fa-map-location-dot fa-2x"></i>
                                    </div>
                                    <div class="location-map-box">
                                        <a href="http://kko.to/eZMizbUDM">
                                            <img src="/img/summary/location.png">
                                        </a>
                                        <div class="d-flex map-text-box">
                                            <a href="https://map.kakao.com/?nil_profile=title&amp;nil_src=local">
                                                <img src="/img/summary/kakaomap.png">
                                            </a>
                                            <a href="http://kko.to/WZuwcbUYH">
                                                <p>로드뷰길찾기로 크게 보기</p>   
                                            </a>
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
</body>