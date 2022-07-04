//관리창 띄우기
$('.manage-btn').click(function(){
	let id = $(this).parent().siblings('.member-id').text();
	window.open('/adminPage/member/info?id='+id,' _blank','top=150, left=20, width=670, height=800, status=no, menubar=no, toolbar=no, resizable=no');
})

//공지발송 창 띄우기
$('.send-mail-btn').click(function(){
	
	let length = $('.member-check:checked').length;
	let idList = [];
	
	if(length > 0) {
		$('.member-check:checked').each(function(e){
			
			let id = $(this).parent().siblings('.member-id').text();
			idList.push(id);
		})
	}
	
	window.open('/adminPage/member/sendMail?idList=' + idList,' _blank','top=150, left=20, width=650, height=450, status=no, menubar=no, toolbar=no, resizable=no');
	location.reload();
})

//등급체크 검색
$('.grade').click(function(){
	
	let grade = $('.grade');
	
	for(let i = 0; i<grade.length; i++) {
		grade[i].checked = false;
	}
	
	this.checked = true;
})

// 전체선택 이벤트
$('.all-check').click(function(){
	
	if($(this).is(':checked')) {
		$('.member-check').prop('checked', true);
	} else {
		$('.member-check').prop('checked', false);
	}
})

//체크회원 등급변경
$('.change-grade-btn').click(function(){
	
	let changeConfirm = confirm('선택하신 회원의 등급을 변경하시겠습니까?')
	
	if(changeConfirm) {
		
		let length = $('.member-check:checked').length;
		let idList = [];
		let gradeList = [];
		
		if(length > 0) {
			$('.member-check:checked').each(function(e){
				
				let id = $(this).parent().siblings('.member-id').text();
				let grade = $(this).parent().siblings('.member-grade').text();
				idList.push(id);
				gradeList.push(grade);
			});
			
			var data = {id: idList, grade: gradeList}
					
			$.ajax({
				method: "POST",
				url: "/adminPage/member/changeGrade",
				data: data
			}).done(function(){
				
				alert("선택하신 회원의 등급이 변경되었습니다.")
				location.reload();
				
			})
		}	
	}
})

//체크회원 탈퇴처리
$('.secession-btn').click(function(){
	
	let secessionConfirm = confirm('선택하신 회원을 탈퇴 처리하겠습니까?');
	
	if(secessionConfirm) {
		
		let length = $('.member-check:checked').length;
		let idList = [];
		
		if(length > 0) {
			$('.member-check:checked').each(function(e){
				
				let id = $(this).parent().siblings('.member-id').text();
				idList.push(id);
			});
			
			var data = {id: idList}
			
			$.ajax({
				method: "DELETE",
				url: "/adminPage/member/secession",
				data: data
			}).done(function(){
				
				alert("선택하신 회원이 탈퇴되었습니다.")
				location.reload();
				
			})
		}
	}
})