var spc = /[~!@#$%^&*()_+|<>:{}]/;
var num = /[0-9]/;
var eng = /[a-zA-Z]/;
var email = /\S+@\S+\.\S+/;
var phone = /^\d{2,3}\d{3,4}\d{4}$/;
var tell = /^\d{2,3}\d{3,4}\d{4}$/;
var originalEmail = $('#email-input').val();
var originalPhone = $('#phone-input').val();

//비밀번호 변경 
$('.now-pwd').on('input', function() {
	$('.now-pwd-tip').removeClass('fail').text('');
})

$('.now-pwd').on('change', function() {

	let nowPwd = $('.now-pwd').val();

	if (nowPwd == "") {
		$('.now-pwd-tip').addClass('fail').text('비밀번호를 입력해주세요.');
	} else {
		$('.now-pwd-tip').removeClass('fail').text('');
	}
})

$('.new-pwd').on('input', function() {
	$('.new-pwd-tip').removeClass('fail').text('');
})

$('.new-pwd').on('change', function() {

	let newPwd = $('.new-pwd').val();

	if (newPwd == "") {
		$('.new-pwd-tip').addClass('fail').text('새로운 비밀번호를 입력해주세요.');
	} else if (newPwd != "") {

		if (!(newPwd.length > 7 && newPwd.length < 20 && eng.test(newPwd) && num.test(newPwd) && spc.test(newPwd))) {

			$('.new-pwd-tip').addClass('fail').text('비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자(!@#$%^*+=-)로 조합해주세요.')
		} else {

			$('.new-pwd-tip').removeClass('fail').text('');
		}
	}
})

$('.pwd-btn').click(function() {

	let nowTip = $('.now-pwd-tip').text();
	let newTip = $('.new-pwd-tip').text();
	let nowPwd = $('.now-pwd').val();
	let newPwd = $('.new-pwd').val();
	let id = $('.info-id').text();

	if (nowTip == "" && newTip == "") {

		$.ajax({
			method: "GET",
			url: "/member/pwdCheck/" + nowPwd
		}).done(function(result) {

			if (result.password != nowPwd) {
				$('.now-pwd-tip').addClass('fail').text('입력하신 비밀번호가 일치하지 않습니다. 다시 입력해주세요.');

			} else if (result.password == newPwd) {

				$('.new-pwd-tip').addClass('fail').text('동일한 비밀번호는 사용하실 수 없습니다. 다시 입력해주세요.');
			} else {

				let changeConfirm = confirm('정말 비밀번호를 바꾸시겠습니까?');

				if (changeConfirm) {
					$.ajax({
						method: "POST",
						url: "/member/updatePwd/" + newPwd + "/" + id
					}).done(function(result) {

						alert(result);
						location.reload(true);
					})
				}
			}
		})
	}
})

//연락처 이벤트
$('#phone-input').on('input', function() {
	$('.phone-tip').removeClass('fail success').text('');
})


//이메일 변경

$('#email-input').on('input', function() {
	$('.email-tip').removeClass('fail').text('');
	$('#check-input').val('').prop('disabled', true);
	$('.check-btn').prop('disabled', true);
	$('.check-tip').removeClass('fail success').text('');
})

$('.send-btn').click(function() {

	let emailVal = $('#email-input').val();
	let emailTip = $('.email-tip');

	if (email.test(emailVal)) {

		$.ajax({
			method: 'GET',
			url: '/member/emailDupCheck/' + emailVal
		}).done(function(result) {

			if (result == true) {

				emailTip.addClass('fail').text('이미 사용중인 이메일입니다. 다른 이메일을 사용해주세요.');
			} else {

				emailTip.removeClass('fail').text('');

				$.ajax({
					method: 'GET',
					url: '/member/sendEmail/' + emailVal
				}).done(function(result) {

					console.log(result);

					$('#check-input').prop('disabled', false);
					$('.check-btn').prop('disabled', false);
					$('.check-tip').addClass('success').text('인증메일이 발송되었습니다. 인증번호를 입력해 주세요.');

					$('.check-btn').click(function() {

						let checkVal = $('#check-input').val();
						let checkTip = $('.check-tip');

						if (checkVal == result) {
							checkTip.addClass('success').text('인증이 완료되었습니다.')
							$('#check-input').prop('disabled', true);
							$('.check-btn').prop('disabled', true);
						} else {
							checkTip.removeClass('success').addClass('fail').text('인증번호가 일치하지 않습니다. 다시 입력해주세요.')
						}
					})
				}).fail(function(errorThrown) {
					console.log(errorThrown);
				})
			}
		})
	} else {

		emailTip.addClass('fail').text('올바른 이메일을 입력해주세요.');
	}

})

//회원정보 수정
$('.modify-btn').click(function() {
	
	let id = $('.info-id').text();
	let emailVal = $('#email-input').val();
	let emailTip = $('.email-tip');
	let phoneVal = $('#phone-input').val();
	let phoneTip = $('.phone-tip');

	if (!email.test(emailVal)) {
		emailTip.addClass('fail').text('올바른 이메일을 입력해주세요.');
	} else if (!$('.check-tip').hasClass('success') && originalEmail != emailVal) {
		emailTip.addClass('fail').text('이메일을 변경하려면 이메일 인증을 하셔야 합니다.');
	} else if (!phone.test(phoneVal) || !tell.test(phoneVal)) {
		phoneTip.addClass('fail').text("올바른 연락처를 입력해주세요.");
	} else {

		let changeConfirm = confirm('정말로 회원정보를 수정하시겠습니까?');
		if (changeConfirm) {

			$.ajax({
				method: "POST",
				url: "/member/updateInfo/" + emailVal + "/" + phoneVal + "/" + id

			}).done(function(result) {

				alert(result);
				location.reload(true);
			})
		}
	}
})