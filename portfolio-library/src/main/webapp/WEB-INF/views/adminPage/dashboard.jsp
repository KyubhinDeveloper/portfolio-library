<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지 - AdminPage</title>
<link rel="icon" href="/img/member/admin-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/adminPage/dashboard.css">
</head>
<body>
	<div class="admin-page-bg">
		<div class="d-flex admin-page-wrap">
			<div class="admin-side-menu">
				<div class="side-title">
					<h3>
						<span>KYUBHIN</span><span>LIBRARY</span>
					</h3>
					<p>d e v e l o p e r</p>
					<span>규빈도서관</span>
				</div>
				<div class="side-item-wrap">
					<div class="side-item-box">
						<a href="/adminPage/dashboard" class="d-flex dashboard-box"> <i class="fa-brands fa-deezer"></i> <span>대시보드</span>
						</a>
					</div>
					<div class="side-item-box">
						<a href="/adminPage/member/management" class="d-flex userManagement-box"> <i class="fa-solid fa-user-gear"></i> <span>회원관리</span>
						</a>
					</div>
					<div class="side-item-box">
						<p class="item-box-title">도서관리</p>
						<div class="d-flex bookManagement-box">
							<a href="/adminPage/book/loanStatus">대출현황</a> <a href="/adminPage/book/reserveStatus">예약현황</a> <a href="/adminPage/book/ercStatus">기타현황</a> <a
								href="/adminPage/book/hopeList">희망도서</a> <a href="/adminPage/book/record">도서기록</a>
						</div>
					</div>
					<div class="side-item-box">
						<p class="item-box-title">게시글관리</p>
						<div class="d-flex boardManagement-box">
							<a href="/adminPage/board/notice">공지사항</a> <a href="/adminPage/board/inquiry">게시판문의</a>
						</div>
					</div>
					<div class="side-item-box return-box">
						<a href="/" class="d-flex userManagement-box"> <i class="fa-solid fa-right-from-bracket"></i>
						</a>
					</div>
				</div>
			</div>
			<div class="admin-main-wrap">
				<div class="d-flex admin-title-box">
					<i class="fa-brands fa-deezer"></i>
					<h5>대시보드</h5>
				</div>
				<div class="d-flex admin-main-content">
					<div class="main-content-left">
						<div class="d-flex chart-box left-basic-box">
							<canvas id="month-loanChart" width="300" height="300" ></canvas>
							<canvas id="daily-loanChart" width="350" height="300" ></canvas>
							<canvas id="loanLanking-chart" width="230" height="230" ></canvas>
							<canvas id="bookLanking-chart" width="230" height="230" ></canvas>
						</div>
						<div class="d-flex total-box left-basic-box">
							<div class="d-flex item-box">
								<p>회원수</p>
								<p class="value">
									<span class="member-count"></span>명
								</p>
								<p class="plus-box">
									+ <span class="plus-join"><span class="today-join-count"></span>명</span>
								</p>
							</div>
							<div class="d-flex item-box">
								<p>현재 대출권수</p>
								<p class="value">
									<span class="total-loan-count"></span>권
								</p>
								<p class="plus-box">
									+ <span class="plus-loan"><span class="today-loan-count"></span>권</span>
								</p>
							</div>
							<div class="d-flex item-box">
								<p>연체권수</p>
								<p class="value">
									<span class="overdue-count"></span>권
								</p>
								<p class="plus-box">
									+ <span class="plus-reserve"><span class="today-overdue-count"></span>권</span>
								</p>
							</div>
							<div class="d-flex item-box">
								<p>분실권수</p>
								<p class="value">
									<span class="loss-count"></span>권
								</p>
								<p class="plus-box">
									+ <span class="plus-loss"><span class="today-loss-count"></span>권</span>
								</p>
							</div>
							<div class="d-flex item-box">
								<p>희망도서수</p>
								<p class="value">
									<span class="hope-book-count"></span>권
								</p>
								<p class="plus-box">
									+ <span class="plus-hope"><span class="today-apply-count"></span>권</span>
								</p>
							</div>
							<div class="d-flex item-box">
								<p>미납 연체료</p>
								<p class="value">
									<span class="total-latefee"></span>원
								</p>
							</div>
						</div>
						<div class="recent-loans-list left-basic-box">
							<h5>최근 대출내역</h5>
							<div class="list-box">
								<table>
									<thead>
										<tr>
											<th>아이디</th>
											<th>이름</th>
											<th>도서번호</th>
											<th>도서명</th>
											<th>상태</th>
											<th>대출일시</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${ recentloanList }" var="recentLoan" varStatus="status">
											<tr>
												<td>${ recentLoan.id }</td>
												<td>${ recentLoan.name }</td>
												<td>${ recentLoan.bookNum }</td>
												<td>${ recentLoan.title }</td>
												<td>${ recentLoan.status }</td>
												<td>${ recentLoan.loanDate }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

						</div>
					</div>
					<div class="main-content-right">
						<div class="room-map-box right-basic-box">
							<div class="d-flex seat-tab-box">
								<div class="tab">
									<input class="tab-number" type="hidden" value="tab1"/>
									<button class="tab-btn room-name active" type="button">2층 제 1열람실</button>
									<input class="room-seat-count" type="hidden" value="108" />
								</div>
								<div class="tab">
									<input class="tab-number" type="hidden" value="tab2"/>
									<button class="tab-btn room-name" type="button">3층 제 2열람실</button>
									<input class="room-seat-count" type="hidden" value="78" />
								</div>
							</div>
							<div class="tab-status tab1 active">
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat1"></div>
										<div class="item-box seat2"></div>
										<div class="item-box seat3"></div>
										<div class="item-box seat4"></div>
										<div class="item-box seat5"></div>
										<div class="item-box seat6"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat7"></div>
										<div class="item-box seat8"></div>
										<div class="item-box seat9"></div>
										<div class="item-box seat10"></div>
										<div class="item-box seat11"></div>
										<div class="item-box seat12"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat13"></div>
										<div class="item-box seat14"></div>
										<div class="item-box seat15"></div>
										<div class="item-box seat16"></div>
										<div class="item-box seat17"></div>
										<div class="item-box seat18"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat19"></div>
										<div class="item-box seat20"></div>
										<div class="item-box seat21"></div>
										<div class="item-box seat22"></div>
										<div class="item-box seat23"></div>
										<div class="item-box seat24"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat25"></div>
										<div class="item-box seat26"></div>
										<div class="item-box seat27"></div>
										<div class="item-box seat28"></div>
										<div class="item-box seat29"></div>
										<div class="item-box seat30"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat31"></div>
										<div class="item-box seat32"></div>
										<div class="item-box seat33"></div>
										<div class="item-box seat34"></div>
										<div class="item-box seat35"></div>
										<div class="item-box seat36"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat37"></div>
										<div class="item-box seat38"></div>
										<div class="item-box seat39"></div>
										<div class="item-box seat40"></div>
										<div class="item-box seat41"></div>
										<div class="item-box seat42"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat43"></div>
										<div class="item-box seat44"></div>
										<div class="item-box seat45"></div>
										<div class="item-box seat46"></div>
										<div class="item-box seat47"></div>
										<div class="item-box seat48"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat49"></div>
										<div class="item-box seat50"></div>
										<div class="item-box seat51"></div>
										<div class="item-box seat52"></div>
										<div class="item-box seat53"></div>
										<div class="item-box seat54"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat55"></div>
										<div class="item-box seat56"></div>
										<div class="item-box seat57"></div>
										<div class="item-box seat58"></div>
										<div class="item-box seat59"></div>
										<div class="item-box seat60"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat61"></div>
										<div class="item-box seat62"></div>
										<div class="item-box seat63"></div>
										<div class="item-box seat64"></div>
										<div class="item-box seat65"></div>
										<div class="item-box seat66"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat67"></div>
										<div class="item-box seat68"></div>
										<div class="item-box seat69"></div>
										<div class="item-box seat70"></div>
										<div class="item-box seat71"></div>
										<div class="item-box seat72"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat73"></div>
										<div class="item-box seat74"></div>
										<div class="item-box seat75"></div>
										<div class="item-box seat76"></div>
										<div class="item-box seat77"></div>
										<div class="item-box seat78"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat79"></div>
										<div class="item-box seat80"></div>
										<div class="item-box seat81"></div>
										<div class="item-box seat82"></div>
										<div class="item-box seat83"></div>
										<div class="item-box seat84"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat85"></div>
										<div class="item-box seat86"></div>
										<div class="item-box seat87"></div>
										<div class="item-box seat88"></div>
										<div class="item-box seat89"></div>
										<div class="item-box seat90"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat91"></div>
										<div class="item-box seat92"></div>
										<div class="item-box seat93"></div>
										<div class="item-box seat94"></div>
										<div class="item-box seat95"></div>
										<div class="item-box seat96"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat97"></div>
										<div class="item-box seat98"></div>
										<div class="item-box seat99"></div>
										<div class="item-box seat100"></div>
										<div class="item-box seat101"></div>
										<div class="item-box seat102"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat103"></div>
										<div class="item-box seat104"></div>
										<div class="item-box seat105"></div>
										<div class="item-box seat106"></div>
										<div class="item-box seat107"></div>
										<div class="item-box seat108"></div>
									</div>
								</div>
							</div>
							<div class="tab-status tab2">
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat1"></div>
										<div class="item-box seat2"></div>
										<div class="item-box seat3"></div>
										<div class="item-box seat4"></div>
										<div class="item-box seat5"></div>
										<div class="item-box seat6"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat7"></div>
										<div class="item-box seat8"></div>
										<div class="item-box seat9"></div>
										<div class="item-box seat10"></div>
										<div class="item-box seat11"></div>
										<div class="item-box seat12"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat13"></div>
										<div class="item-box seat14"></div>
										<div class="item-box seat15"></div>
										<div class="item-box seat16"></div>
										<div class="item-box seat17"></div>
										<div class="item-box seat18"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat19"></div>
										<div class="item-box seat20"></div>
										<div class="item-box seat21"></div>
										<div class="item-box seat22"></div>
										<div class="item-box seat23"></div>
										<div class="item-box seat24"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat25"></div>
										<div class="item-box seat26"></div>
										<div class="item-box seat27"></div>
										<div class="item-box seat28"></div>
										<div class="item-box seat29"></div>
										<div class="item-box seat30"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat31"></div>
										<div class="item-box seat32"></div>
										<div class="item-box seat33"></div>
										<div class="item-box seat34"></div>
										<div class="item-box seat35"></div>
										<div class="item-box seat36"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat37"></div>
										<div class="item-box seat38"></div>
										<div class="item-box seat39"></div>
										<div class="item-box seat40"></div>
										<div class="item-box seat41"></div>
										<div class="item-box seat42"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat43"></div>
										<div class="item-box seat44"></div>
										<div class="item-box seat45"></div>
										<div class="item-box seat46"></div>
										<div class="item-box seat47"></div>
										<div class="item-box seat48"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat49"></div>
										<div class="item-box seat50"></div>
										<div class="item-box seat51"></div>
										<div class="item-box seat52"></div>
										<div class="item-box seat53"></div>
										<div class="item-box seat54"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat55"></div>
										<div class="item-box seat56"></div>
										<div class="item-box seat57"></div>
										<div class="item-box seat58"></div>
										<div class="item-box seat59"></div>
										<div class="item-box seat60"></div>
									</div>
								</div>
								<div class="d-flex seat-status-box">
									<div class="d-flex seat-status-item">
										<div class="item-box seat61"></div>
										<div class="item-box seat62"></div>
										<div class="item-box seat63"></div>
										<div class="item-box seat64"></div>
										<div class="item-box seat65"></div>
										<div class="item-box seat66"></div>
									</div>
									<div class="d-flex seat-status-item">
										<div class="item-box seat67"></div>
										<div class="item-box seat68"></div>
										<div class="item-box seat69"></div>
										<div class="item-box seat70"></div>
										<div class="item-box seat71"></div>
										<div class="item-box seat72"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="d-flex room-detail-box right-basic-box">
							<div class="detail-item-box">
								<div class="d-flex">
									<div class="item-box"></div>
									<p>사용가능</p>
								</div>
								<p class="value">
									<span class="available-count"></span>/<span class="seat-totalCount"></span>
								</p>
							</div>
							<div class="detail-item-box">
								<div class="d-flex">
									<div class="item-box item-box-using"></div>
									<p>사용중</p>
								</div>
								<p class="value">
									<span class="use-count"></span>/<span class="seat-totalCount"></span>
								</p>
							</div>
							<div class="detail-item-box">
								<div class="d-flex">
									<div class="item-box item-box-stop"></div>
									<p>사용불가능</p>
								</div>
								<p class="value">
									<span class="stop-count"></span>/<span class="seat-totalCount"></span>
								</p>
							</div>
						</div>
						<div class="recent-loss-list right-basic-box">
							<h5>최근 분실내역</h5>
							<table>
								<thead>
									<tr>
										<th>아이디</th>
										<th>이름</th>
										<th>도서명</th>
										<th>분실일시</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${ recentLossList }" var="recentLoss" varStatus="status">
										<tr>
											<td>${ recentLoss.id }</td>
											<td>${ recentLoss.name }</td>
											<td class="book-name">${ recentLoss.title }</td>
											<td>${ recentLoss.lossDate }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">		</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
	<script src="/js/adminPage/dashboard.js"></script>
	
</body>

</html>