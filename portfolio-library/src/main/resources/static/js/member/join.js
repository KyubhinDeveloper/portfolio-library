
var num = /[0-9]/;
var eng = /[a-zA-Z]/;
var kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
var spcAll = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
var spc = /[~!@#$%^&*()_+|<>:{}]/; 
var phone = /^\d{2,3}\d{3,4}\d{4}$/;
var tell = /^\d{2,3}\d{3,4}\d{4}$/;
var email = /\S+@\S+\.\S+/;

출처: https://epthffh.tistory.com/entry/비밀번호-정규식 [물고기 개발자의 블로그]

$('.field-input').on('change', function(){
	
	if($(this).val() == "") {
		$(this).parent().next().removeClass('success');
		$(this).parent().next().addClass('fail');
		$(this).parent().next().text('필수 입력 정보 입니다.')
		$(this).next().hide()
	}
})


//id input 이벤트
$("#id-input").on('change', function(){
	
	let idText = $('#id-input').val();
	let idTip = $('.id-input-tip');
	
	if(idText.length > 4 && !kor.test(idText) && !spcAll.test(idText) && eng.test(idText) ) {
		
		$.ajax({
			method: 'GET',
			url:'/member/idDupCheck/' + idText,
			
		}).done(function(result){
			
			if(result == true){
				idTip.text('이미 사용중인 아이디입니다.').removeClass('success').addClass('fail');
				$("#id-input").next().hide();
				
			} else {
				idTip.text('사용 가능한 아이디입니다.').removeClass('fail').addClass('success');
				$("#id-input").next().show();
			}
			
		}).fail(function(errorThrown){
			console.log(errorThrown);
		})
		
	} else if(idText != "") {
		idTip.text('5~20자의 영문 대소문자와 숫자 조합만 사용 가능합니다.')
		idTip.removeClass('success').addClass('fail');
		$(this).next().hide()
	}

})

//pwd input 이벤트
$('#pwd-input').on('change', function(){
	
	let pwdText = $('#pwd-input').val();
	let pwdTip = $('.pwd-input-tip');
	
	if(pwdText.length > 7 && pwdText.length < 20 && eng.test(pwdText) && num.test(pwdText) && spc.test(pwdText)) {
		pwdTip.text('').removeClass('fail').addClass('success');
		$(this).next().show();
	} else if(pwdText != "") {
		pwdTip.text('비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자(!@#$%^*+=-)로 조합해주세요.')
		pwdTip.removeClass('success').addClass('fail');
		$(this).next().hide();	
	}	
})

$('#rePwd-input').on('change', function(){
	
	let reText = $('#rePwd-input').val();
	let pwdText = $('#pwd-input').val();
	let reTip = $('.rePwd-input-tip');
	
	if(pwdText == reText) {
		reTip.text('').removeClass('fail').addClass('success');
		$(this).next().show()
	} else if(reText != "") {
		reTip.text('비밀번호가 일치하지 않습니다.');
		reTip.removeClass('success').addClass('fail');
		$(this).next().hide();
	}
})

$('#name-input').on('change', function(){
	
	let nameText = $('#name-input').val();
	let nameTip = $('.name-input-tip');
	
	if(nameText.length > 1 && !num.test(nameText) && !spcAll.test(nameText)) {
		nameTip.text("").removeClass('fail').addClass('success');;
		$(this).next().show()
	} else if(nameText != "") {
		nameTip.text("올바른 이름을 입력해주세요.");
		nameTip.removeClass('success').addClass('fail');
		$(this).next().hide();
	}
	
})

//성별 check 이벤트
$('.gender').click(function(){
	$('.gender').removeClass('active');
	$(this).addClass('active');
	$('.gender-input').val($(this).text());
	$('.gender-tip').addClass('success').text('');
})


//생년월일 이벤트
$('.birth-select').on('change', function(){
	
	if($('.year-select').val() == "년도"){
		$('.birth-tip').show().removeClass("success").addClass('fail').text("태어난 년도를 선택하세요.")
	} else if($('.year-select').val() != "년도" && $('.month-select').val() == "월"){
		$('.birth-tip').show().removeClass("success").addClass('fail').text("태어난 월을 선택하세요.")
	} else if($('.year-select').val() != "년도" && $('.month-select').val() != "월" && $('.day-select').val() == "일") {
		$('.birth-tip').show().removeClass("success").addClass('fail').text("태어난 일을 선택하세요.")
	} else {
		$('.birth-tip').removeClass("fail").addClass('success').text("")
	}
})

$('select').on('change', function(){
	
	$(this).prev().val($(this).val());
})

//연락처 이벤트
$('#phone-input').on('change', function(){
	
	let phoneText = $('#phone-input').val();
	let phoneTip = $('.phone-input-tip');
	
	if(phone.test(phoneText) || tell.test(phoneText)) {
		phoneTip.text("").addClass('success');
		$(this).next().show();
	} else {
		phoneTip.addClass('fail').text("올바른 연락처를 입력해주세요.");
		$(this).next().hide()
	}
})

//이메일 이벤트
$('.email-btn').on('click', function(){
	
	let emailText = $('#email-input').val();
	let emailTip = $('.email-input-tip');
	let checkTip= $('.check-input-tip')
	
	checkTip.removeClass('success fail').text('');
	$('.check-input').prop('disabled', true);
	$('.check-btn').prop('disabled', true);
	
	if(email.test(emailText)) {
		
		$.ajax ({
			method: 'GET',
			url: '/member/emailDupCheck/' + emailText
		}).done(function(result){
			
			if(result == true){
				
				emailTip.removeClass('success').addClass('fail').text('이미 사용중인 이메일입니다. 다른 이메일을 사용해주세요.');
			} else {
				
				emailTip.text('');
				$.ajax ({
					method: 'GET',
					url: '/member/sendEmail/' + emailText
				}).done(function(result){
							
					console.log(result);
					
					$('.check-input').prop('disabled', false);
					$('.check-btn').prop('disabled', false);
					$('.check-input-tip').removeClass('success fail').text('인증메일이 발송되었습니다. 인증번호를 입력해 주세요.');
					
					$('.check-btn').click(function(){
						
						let checkText = $('.check-input').val();
						console.log(checkText);
						
						if(checkText == result) {
							checkTip.removeClass('fail').addClass('success').text('인증이 완료되었습니다.')
								emailTip.addClass('success').text('');
								$('.check-input').prop('disabled', true);
								$('.check-btn').prop('disabled', true);
						} else {
							checkTip.removeClass('success').addClass('fail').text('인증번호가 일치하지 않습니다. 다시 입력해주세요.')
							
						}
						
					})			
				}).fail(function(errorThrown){
					console.log(errorThrown);
				})
			}
		})
		
	} else {
		emailTip.removeClass('success').addClass('fail').text('올바른 이메일을 입력해주세요.');
	}
})

//회원가입 버튼 이벤트

$('.join-btn').click(function(){
	
	var failCount = 8;
	
	for(let i = 0; i < $('.tip').length; i++) {
		
		if(!$('.tip').eq(i).hasClass('success')){
			
			$('.tip').eq(i).addClass('fail')
			$('.tip').eq(i).text('필수 입력 값입니다.');
			
		} else if($('.tip').eq(i).hasClass('success')){
			failCount--
		}
	}
	
	if(failCount == 0){
		
		if(!$('#accept_agreement_1').is(':checked') || !$('#accept_agreement_2').is(':checked')) {
			alert('약관에 반드시 동의해주셔야 합니다. ')
		} else {
			
			$('.join-field-wrap').submit();
		}
	} 
	
})


