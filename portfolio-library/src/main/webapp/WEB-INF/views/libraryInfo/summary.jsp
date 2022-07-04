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
                        <span>도서관소개</span>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/libraryInfo/summary"><span>개요</span></a>
                    </div>
                </div>
                <div class="main-contents-wrap">
                    <div class="contents-box">
                        <div class="contents-title">
                            <h1>개요</h1>
                        </div>    
                        <div class="contents-main">
                            <div class="summary-top-bg">
                                <h3>세계를 보는 눈, 미래를 여는 힘</h3>
                                <h3>규빈개발자 도서관</h3>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
            <div class="contents-foot-wrap">
                <div class="contents-foot-box">
                    <div class="foot-title">
                        <h2>Endless challenges</h2>
                        <h2>and changes</h2>
                    </div>
                    <div class="foot-contents">
                        <p>부산대학교 도서관은 지속적인 변화를 통해 사람과 사람,</p>
                        <p>사람과 정보, 사람과 서비스의 연결 고리를 강화하여 새롭고 의미있는 것이</p>
                        <p>창출될 수 있도록 끊임없이 도전하고 있습니다.</p>
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