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
    <link href="/css/summernote/summernote-lite.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/community/editInquiry.css">
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
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                class="bi bi-house-door" viewBox="0 0 16 16">
                                <path
                                    d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
                            </svg>
                        </a>
                        <i class="fa-solid fa-angle-right"></i>
                        <h5>커뮤니티</h5>
                        <i class="fa-solid fa-angle-right"></i>
                        <a href="/community/editForum">
                            <h5>게시판 문의</h5>
                        </a>
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
                        <form class="inquiry-edit-wrap" action="/community/editInquiry?pageNum=${ pageNum }&num=${ inquiry.num }" method="post">
                        	<input type="hidden" name="_method" value="put" />
                            <div class="edit-top-box">
                                <div class="d-flex tag-box title-box">
                                    <label for="title-input">제목</label>
                                    <input id="title-input" class="title-input" type="text" name="subject" value="${inquiry.subject}">
                                </div>
                                <div class="d-flex tag-box">
                                    <label for="secret-check">옵션</label>
                                    <div class="d-flex secret-box">
                                        <input id="secret-check" class="secret-check" type="checkbox" name="secret" ${inquiry.secret == '비밀글' ? 'checked' : ''} value="${inquiry.secret}">
                                        <p>비밀글</p>
                                    </div>
                                </div>
                            </div>
                            <div class="edit-main-box">
                                <textarea id="summernote" name="content">${inquiry.content}</textarea>
                            </div>
                        </form>
                        <div class="d-flex edit-bottom-box">
                            <a href="/community/inquiryContent?pageNum=${ pageNum }&num=${ inquiry.num }"><button class="btn back-btn">돌아가기</button></a>
                            <button class="btn edit-btn">수정하기</button>
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
	<script src="/js/summernote-lite.js"></script>
 	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
    <script src="/js/main.js"></script>
    <script src="/js/community/notice.js"></script>
    <script>
    
    $('#secret-check').click(function(){
    	
    	if($('#secret-check').is(':checked')) {
    		$('#secret-check').val('비밀글');
    	} else {
    		$('#secret-check').val('일반글');
    	}
    })
    
	//수정버튼 이벤트
	$('.edit-btn').click(function() {

		let subject = $('#title-input').val();

		if (subject == "") {

			alert("제목은 필수 입력값입니다. 반드시 입력해 주세요.");
			
		} else {
			
			let editConfirm = confirm('게시물을 수정하시겠습니까?'); 
        	
        	if(editConfirm){ 
				$('.inquiry-edit-wrap').submit();
			}
		}
	})	

    </script>
</body>