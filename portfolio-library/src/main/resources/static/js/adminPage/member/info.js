//회원정보 창 닫기
$('.close-btn').click(function() {
	opener.parent.location.reload();
	window.close();
})

//회원등급 변경
$('.change-grade-btn').click(function() {

	let changeConfirm = confirm("등급을 변경하시겠습니까?");

	if (changeConfirm) {

		let id = $('.info-id').text();
		let grade = $('.info-grade').text();
		let idList = [];
		let gradeList = [];

		idList.push(id);
		gradeList.push(grade);

		let data = { id: idList, grade: gradeList };

		$.ajax({
			method: "POST",
			url: "/adminPage/member/changeGrade",
			data: data
		}).done(function() {

			location.reload();
		})
	}
})

//회원 비밀번호 변경
$('.change-pwd-btn').click(function() {

	let changeConfirm = confirm("비밀번호를 변경하시겠습니까?");

	if (changeConfirm) {

		let spc = /[~!@#$%^&*()_+|<>:{}]/;
		let num = /[0-9]/;
		let eng = /[a-zA-Z]/;

		let id = $('.info-id').text();
		let nowPwd = $('.now-pwd').val();
		let newPwd = $('.new-pwd').val();
		let rePwd = $('.re-new-pwd').val();

		if (newPwd == "") {
			alert('새로운 비밀번호를 입력해주세요.')
		} else if (!(newPwd.length > 7 && newPwd.length < 20 && eng.test(newPwd) && num.test(newPwd) && spc.test(newPwd))) {

			alert('비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자(!@#$%^*+=-)로 조합해주세요.');
		} else if (rePwd == "") {
			alert('비밀번호를 한번 더 입력해주세요.')
		} else if (newPwd != rePwd) {
			alert('재입력하신 비밀번호가 일치하지 않습니다.')
		} else if (nowPwd == newPwd) {
			alert('동일한 비밀번호는 사용하실 수 없습니다. 다시 입력해주세요.')
		} else {

			$.ajax({
				method: "POST",
				url: "/member/updatePwd/" + newPwd + "/" + id
			}).done(function(result) {

				alert(result);
				location.reload(true);
			})
		} //else
	} //if()
})

//회원정보 수정
$('.modify-btn').click(function() {

	let id = $('.info-id').text();
	let emailVal = $('#email-input').val();
	let phoneVal = $('#phone-input').val();

	let changeConfirm = confirm('정말로 회원정보를 수정하시겠습니까?');
	if (changeConfirm) {

		$.ajax({
			method: "POST",
			url: "/member/updateInfo/" + emailVal + "/" + phoneVal + "/" + id

		}).done(function(result) {

			alert(result);
			location.reload(true);
		})
	} //if()
})

//회원메모 등록
$('.regist-btn').click(function(){
	
	let memo = $('.memo-input').val();
	let id = $('.info-id').text();
	let registConfirm = confirm('메모를 등록하시겠습니까?')
	
	if(registConfirm) {
		if(memo == "") {
			alert("메모에 등록하실 내용을 입력해주세요.")
		} else {
			
			let memoVo = {
				id: id,
				content: memo
			}
			
			var data = JSON.stringify(memoVo);
			
			$.ajax({
				method: 'POST',
				url: "/adminPage/member/registMemo",
				data: data,
				contentType: 'application/json; charset=utf-8'
			}).done(function() {

				location.reload();
			})
		} //else
	} //if()
})

//회원메모 삭제
$('.delete-btn').click(function(){
	
	let deleteConfirm = confirm('메모를 삭제하시겠습니까?')
	
	if(deleteConfirm) {
		
		let memoNum = $(this).parent().siblings('.memo-num').val();

		$.ajax({
			method: 'DELETE',
			url: "/adminPage/member/deleteMemo?num=" + memoNum,
		}).done(function() {
			location.reload();
		})
	} //if()
})