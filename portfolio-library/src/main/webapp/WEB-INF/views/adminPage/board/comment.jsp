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
<link rel="stylesheet" href="/css/adminPage/board/comment.css">
</head>
<body>
	<div class="manage-comment-top">
		<p><span>${ inquiry.name }</span>(<span>${ inquiry.id }</span>) 님의 문의 글입니다.</p>
	</div>
	<div class="manage-comment-main">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link" aria-current="page" href="/adminPage/board/manageInquiry?num=${ inquiry.num }">문의 정보</a></li>
			<li class="nav-item"><a class="nav-link active" href="/adminPage/board/comment?num=${ inquiry.num }">댓글 관리</a></li>
		</ul>
		<div class="manage-comment-background">
			<div class="title">
				<h5>댓글 현황</h5>
			</div>
			<h4 class="comment-count" data-page="${ pageNum }">
				<i class="fa-solid fa-comments"></i>댓글 <span class="count">${ commentDto.commentCnt }</span>개
			</h4>
			<c:forEach items="${ commentDto.commentList }" var="comment" varStatus="status">
				<div class="comment-content-box" data-cno="${ comment.cno }" style="margin-left: ${comment.cmLevel}0px;">
					<div class="d-flex content-top">
						<div class="d-flex writer-box">
							<c:if test="${ comment.cmLevel > 0}">
							<img src="/img/community/icon-comment.png" alt="" style="opacity: 0.5; margin-right: 5px;">
							</c:if>
							<h5>${ comment.name }</h5>
							<p>${ comment.regDate }</p>
						</div>
						<div class="comment-icon">
     				        <div class="icon-box toggle-edit-btn">	
		            			<i class="fa-solid fa-pencil"></i>수정
		            		</div>
		            		<div class="icon-box comment-delete-btn">	
		            			<i class="fa-solid fa-eraser"></i>삭제
		            		</div>
		            		<div class="icon-box nested-comment-btn">	
	        					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
	                                <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
	                                <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"/>
	                            </svg>
	                            답글
	                        </div>
						</div>
					</div>
					<div class="content-main">
						<c:choose>
							<c:when test="${ comment.cmLevel > 0 }">
								<c:if test="${ comment.comment eq '' }">
									<p>[삭제된 댓글입니다.]</p>
								</c:if>
								<c:if test="${ comment.comment ne '' }">
									<p><span style="color: #aaa; margin-right: 5px">${ parentList[status.index] }</span>${ comment.comment }</p>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${ comment.comment eq '' }">
									<p>[삭제된 댓글입니다.]</p>
								</c:if>
								<c:if test="${ comment.comment ne '' }">
									<p>${ comment.comment }</p>
								</c:if>
							</c:otherwise>				
						</c:choose>
					</div>
   					<div class="comment-comment-wrap">
                        <div class="d-flex">
                        	<div class="d-flex">
	                            <img src="/img/community/icon-comment.png" alt="">
	                            <h4>답글 쓰기</h4>
                            </div>
                            <div class="d-flex close-box register-close">
                            	<i class="fa-solid fa-xmark"></i>
                            	<p>닫기</p>
                            </div>
                        </div>
                        <input id="cno" type="hidden" value="${ comment.cno }"/>
                    	<input id="cmRef" type="hidden" value="${ comment.cmRef }"/>
                    	<input id="cmLevel" type="hidden" value="${ comment.cmLevel }"/>
                    	<input id="cmStep" type="hidden" value="${ comment.cmStep }"/>
                        <div class="d-flex comment-input-box">
							<input id="comment" class="info-input nested-comment-input" type="text">
							<button class="comment-btn cm-register-btn">등록</button>
						</div>
                    </div>
                    <div class="comment-edit-wrap">
                        <div class="d-flex">
                        	<div class="d-flex">
                            	<img src="/img/community/icon-comment.png" alt="">
                            	<h4>댓글 수정</h4>
                            </div>
                            <div class="d-flex close-box edit-close">
                            	<i class="fa-solid fa-xmark"></i>
                            	<p>닫기</p>
                            </div>
                        </div>
                        <div class="d-flex comment-input-box">
							<input id="comment" class="info-input edit-comment-input" type="text" value="${ comment.comment }">
							<button class="comment-btn comment-edit-btn">수정</button>
						</div>	
                    </div>
				</div>
			</c:forEach>
			<c:if test="${ not empty commentDto.commentList }">
				<div class="pagination-box">
					<nav class="comment-list-pagination" aria-label="Page navigation">
						<ul class="pagination">
							<li class="page-item">
								<a class="page-link" href="/adminPage/board/comment?pageNum=1&bno=${ inquiry.num }" aria-label="first">
									<span aria-hidden="true">
										<i class="fa-solid fa-backward"></i>
									</span>
								</a>
							</li>
							<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<li class="page-item">
								<a class="page-link" href="/adminPage/board/comment?pageNum=${ pageDto.startPage - pageDto.pageBlock }&bno=${ inquiry.num }" aria-label="Previous">
									<span aria-hidden="true">
										<i class="fa-solid fa-angle-left"></i>
									</span>
								</a>
							</li>
							</c:if>
							<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1"> 
							<li class="page-item">
								<a class="page-link ${ pageNum == i ? 'active' : ''}" href="/adminPage/board/comment?pageNum=${ i }&bno=${ inquiry.num }">
									${ i }
								</a>
							</li>
							</c:forEach>
							<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<li class="page-item">
								<a class="page-link" href="/adminPage/board/comment?pageNum=${ pageDto.startPage + pageDto.pageBlock }&bno=${ inquiry.num }" aria-label="Next">
									<span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
								</a>
							</li>
							</c:if>
							<li class="page-item">
								<a class="page-link" href="/adminPage/board/comment?pageNum=${ pageDto.pageCount }&bno=${ inquiry.num }" aria-label="last">
									<span aria-hidden="true"><i class="fa-solid fa-forward"></i></span>
								</a>
							</li>
						</ul>
					</nav>
				</div>
			</c:if>	
			<div class="comment-write-wrap">
                <h4>댓글 쓰기</h4>
				<div class="d-flex comment-input-box">
					<input class="info-input comment-input" type="text">
					<button type="button" class="basic-btn regist-btn">등록</button>
				</div>
			</div>
             <div class="d-flex comment-bottom-box">
				<button class="basic-btn close-btn ">닫기</button>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/summernote-lite.js"></script>
 	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
 	<script src="/js/adminPage/board/comment.js"></script>
 	<script>
	 	var bno = "${ inquiry.num }"; //페이지 글 번호
		var id = "${ sessionScope.id }" //로그인 아이디
		var cmId = "${ inquiry.id }" //cmId == commentId 자성자 아이디
		var name = "${sessionScope.name}" //로그인 이름
		var pageNum = "${pageNum}" 
 	</script>	
 	
 	
</body>

</html>