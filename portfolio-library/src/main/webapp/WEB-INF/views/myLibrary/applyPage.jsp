<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/myLibrary/applyPage.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/sideMenu.jsp" />
	<div class="library-bg">
		<jsp:include page="/WEB-INF/views/include/menu.jsp" />
		<div class="library-main-bg">
			<div class="library-main-wrap">
				<div class="main-top-wrap">
					<div class="d-flex top-box">
						<a href="/"> <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-house-door"
								viewBox="0 0 16 16">
                                <path
									d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
                            </svg>
						</a> <i class="fa-solid fa-angle-right"></i> 
						<a href="/myLibrary/myLibrary"><span>My Library</span></a> 
						<i class="fa-solid fa-angle-right"></i> 
						<a href="/myLibrary/reservationBook"><span class="page-now">희망도서</span></a>
					</div>
				</div>
				<div class="main-myLibrary-wrap">
					<div class="main-myLibrary-box">
						<div class="myLibrary-title">
							<h1>희망도서</h1>
						</div>
						<div class="myLibrary-main">
							<div class="main-wrap">
								<div class="d-block d-lg-flex myLibrary-box">
									<h4>내서재/정보관리</h4>
									<div class="d-flex mt-3 item-box">
										<a href="/myLibrary/bookmark">내서재</a> 
										<a href="/myLibrary/loanBook">대출중인 도서</a> 
										<a href="/myLibrary/overdueRecord">연체/제재</a> 
										<a href="/myLibrary/loanRecord">대출기록</a> 
										<a href="/myLibrary/lossRecord">분실기록</a> 
										<a href="/myLibrary/changeInfo">개인정보변경</a> 
										<a href="/myLibrary/personalNotice">개인공지</a>
									</div>
								</div>
								<div class="d-block d-lg-flex myLibrary-box">
									<h4>도서신청현황</h4>
									<div class="d-flex mt-3 item-box">
										<a href="/myLibrary/reservationBook">예약도서</a> <a href="/myLibrary/hopeBook" class="active">희망도서</a>
									</div>
								</div>
							</div>
							<div class="bottom-hopeBook-wrap">
								<div class="hopeBook-text-box">
									<h2>희망도서 신청 방법</h2>
									<p>
										찾는 책이 없나요? 희망도서를 신청합니다. <span>직접 신청</span>은 서명 등 도서 정보를 직접 입력하는 방법이고, <span>출판사 정보 활용</span>은 출판사의 신간도서를 선택해서 신청하는 방법입니다.
									</p>
									<p>출판사 또는 영업사원에게서 금전적 이익을 약속받고 도서 신청을 하실 경우, 신청도서는 취소처리되며 향후 도서신청에 불이익이 발생할 수 있음을 알려드립니다.</p>
									<a href="/myLibrary/applyPage"><button class="btn apply-btn">희망도서 신청</button></a>
								</div>
								<c:choose>
									<c:when test="${ not empty sessionScope.id }">
										<form class="apply-write-wrap" action="/myLibrary/applyBook/" method="post">
											<h3>희망도서 직접 신청하기</h3>
											<div class="apply-write-box">
												<div class="d-flex apply-box">
													<label for="title-input">서명(책 제목)*</label> 
													<input id="title-input" class="apply-input" name="title" type="text">
												</div>
												<div class="d-flex apply-box">
													<label for="author-input">저자*</label> 
													<input id="author-input" class="apply-input" name="author" type="text">
												</div>
												<div class="d-flex apply-box">
													<label for="publisher-input">출판사*</label> 
													<input id="publisher-input" class="apply-input" name="publisher" type="text" style="width: 250px">
												</div>
												<div class="d-flex apply-box">
													<label for="pubdate-input">출판년도*</label> 
													<input id="pubdate-input" class="apply-input" name="pubdate" type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="width: 100px">
													<p>숫자만 입력하세요.</p>
												</div>
												<div class="d-flex apply-box">
													<label for="isbn-input">ISBN</label> 
													<input id="isbn-input" class="apply-input" name="isbn" type="text" style="width: 250px">
												</div>
												<div class="d-flex apply-box">
													<label for="price-input">가격*</label> 
													<input id="price-input" class="apply-input" name="price" type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="width: 250px">
													<h4> 원</h4>
													<p>숫자만 입력하세요.</p>
												</div>
												<div class="d-flex apply-box">
													<label for="remarks-input">비고</label>
													<textarea id="remarks-input" class="apply-input" name="remarks" cols="160" rows="10"></textarea>
												</div>
											</div>
											<div class="d-flex apply-bottom-box">
												<a href="/myLibrary/myLibrary"><button class="btn basic-btn cancel-btn">취소</button></a>
												<button type="button" class="btn basic-btn apply-btn">신청하기</button>
											</div>
										</form>
									</c:when>
									<c:otherwise>
										<div class="bottom-login-wrap">
											<h2>로그인 필요</h2>
											<div class="login-text-box">
												<p>로그인이 필요한 메뉴입니다.</p>
												<p>로그인인 상태라도 세션이 종료된 경우 개인화 페이지(MY LIBRARY)는 재로그인이 필요합니다.</p>
											</div>
											<a href="/member/login"><button class="btn login-btn">로그인</button></a>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
		
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="/js/main.js"></script>
	<script>
	
		//희망도서 신청 이벤트
		$('.apply-write-wrap .apply-btn').click(function(){
			
			if($('#title-input').val() == "" || $('#author-input').val() == "" || $('#publisher-input').val() == "" || $('#pubdate-input').val() == "" || $('#price-input').val() == ""){
				
				alert('필수 입력 값을 반드시 입력해주세요.');
			} else {
				
				let applyConfirm = confirm('입력하신 도서를 신청하시겠습니까?');
				if(applyConfirm){
					
					let price = $('#price-input')
					let pubdate = $('#pubdate-input')
					
					if(price.val() == ""){
						
						price.attr('disabled',true);
					} 
					
					if(pubdate.val() == "") {
						
						pubdate.attr('disabled',true);
					}
					
					$('.apply-write-wrap').submit();
				}
			}
		})
		
	</script>
</body>