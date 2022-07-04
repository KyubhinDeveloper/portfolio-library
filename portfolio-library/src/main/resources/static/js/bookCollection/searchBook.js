//도서검색 
$('.search-box .search-btn').click(function(){	
	let search = $('#book-search').val();	
	location = "/bookCollection/searchBook?search="+ search; 
})


//소장정보 이벤트
$('.book-status-icon').on('click', function() {

	$(this).parents('.item-box').siblings('.book-loan-status').toggle();
	let isbn = $(this).children('.isbn').val();
	//bnum == bookNum
	let bnum = $(this).parents('.item-box').siblings('.book-loan-status').find('.bookNum');

	$.ajax({
		method: "GET",
		url: "/bookCollection/checkStop?isbn=" + isbn
	}).done(function(check1) {
		
		console.log("check1: "+ check1);

		if (check1) {

			bnum.siblings('.loan-status').html('이용불가능');
			bnum.siblings('.loan-endDay').html('');
			bnum.siblings('.book-service').html('');
			bnum.siblings('.book-function').html('')
		} else {

			$.ajax({
				method: "GET",
				url: "/bookCollection/bookStatus/" + isbn

			}).done(function(result) {

				if (result.loanStatus.length > 0) {

					for (let i = 0; i < result.loanStatus.length; i++) {
						for (j = 0; j < 3; j++) {

							let bookNum = bnum.eq(j);

							$.ajax({
								method: "GET",
								url: "/bookCollection/checkStop?bookNum=" + bookNum.text()
							}).done(function(check2) {
								
								if (check2) {

									bookNum.siblings('.loan-status').html('대출불가능');
									bookNum.siblings('.loan-endDay').html('');
									bookNum.siblings('.book-service').html('');
									bookNum.siblings('.book-function').html('<button class="btn use-btn">이용복구</button>')

								} else {

									let loan = result.loanStatus[i];

									if (bookNum.text() == loan.bookNum) {

										bookNum.siblings('.loan-status').text('대출중');
										bookNum.siblings('.loan-endDay').text(loan.endDate);

										if (loan.id == id && loan.status == "대기중") {
											bookNum.siblings('.book-service').html('<button class="btn cancel-btn loan-cancel">대출취소</button>')
										} else if(loan.id == id && loan.status == "대출중") {
											bookNum.siblings('.book-service').html('대출중인 도서')				
										} else {
											bookNum.siblings('.book-service').html('<button class="btn reserve-btn">예약하기</button>')

											let count = 0;

											for (reserve of result.reserveStatus) {

												if (bookNum.text() == reserve.bookNum) {

													count++;

													if (reserve.id == id) {
														bookNum.siblings('.book-service').html('<button class="btn cancel-btn reserve-cancel">예약취소</button>')
													}
												}
											}

											if (count >= 3) {
												let button = bookNum.siblings('.book-service').children('.btn');
												if (button.hasClass('reserve-btn')) {
													bookNum.siblings('.book-service').html('예약 불가능');
												}
											}
										} //else()
									} //if()
								} //else()
							}) //done()
						} //for()
					} //for()
				} else {
					
					for (j = 0; j < 3; j++) {

						let bookNum = bnum.eq(j);
	
						$.ajax({
							method: "GET",
							url: "/bookCollection/checkStop?bookNum=" + bookNum.text()
						}).done(function(check2) {
							
							if (check2) {
	
								bookNum.siblings('.loan-status').html('대출불가능');
								bookNum.siblings('.loan-endDay').html('');
								bookNum.siblings('.book-service').html('');
								bookNum.siblings('.book-function').html('<button class="btn use-btn">이용복구</button>')
							}
						})
					} //for()
				} //else()
			}) //done()
		} //else()
	})
})

//요약보기 이벤트
$('.book-summary-icon').click(function(){
	$(this).parents('.item-box').siblings('.book-summary-box').toggle();
})

//도서리스트 갯수 설정시 이벤트
$('.select-count').click(function(){
	var icon = $(this).next();	
	icon.addClass('active');
})

//보여줄 도서리스트 갯수 선택시 수정 이벤트
$('.select-count').on('change', function(){
	$('.fa-angle-down').css('transform','none');
	var rowCount = $('.select-count option:selected').val();
	location.href = '/bookCollection/searchBook?rowCount='+ rowCount +'&search='+ search;
})

// 전체선택 이벤트
$('.all-check').click(function(){
	
	if($(this).is(':checked')) {
		$('.bookmark-check').prop('checked', true);
	} else {
		$('.bookmark-check').prop('checked', false);
	}
})

//도서 대출신청 이벤트
$('.book-service .loan-btn').click(function(){
	
	if(id == "") {
		
		alert("세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.");
    	location.href = "/member/login";
		
	} else {
		
		let loanConfirm = confirm('해당 도서를 대출 신청하시겠습니까?');
		if(loanConfirm) {
			
			let bookNum = $(this).parent().siblings('.bookNum').text();
			let title = $(this).parents('.book-loan-status').siblings('.item-box').find('.title').text();
			let author = $(this).parents('.book-loan-status').siblings('.item-box').find('.author').text();
			let publisher = $(this).parents('.book-loan-status').siblings('.item-box').find('.publisher').text();
			let pubdate = $(this).parents('.book-loan-status').siblings('.item-box').find('.pubdate').data('pubdate');
			let isbn = $(this).parents('.book-loan-status').siblings('.item-box').find('.isbn').val();
			
			let loanBookVo = {
				bookNum: bookNum,
				title: title,
				author: author,
				publisher: publisher,
				pubdate: pubdate,
				isbn: isbn
			}
			
			var data = JSON.stringify(loanBookVo);
			
			$.ajax({
				method: "POST",
				url: "/bookCollection/loanBook",
				data: data,
				contentType: 'application/json; charset=utf-8'
			}).done(function(result){
				
				alert(result);
				location.reload();
				
			})
		} //if()
	} //else()
})

//대출신청 취소 이벤트
$(document).on('click', '.loan-cancel', function(){
	
	let cancelConfirm = confirm('대출 신청을 취소하시겠습니까?');
	
	if(cancelConfirm) {
		let bookNum = $(this).parent().siblings('.bookNum').text();
		
		$.ajax({
			method:"DELETE",
			url:"/bookCollection/cancelLoan/"+ bookNum,
		}).done(function(result){
			
			alert(result)
			location.reload();
		})
	} //if()
})

//예약신청 이벤트
$(document).on('click', '.reserve-btn', function(){
	
	if(id == "") {
		
		alert("세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.");
    	location.href = "/member/login";
		
	} else {
	
		let reserveConfirm = confirm('해당 도서를 예약 신청하시겠습니까?');
	
		if(reserveConfirm) {
			let bookNum = $(this).parent().siblings('.bookNum').text();
			let title = $(this).parents('.book-loan-status').siblings('.item-box').find('.title').text();
			let isbn = $(this).parents('.book-loan-status').siblings('.item-box').find('.isbn').val();
			
			let reserveBookVo = {
					id: id,
					title: title,
					bookNum: bookNum,
					isbn: isbn
				}
				
			var data = JSON.stringify(reserveBookVo);	
			
			$.ajax({
				method:"POST",
				url:"/bookCollection/reserveBook",
				data: data,
				contentType: 'application/json; charset=utf-8'
			}).done(function(result){
				
				alert(result)
				location.reload();
			})
		}	
	} //else()
})

//예약신청 취소 이벤트
$(document).on('click', '.reserve-cancel', function(){
	
	let cancelConfirm = confirm('도서예약을 취소하시겠습니까?');
	
	if(cancelConfirm) {
		let bookNum = $(this).parent().siblings('.bookNum').text();
		
		$.ajax({
			method:"DELETE",
			url:"/bookCollection/cancelReservation/"+ bookNum + "/" + id,
		}).done(function(result){
			
			alert(result)
			location.reload();
		})
	} //if()
})

//도서 사용중지 이벤트
$('.stop-btn').click(function(){
	
	let bookNum = $(this).parent().siblings('.bookNum');
	let stopConfirm = confirm('해당 도서의 이용을 중지하시겠습니까?')
	
	if(stopConfirm) {
		$.ajax({
			method: "POST",
			url:"/bookCollection/stopUsing?bookNum="+bookNum.text()
		}).done(function(result){
			
			console.log("등록번호: " + bookNum.text());
			
			if(result) {
				alert("해당 도서의 이용이 중지되었습니다.")
				location.reload();
			} else {
				alert("이미 이용 중지된 도서입니다.")
				location.reload();
			}
		})
	} //if()
})

//도서 사용가능 이벤트
$(document).on('click','.use-btn', function(){
	
	let bookNum = $(this).parent().siblings('.bookNum');
	let useConfirm = confirm('해당 도서가 이용 가능하도록 하시겠습니까?')
	
	if(useConfirm) {
		$.ajax({
			method:"DELETE",
			url:"/bookCollection/recoveryBook?bookNum="+bookNum.text()
		}).done(function(){	
		
			location.reload();
			
		})
	} //if()
})

// 해당 도서 전체 사용중지 이벤트
$('.stop-all-btn').click(function(){
	
	let isbn = $(this).parent().siblings('.icon-wrap').find('.isbn').val();
	let stopConfirm = confirm('이 도서의 모든 이용을 중지하시겠습니까? ')
	
	if(stopConfirm) {
		$.ajax({
			method: "POST",
			url:"/bookCollection/stopUsing?isbn="+isbn
		}).done(function(result){
			
			if(result) {
				alert("이 도서의 모든 이용이 중지되었습니다.")
				location.reload();
			} else {
				alert("이미 이용 중지된 도서입니다.")
				location.reload();
			}
		})
	} //if()
})

// 해당 도서 전체 사용가능 이벤트
$('.use-all-btn').click(function(){
	
	let isbn = $(this).parent().siblings('.icon-wrap').find('.isbn').val();

	let useConfirm = confirm('이 도서가 모두 이용 가능하도록 하시겠습니까?')
	
	if(useConfirm) {
		$.ajax({
			method:"DELETE",
			url:"/bookCollection/recoveryBook?isbn="+isbn
		}).done(function(){	
		
			location.reload();
		})
	} //if()
})

// 내서재 개별 클릭
$('.bookmark-icon').click(function(){
	
	if(id == "") {
		
		alert("세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.");
    	location.href = "/member/login";
		
	} else {
		
		let okConfirm = confirm('해당 도서를 내 서재에 담으시겠습니까?')

		if(okConfirm){
			
			let title = $(this).parents('.book-detail-box').find('.title').text();
			let author = $(this).parents('.book-detail-box').find('.author').text();
			let publisher = $(this).parents('.book-detail-box').find('.publisher').text();
			let pubdate = $(this).parents('.book-detail-box').find('.pubdate').data('pubdate');
			let isbn = $(this).parent().find('.isbn').val();
			
			let bookmarkVo = {
				title: title,
				author: author,
				publisher: publisher,
				pubdate: pubdate,
				isbn: isbn
			}		
			
			var data = JSON.stringify(bookmarkVo);	
				
			$.ajax({
				method:"POST",
				url:"/bookCollection/bookmark",
				data: data,
				contentType: 'application/json; charset=utf-8'
			}).done(function(){
				
				alert("내 서재에 입력되었습니다.")
				location.reload();
			})
		} //if()
	} //else()
})

// 체크리스트 전체 내서재 등록
$('.bookmark-box').click(function(){
	
	if(id == "") {
		
		alert("세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.");
    	location.href = "/member/login";
		
	} else {
		
		let okConfirm = confirm('해당 도서를 내 서재에 담으시겠습니까?')
		
		if(okConfirm){
			
			let length = $('.bookmark-check:checked').length;
			let list = [];
			
			if(length > 0) {
				$('.bookmark-check:checked').each(function(e){
					
					let value = $(this).siblings('.isbn').val();
					list.push(value);
				});
				
				var data = {isbnList: list};

				$.ajax({
					method:"POST",
					url:"/bookCollection/bookmarkList",
					data: data
				}).done(function(){
					
					alert("내 서재에 입력되었습니다.")
					location.reload();
				})
			} else {
				
				alert("내 서재에 담을 도서가 존재하지 않습니다.")
			}
		} //if
	} //else 
})


