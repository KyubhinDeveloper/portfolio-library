//공지작성 창 띄우기
$('.write-btn').click(function(){
	window.open('/adminPage/board/writeNotice','_blank','top=150, left=20, width=670, height=800, status=no, menubar=no, toolbar=no, resizable=no');
})

//공지관리 창 띄우기
$('.manage-btn').click(function(){
	let num = $(this).parent().siblings('.notice-num').val();
	window.open('/adminPage/board/manageNotice?num=' + num,'_blank','top=150, left=20, width=670, height=800, status=no, menubar=no, toolbar=no, resizable=no');
})

//선택 게시물 삭제
$('.all-check').click(function(){
	if($(this).is(':checked')) {
		$('.notice-check').prop('checked', true);
	} else {
		$('.notice-check').prop('checked', false);
	}
})

//선택글 삭제

$('.delete-btn').click(function(){
	
	let deleteConfirm = confirm("선택하신 공지를 삭제하시겠습니까?")
	
	if(deleteConfirm) {
		
		let length = $('.notice-check:checked').length;
		
		if(length > 0) {
			
			let numList = []
			
			$('.notice-check:checked').each(function(){
				
				let num = $(this).parent().siblings('.notice-num').val();				
				numList.push(num);
			});
			
			let data = { num: numList };
			
			$.ajax({
				method:'DELETE',
				url:'/adminPage/board/delete/notice',
				data: data
			}).done(function(){
				alert('선택하신 공지가 삭제되었습니다.')
				location.reload();
			})
		} else {
			alert('삭제하실 공지가 선택되지 않았습니다.');
		}
		
	}
})