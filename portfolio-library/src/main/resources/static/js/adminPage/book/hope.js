// 전체선택 이벤트
$('.all-check').click(function(){
	
	if($(this).is(':checked')) {
		$('.loan-check').prop('checked', true);
	} else {
		$('.loan-check').prop('checked', false);
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


//신청 대기 중인 도서 신청 승인
$('.approve-btn').click(function(){
	
	var status = $(this).parent().siblings('.hopeBook-status').text();

	if(status == "대기중"){
		
		let approveConfirm = confirm("해당 신청도서를 승인하시겠습니까?")
		
		if(approveConfirm){
			let num = $(this).parent().siblings('.hopeBook-num').val();
			status = "처리중";
			
			$.ajax({
				method:"POST",
				url:"/adminPage/book/hopeList/changeStatus?status="+status+"&num="+num
			}).done(function(){
				alert("도서신청이 승인되었습니다.")
				location.reload();
			})
		} //if()
	} //if()
})

//희망도서 신청 거부
$('.refusal-btn').click(function(){
	
	let refusalConfirm = confirm('선택하신 신청내역을 거부하시겠습니까?')
	
	if(refusalConfirm) {
		
		let length = $('.hopeBook-check:checked').length;
		
		if(length > 0) {
			let numList = [];
			let check = 0;
			
			$('.hopeBook-check:checked').each(function(e){
				
				let status = $(this).parent().siblings('.hopeBook-status').text();
				console.log(status);
				let num = $(this).parent().siblings('.hopeBook-num').val()
				
				if(status != '대기중') {
					alert('대기중인 도서만 신청 거부하실 수 있습니다.');
					check = 1;
					location.reload();
				} else {
					numList.push(num);
				}
			});
			
			if(check == 0) {
				var data = {num:numList};
				
				$.ajax({
					method: 'POST',
					url: '/adminPage/book/hopeList/changeStatus/checked?status=신청거부',
					data: data
				}).done(function(){
					alert('선택하신 신청들이 거부되었습니다.')
					location.reload();
				})
			} //if()

		} else {
			alert('신청 거부하실 도서가 선택되지 않았습니다.')
		}	
	} //if()
})
	
//처리중 도서 입고처리
$('.receive-btn').click(function(){
	
	let receiveConfirm = confirm('선택하신 신청을 입고 처리하시겠습니까?')
	
	if(receiveConfirm) {
		
		let length = $('.hopeBook-check:checked').length;
		
		if(length > 0) {
			let numList = [];
			let check = 0;
			
			$('.hopeBook-check:checked').each(function(e){
				
				let status = $(this).parent().siblings('.hopeBook-status').text();
				let num = $(this).parent().siblings('.hopeBook-num').val()
				
				if(status != '처리중') {
					alert('처리중인 도서만 입고 처리하실 수 있습니다.');
					check = 1;
					location.reload();
				} else {
					numList.push(num);
				}
			});
			
			if(check == 0) {
				var data = {num:numList};
				
				$.ajax({
					method: 'POST',
					url: '/adminPage/book/hopeList/changeStatus/checked?status=정리중',
					data: data
				}).done(function(){
					alert('선택하신 신청들이 입고 처리되었습니다.')
					location.reload();
				})
			} //if()

		} else {
			alert('입고 처리하실 도서가 선택되지 않았습니다.')
		}	
	} //if()
})

//정리중인 도서 소장완료 처리
$('.complete-btn').click(function(){
	
	let completeConfirm = confirm('선택하신 신청을 소장완료 처리하시겠습니까?')
	
	if(completeConfirm) {
		
		let length = $('.hopeBook-check:checked').length;
		
		if(length > 0) {
			let numList = [];
			let check = 0;
			
			$('.hopeBook-check:checked').each(function(e){
				
				let status = $(this).parent().siblings('.hopeBook-status').text();
				let num = $(this).parent().siblings('.hopeBook-num').val()
				
				if(status != '정리중') {
					alert('정리중인 도서만 소장완료 처리하실 수 있습니다.');
					check = 1;
					location.reload();
				} else {
					numList.push(num);
				}
			});
			
			if(check == 0) {
				var data = {num:numList};
				
				$.ajax({
					method: 'POST',
					url: '/adminPage/book/hopeList/changeStatus/checked?status=소장완료',
					data: data
				}).done(function(){
					alert('선택하신 신청들이 소장 완료되었습니다.')
					location.reload();
				})
			} //if()

		} else {
			alert('소장완료 하실 도서가 선택되지 않았습니다.')
		}	
	} //if()
})