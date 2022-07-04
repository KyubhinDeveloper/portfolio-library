<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="/css/myLibrary/hopeBook.css">
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
						<a href="/"> <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-house-door"
								viewBox="0 0 16 16">
                                <path
									d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
                            </svg>
						</a> 
						<i class="fa-solid fa-angle-right"></i> 
						<a href="/myLibrary/myLibrary"><span>My Library</span></a>
						<i class="fa-solid fa-angle-right"></i> 
						<a href="/myLibrary/hopeBook"><span class="page-now">희망도서</span></a>
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
										<div class="d-flex hopeBook-count-box">
											<p>
												총 <span class="hopeBook-count">${ totalCount }</span>건
											</p>
										</div>
										<c:if test="${ totalCount eq 0 }">
											<div class="no-list-box">
												<div class="no-book-box">
													<h5>신청 중인 도서가 없습니다.</h5>
												</div>
											</div>
										</c:if>
										<c:if test="${ totalCount gt 0 }">
											<table>
												<thead>
													<tr>
														<th>번호</th>
														<th>서명/저자</th>
														<th class="apply-date">신청일</th>
														<th>신청상태</th>
														<th>액션</th>
													</tr>
												</thead>
												<c:forEach items="${ wishList }" var="hopeBook" varStatus="status">												
													<tbody>
														<tr>
															<td>${ fn:length(wishList) - status.index }</td>
															<td class="book-name">
																<span>${ hopeBook.title }</span>, <span>${ hopeBook.author }</span>, <span>${ hopeBook.publisher }</span>, ${ hopeBook.pubdate.substring(0,4) }
															</td>
															<td class="apply-date">${hopeBook.applyDate}</td>
															<td>${hopeBook.status }</td>
															<td>
																<input class="num" type="hidden" value="${ hopeBook.num }"/>
																<c:choose>
																	<c:when test="${ hopeBook.status eq '대기중' }">
																		<button class="btn cancel-btn">
																			<i class="fa-solid fa-ban"></i>
																			<span>신청취소</span>
																		</button>
																	</c:when>
																	<c:when test="${ hopeBook.status eq '소장완료' }">
																		<p></p>
																	</c:when>
																	<c:otherwise>
																		<p>취소불가</p>
																	</c:otherwise>
																</c:choose>
															</td>
														</tr>
													</tbody>
												</c:forEach>
											</table>
										</c:if>
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
	<script src="/js/main.js"></script>
	<script>
		//희망도서 취소 이벤트
		$('.cancel-btn').click(function(){
			let num = $(this).siblings('.num').val();
			let cancelConfirm = confirm("도서신청을 정말 취소하시겠습니까?")
			
			if(cancelConfirm) {
				
				$.ajax({					
					method: "DELETE",
					url: "/myLibrary/cancelApplication/"+num
				}).done(function(){					
					location.reload();
				})
			}
		})
		
	</script>
</body>