<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>문의정보 - AdminPage</title>
<link rel="icon" href="/img/member/admin-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link href="/css/summernote/summernote-lite.css" rel="stylesheet">
<link rel="stylesheet" href="/css/adminPage/board/manageInquiry.css">
</head>
<body>
	<div class="manage-inquiry-top">
		<p><span>${ inquiry.name }</span>(<span>${ inquiry.id }</span>) 님의 문의 글입니다.</p>
	</div>
	<div class="manage-inquiry-main">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="/adminPage/board/manageInquiry?num=${ inquiry.num }">문의 정보</a></li>
			<li class="nav-item"><a class="nav-link" href="/adminPage/board/comment?bno=${ inquiry.num }">댓글 관리</a></li>
		</ul>
		<div class="manage-inquiry-background">
			<div class="title">
				<h5>문의글 관리</h5>
			</div>
            <div class="manage-inquiry-wrap">
                <div class=content-top-wrap>
                	<input class="inquiry-num" type="hidden" value="${ inquiry.num }"/>
                    <h5>${ inquiry.subject }</h5>
                    <div class="d-flex content-data-box">
                        <div class="d-flex data-box">
                            <p class="title">작성자</p>
                            <p class="content writer">${ inquiry.name }</p>
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
                 <div class="d-flex btn-box">
               	 	<a href="/adminPage/board/editInquiry?num=${inquiry.num}"><button class="btn edit-btn">수정하기</button></a>
                    <button class="btn delete-btn">삭제하기</button>
                 </div>
             </div>
             <div class="d-flex memo-bottom-box">
				<button class="basic-btn close-btn ">닫기</button>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/summernote-lite.js"></script>
 	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
 	<script>
 	//창 닫기
 	$('.close-btn').click(function() {
 		opener.parent.location.reload();
 		window.close();
 	})	
 	
 	//문의글 삭제
$('.delete-btn').click(function(){
	let deleteConfirm = confirm("공지글을 삭제하시겠습니까?")
	
	if(deleteConfirm) {
		let num = $('.inquiry-num').val();
		
		$.ajax({
			method:"DELETE",
			url:"/community/deleteNotice/"+ num
		}).done(function(result){	
			alert(result);
			opener.parent.location.reload();
			window.close();
		})
	} //if()
})
 	
 	
 	</script>
</body>

</html>