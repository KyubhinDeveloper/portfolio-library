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
<link rel="stylesheet" href="/css/adminPage/board/editInquiry.css">
</head>
<body>
	<div class="edit-inquiry-top">
		<p><span>${ inquiry.name }</span>(<span>${ inquiry.id }</span>) 님의 문의 글입니다.</p>
	</div>
	<div class="edit-inquiry-main">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="/adminPage/board/manageInquiry?num=${ inquiry.num }">문의 정보</a></li>
			<li class="nav-item"><a class="nav-link" href="/adminPage/member/postList?id=${ memberVo.id }">댓글 관리</a></li>
		</ul>
		<div class="edit-inquiry-background">
			<div class="title">
				<h5>문의글 수정</h5>
			</div>
            <form class="inquiry-edit-wrap" action="/adminPage/board/editInquiry?num=${ inquiry.num }" method="post">
            	<input type="hidden" name="_method" value="put" />
                <div class="edit-top-box">
                    <div class="d-flex tag-box title-box">
                        <label for="title-input">제목</label>
                        <input id="title-input" class="title-input" type="text" name="subject" value="${inquiry.subject}">
                    </div>
                    <div class="d-flex tag-box">
                        <label for="secret-check">옵션</label>
                        <div class="d-flex secret-box">
                            <input id="secret-check" class="secret-check" type="checkbox" name="secret" ${inquiry.secret == '비밀글' ? 'checked' : ''} value="${ inquiry.secret }">
                            <p>비밀글</p>
                        </div>
                    </div>
                </div>
                <div class="edit-main-box">
                    <textarea id="summernote" name="content">${inquiry.content}</textarea>
                </div>
	            <div class="d-flex edit-bottom-box">
	                <a href="/adminPage/board/manageInquiry?num=${ inquiry.num }"><button class="btn back-btn">돌아가기</button></a>
	                <button type="button" class="btn edit-btn">수정하기</button>
	            </div>   
            </form>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/summernote-lite.js"></script>
 	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
 	<script>
	 	$("#summernote").summernote({
	 		toolbar: [
	 		    // [groupName, [list of button]]
	 		   ['fontname', ['fontname']],
	 		   ['fontsize', ['fontsize']],
	 		   ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	 		   ['color', ['forecolor','color']],
	 		   ['table', ['table']],
	 		   ['para', ['ul', 'ol', 'paragraph']],
	 		   ['height', ['height']],
	 		   ['insert',['picture','link','video']],
	 		   ['view', ['fullscreen', 'help']]
	 		],
	 		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
	 		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],	
	 		height: 250,
	 		minHeight: null,
	 		maxHeight: null,
	 		focus: true, 
	 		lang: "ko-KR",
	 		disableResizeEditor: true,
	 		callbacks: { //이미지 첨부부분
	 			onImageUpload : function(files) {
	 				uploadSummernoteImageFile(files[0],this);
	 			},
	 			onPaste: function (e) {
	 				var clipboardData = e.originalEvent.clipboardData;
	 				if (clipboardData && clipboardData.items && clipboardData.items.length) {
	 					var item = clipboardData.items[0];
	 					if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
	 						e.preventDefault();
	 					}
	 				}
	 			}
	 		}	
	 	})
	
	 	// 써머노트 이미지 파일 업로드
	 	function uploadSummernoteImageFile(file, editor) {
	 		
	 		data = new FormData();
	 		data.append("file", file);
	 		
	 		$.ajax({
	 			method : "POST",
	 			url : "/community/summernote",
	 			data : data,
	 			contentType : false,
	 			processData : false,
	 			success : function(data) {
	 	        	//항상 업로드된 파일의 url이 있어야 한다.
	 			   $(editor).summernote('insertImage', data.url);
	 			}
	 		});
	 	}
	 	
	 	//비밀글 체크 값
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

</html>