<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보</title>
<link rel="icon" href="/img/member/admin-icon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous"
	referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/css/adminPage/member/info.css">
</head>
<body>
	<div class="member-info-top">
		<p><span>${ memberVo.name }</span>(<span>${ memberVo.id }</span>)님의 회원정보입니다.</p>
	</div>
	<div class="member-info-main">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="/adminPage/member/info?id=${ memberVo.id }">회원정보</a></li>
			<li class="nav-item"><a class="nav-link" href="/adminPage/member/postList?id=${ memberVo.id }">작성글</a></li>
		</ul>
		<div class="member-info-background">
			<div class="title">
				<h5>회원 기본 정보</h5>
			</div>
			<div class="member-info-wrap">
				<div class="member-info-box">
					<div class="d-flex member-info-item member-info-id">
						<label>아이디</label>
						<div class="d-flex info-item-box">
							<p class="info-text info-id">${ memberVo.id }</p>
						</div>
					</div>
					<div class="d-flex member-info-item member-info-pwd">
						<label>비밀번호</label>
						<div class="d-flex info-item-box pwd-item-box">
							<div class="d-flex input-box">
								<div class="d-flex">
									<div class="d-flex input-box">
										<input class="info-input now-pwd" type="hidden" value="${ memberVo.password }">
									</div>
									<div class="d-flex input-box">
										<input class="info-input new-pwd" type="password" value="">
										<p class="info-text-tip red">비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자(!@#$%^*+=-)로 조합해주세요.</p>
									</div>
									<div class="d-flex input-box">
										<input class="info-input re-new-pwd" type="password" value="">
										<p class="info-text-tip">비밀번호를 다시 한번 입력해주세요.</p>
									</div>
									<button class="btn change-pwd-btn">비밀번호 변경</button>
								</div>
							</div>
						</div>
					</div>
					<div class="d-flex member-info-item">
						<label>${ memberVo.name }</label>
						<div class="d-flex info-item-box">
							<p class="info-text">한규빈</p>
						</div>
					</div>
					<div class="d-flex member-info-item">
						<label>생년월일</label>
						<div class="d-flex info-item-box">
							<p class="info-text">${ memberVo.birth }</p>
						</div>
					</div>
					<div class="d-flex member-info-item">
						<label>연락처</label>
						<div class="d-flex info-item-box">
							<div class="d-flex input-box phone-box">
								<input id="phone-input" class="info-input phone" name="password" type="number" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${ memberVo.phone }">
							</div>
						</div>
					</div>
					<div class="d-flex member-info-item member-info-email">
						<label>이메일</label>
						<div class="info-item-box email-item-box">
							<div class="d-flex input-box email-box">
								<div class="d-flex email-input">
									<input id="email-input" class="info-input email" name="email" type="text" value="${ memberVo.email }">
								</div>
							</div>
						</div>
					</div>
					<div class="d-flex member-info-item member-info-grade">
						<label>등급</label>
						<div class="d-flex info-item-box">
							<p class="info-text info-grade">${ memberVo.grade }</p>
							<button class="basic-btn change-grade-btn">등급변경</button>
						</div>
					</div>
				</div>
			</div>
			<div class="d-flex info-bottom-box">
				<button class="btn info-btn modify-btn">정보수정</button>
			</div>
		</div>
		<div class="member-memo-background">
			<div class="title">
				<h5>관리자 회원메모</h5>
			</div>
			<div class="d-flex memo-input-box">
				<input class="info-input memo-input" type="text">
				<button class="basic-btn regist-btn">등록</button>
			</div>
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>작성일</th>
						<th>내용</th>
						<th>작성자</th>
						<th>관리</th>
					</tr>
				</thead>
				<c:if test="${ not empty memoList }">
				<tbody>
					<c:forEach items="${ memoList }" var="memo" varStatus="status">
					<tr>
						<input class="memo-num" type="hidden" value="${ memo.num }"/>
						<td>${ fn:length(memoList) - status.index }</td>
						<td>${ memo.regDate }</td>
						<td>${ memo.content}</td>
						<td>${ memo.writer }</td>
						<td>
							<button class="basic-btn delete-btn">삭제</button>
						</td>
					</tr>
					</c:forEach>
				</tbody>
				</c:if>
			</table>
			<c:if test="${ fn:length(memoList) eq 0 }">
				<div class="memo-none-box">
					<p>관리자 메모가 없습니다.</p>
				</div>
			</c:if>
			<div class="d-flex memo-bottom-box">
				<button class="basic-btn close-btn ">닫기</button>
			</div>
		</div>
	</div>




	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/adminPage/member/info.js"></script>
	<script>

	</script>
</body>

</html>