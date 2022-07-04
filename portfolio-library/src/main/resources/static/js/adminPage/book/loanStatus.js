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

//개별 대출승인 이벤트
$('.approve-btn').click(function(){
	
	let status = $(this).parent().siblings('.loan-status').text();
	let num = $(this).parent().siblings('.loan-num').val();
	
	if(status == '대기중') {
		let approveConfirm = confirm('대출을 승인하시겠습니까?');
		if(approveConfirm) {
			
			$.ajax({
				method: "POST",
				url: "/adminPage/book/approveLoan?num="+num
			}).done(function(result){
				
				alert(result);
				location.reload();
			})
		} //if()
	}
})

//체크도서 반납 이벤트
$('.check-return-btn').click(function(){
	
	let returnConfirm = confirm("선택하신 도서를 반납 처리하시겠습니까?")
	
	if(returnConfirm) {
		
		let length = $('.loan-check:checked').length;
		let check = 0;

		if(length > 0) {
	
			let numList = [];
			
			$('.loan-check:checked').each(function(e){
				
				let status = $(this).parent().siblings('.loan-status').text();
				let num = $(this).parent().siblings('.loan-num').val();
				
				if(status == "대기중") {
					alert('대기중인 도서는 반납 처리하실 수 없습니다.');
					check = 1 ;
					location.reload();
				} else {
					numList.push(num);
				}
			});
			
			if(check == 0) {
				var data = { num: numList };
		
				$.ajax({
					method: "DELETE",
					url: "/adminPage/book/returnBook/checked",
					data: data
				}).done(function(){
					
					alert('정상적으로 반납 처리되었습니다.');
					location.reload();
				})	
			}
		} else {
			alert('반납 처리하실 도서가 선택되지 않았습니다.')
		}
	} //if()
})

//개별도서 반납 이벤트
$('.return-btn').click(function(){
	
	let status = $(this).parent().siblings('.loan-status').text();
	let num = $(this).parent().siblings('.loan-num').val();
	console.log(num);
	let returnConfirm = confirm('해당도서를 반납하시겠습니까?')
	
	if(status == '대출중') {
		
		if(returnConfirm) {
		
			$.ajax({
				method: "DELETE",
				url: "/adminPage/book/returnBook?num="+num
			}).done(function(){
				
				alert("정상적으로 반납 처리되었습니다.")
				location.reload();
			})
		}
		
	} else if(status == '연체중' || status == '분실중') {
		alert('기타 현황에서 처리 가능합니다.')
	}
})

//체크대출 취소 이벤트
$('.check-cancel-btn').click(function(){
	
	let cancelConfirm = confirm("선택하신 도서의 대출을 취소하시겠습니까?")
	
	if(cancelConfirm) {
		
		let length = $('.loan-check:checked').length;
		let check = 0;
		let numList = [];
		
		if(length > 0) {
			
			$('.loan-check:checked').each(function(e){
				
				let status = $(this).parent().siblings('.loan-status').text();
				let num = $(this).parent().siblings('.loan-num').val();
				
				if(status != "대기중") {
					alert('대기 중인 도서만 취소 처리하실 수 있습니다.');
					check = 1 ;
					location.reload();
				} else {
					numList.push(num);
				}
			});
			
			if(check == 0) {
				var data = { num: numList };
		
				$.ajax({
					method: "DELETE",
					url: "/adminPage/book/cancelLoan",
					data: data
				}).done(function(){
					
					alert('선택하신 도서의 대출이 취소되었습니다.');
					location.reload();
				})	
			}
		} else {
			alert('취소하실 도서가 선택되지 않았습니다.')
		}
	} //if()
})

//도서 분실처리
$('.loss-btn').click(function(){
	
	let lossConfirm = confirm("선택하신 도서를 분실 처리하시겠습니까?")
	
	if(lossConfirm){		
	
		let status = $(this).parent().siblings('.loan-status').text();
		let num = $(this).parent().siblings('.loan-num').val();
		
		if(status == "대기중") {
			alert('대출 처리된 도서만 분실 처리하실 수 있습니다.');
		} else if(status == "분실중"){
			alert('이미 분실중인 도서입니다.');			
		} else {

			$.ajax({
				method: "PUT",
				url: "/adminPage/book/register/loss?num=" + num,
			}).done(function(){
				
				alert('선택하신 도서가 분실 처리되었습니다.');
				location.reload();
			})			
		} //else	
	} //if()
	
})