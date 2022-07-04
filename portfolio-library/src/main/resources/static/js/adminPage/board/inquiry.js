//문의관리 창 띄우기
$('.manage-btn').click(function(){
	let num = $(this).parent().siblings('.inquiry-num').val();
	window.open('/adminPage/board/manageInquiry?num=' + num,'_blank','top=150, left=20, width=670, height=700, status=no, menubar=no, toolbar=no, resizable=no');
})

//전체선택
$('.all-check').click(function(){
	if($(this).is(':checked')) {
		$('.inquiry-check').prop('checked', true);
	} else {
		$('.inquiry-check').prop('checked', false);
	}
})

//체크중복처리x
$('.status').click(function(){
	
	let status = $('.status');
	
	for(let i = 0; i<status.length; i++) {
		status[i].checked = false;
	}
	
	this.checked = true;
})

//선택글 삭제
$('.delete-btn').click(function(){
	
	let deleteConfirm = confirm("선택하신 공지를 삭제하시겠습니까?")
	
	if(deleteConfirm) {
		
		let length = $('.inquiry-check:checked').length;
		
		if(length > 0) {
			
			let numList = []
			
			$('.inquiry-check:checked').each(function(){
				
				let num = $(this).parent().siblings('.inquiry-num').val();				
				numList.push(num);
			});
			
			let data = { num: numList };
			
			$.ajax({
				method:'DELETE',
				url:'/adminPage/board/delete/inquiry',
				data: data
			}).done(function(){
				alert('선택하신 문의가 삭제되었습니다.')
				location.reload();
			})
		} else {
			alert('삭제하실 문의가 선택되지 않았습니다.');
		}
		
	}
})