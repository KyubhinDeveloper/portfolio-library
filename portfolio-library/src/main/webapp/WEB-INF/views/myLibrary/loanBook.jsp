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
<link rel="stylesheet" href="/css/myLibrary/loanBook.css">
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
						<a href="/myLibrary/loanBook"><span class="page-now">대출중인 도서</span></a>
					</div>
				</div>
				<div class="main-myLibrary-wrap">
					<div class="main-myLibrary-box">
						<div class="myLibrary-title">
							<h1>대충중인 도서</h1>
						</div>
						<div class="myLibrary-main">
							<div class="main-wrap">
								<div class="d-block d-lg-flex myLibrary-box">
									<h4>내서재/정보관리</h4>
									<div class="d-flex mt-3 item-box">
										<a href="/myLibrary/bookmark">내서재</a> 
										<a href="/myLibrary/loanBook" class="active">대출중인 도서</a> 
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
										<a href="/myLibrary/reservationBook">예약도서</a> <a href="/myLibrary/hopeBook">희망도서</a>
									</div>
								</div>
							</div>
							<c:choose>
								<c:when test="${ not empty sessionScope.id }">
									<div class="bottom-loan-wrap">
										<div class="d-flex loan-text-box">
											<p>총 <span class="loan-count">${ totalCount }</span>건</p>
											<p>
												연장은 1회만 가능하며 신청일로부터 대출기간만큼 연장 가능합니다. <span>단, 예약 및 연체 도서가 있는 경우 연장할 수 없습니다.</span> <a href="/bookInfo/returnOfLoan">		
											</p>
											<button class="btn detail-btn">자세히보기</button></a>
										</div>
										<c:if test="${ totalCount eq 0}">
											<div class="no-list-box">
												<div class="no-book-box">
													<h5>대출 중인 도서가 없습니다.</h5>
												</div>
											</div>
										</c:if>
										<c:if test="${ totalCount gt 0}">
										<table>
											<thead>
												<tr>
													<th>번호</th>
													<th>서명/저자</th>
													<th class="loan-date">대출일</th>
													<th>반납예정일</th>
													<th>연체일</th>
													<th>연장하기</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${ loanBookList }" var="loanBook" varStatus="status">
												<tr>
													<td>
														<div class="td-title">번호</div>
														${ totalCount - status.index }
													</td>
													<td class="loanBook-text">
														<input class="book-isbn" type="hidden" value="${ loanBook.isbn }"/>
														<input class="book-num" type="hidden" value="${ loanBook.bookNum }"/>
														<div class="td-title">서명/저자</div>
														<div>
															<a href="#">
																<span>${ loanBook.title }</span>, <span>${ loanBook.author }</span>, <span>${ loanBook.publisher }</span>, <span>${ loanBook.pubdate.substring(0,4) }</span>
															</a>
														</div>
													</td>
													<td id="loan-date" class="loan-date">
														<div class="td-title">대출일</div>
														${ loanBook.loanDate }
													</td>
													<td id="end-date">
														<div class="td-title">반납일</div>
														${ loanBook.endDate }
													</td>
													<td>
														<div class="td-title">연체일</div>
														${ loanBook.overdueDate }
													</td>
													<td>
														<c:choose>
															<c:when test="${ loanBook.extension eq 0 and reserveCnt[status.index] eq 0 and overdueCnt eq 0 and lossCnt eq 0}">
																<div class="td-title">연장하기</div>
																<button class="btn extend-btn">
																	<i class="fa-solid fa-clock-rotate-left"></i>연장
																</button>
															</c:when>
															<c:when  test="${ loanBook.extension eq 1}">
																<div class="td-title">연장하기</div>
																연장불가(횟수초과)
															</c:when>
															<c:when test="${ reserveCnt[status.index] gt 0 }">
																<div class="td-title">연장하기</div>
																연장불가(예약중)
															</c:when>
															<c:when test="${ overdueCnt gt 0 }">
																<div class="td-title">연장하기</div>
																연장불가(연체중)
															</c:when>
															<c:when test="${ lossCnt gt 0 }">
																<div class="td-title">연장하기</div>
																연장불가(분실중)
															</c:when>
														</c:choose>
													</td>
												</tr>
											</c:forEach>	
											</tbody>
										</table>
										</c:if>
									</div>
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
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/main.js"></script>
	<script>
		//대출도서 상세보기 이벤트
		$('.loanBook-text').click(function(){
			let isbn = $(this).children('.book-isbn').val();
			location.href="/bookCollection/bookDetail?isbn="+isbn;
		}) 
		
		//도서 연장하기 이벤트
		$('.extend-btn').click(function(){
			
			let extendConfirm = confirm("해당 도서의 대출기간을 연장하시겠습니까?");
			
			if(extendConfirm) {
				
				let date1 = new Date();
				let offset = date1.getTimezoneOffset() * 60000; //toISOString() 변환시간과 한국시간이 9시간 차이 나서 9시간 더해줘야한다.
				let dateOffset = new Date(date1.getTime() - offset);
				let stringDate = String(dateOffset.toISOString()).replace('T',' ').split(' ');
				stringDate = stringDate[0].split('-');
				let today = new Date(stringDate[0], stringDate[1]-1, stringDate[2])
				
				let date2 = $(this).parent().siblings('#end-date').text().split('/');
				let endDate = new Date(date2[0], date2[1]-1, date2[2]);
				let threeDay = 1000 * 60 * 60 * 24 * 3;
				
				let timeGap = endDate.getTime() - today.getTime();
				
				if( threeDay - timeGap >= 0) {
					
					function leftPad(value) { 
						if (value >= 10) { 
							return value; 
						}
						return `0`+ value;
					}
					
					let bookNum = $(this).parent().siblings('.loanBook-text').find('.book-num').val()
					console.log(bookNum);
					endDate.setDate(endDate.getDate() + 3);
					endDate.setMonth(endDate.getMonth() + 1)
					endDate = ""+endDate.getFullYear()+"/"+leftPad(endDate.getMonth())+"/"+leftPad(endDate.getDate())+"";
					console.log(endDate);
					
					let loanBookVo = {
						bookNum: bookNum,
						endDate: endDate
					}
					
 					var data = JSON.stringify(loanBookVo);	
					
 					$.ajax({
						method: "PUT",
						url: "/bookCollection/updateLoanDate",
						data: data,
						contentType: 'application/json; charset=utf-8'
					}).done(function(){
						
						location.reload();		
					})  
					
				} else {
					
					alert('대출연장은 반납예정일 3일전부터 가능합니다.');
				}
			} //if()
		})
		
	</script>
</body>