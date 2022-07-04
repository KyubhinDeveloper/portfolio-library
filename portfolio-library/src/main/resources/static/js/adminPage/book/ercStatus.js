//연체리스트 가져오기
function overdueList(result) {
	$('.overdue-search-count').text(result.pageDto.totalCount);
	$('.overdue-totalCount').text(result.overdueCount);
	
	if(result.overdueList != null) {
	
		strTable = "";
	
		for(let i = 0; i < result.overdueList.length; i++) {
			
			strTable += `<tr>
							<input class="num" type="hidden" value="`+ result.overdueList[i].num +`"/>
							<td>`+ (result.pageDto.totalCount - (result.pageNum) * result.pageDto.rowCount - (i-3)) +`</td>
							<td>`+ result.overdueList[i].id +`</td>
							<td>`+ result.overdueList[i].name +`</td>
							<td>`+ result.overdueList[i].bookNum +`</td>
							<td>`+ result.overdueList[i].title +`</td>
							<td>`+ result.overdueList[i].endDate +`</td>
							<td>`+ result.overdueList[i].overdueDate +`일</td>
							<td>`+ (result.overdueList[i].overdueDate * 100) +`</td>
							<td>
								<button class="basic-btn overdue-return-btn" type="button">반납</button>
								<button class="basic-btn loss-btn" type="button">분실</button>
							</td>
						</tr>`;
		} //for()
		
		$('.overdue-list-background tbody').html(strTable);
		
		strPagination = "";
		
		strPagination += `
						<input class="overdue-startPage" type="hidden" value=`+ result.pageDto.startPage +`>
						<input class="overdue-pageBlock" type="hidden" value=`+ result.pageDto.pageBlock +`>
						<input class="overdue-pageCount" type="hidden" value=`+ result.pageDto.pageCount +`>
						<nav class="overdue-list-pagination" aria-label="Page navigation">
							<ul class="pagination">
								<li class="page-item">
									<a class="page-link first-page" href="#;" aria-label="first">
										<span aria-hidden="true">
											<i class="fa-solid fa-backward"></i>
										</span>
									</a>
								</li>`;
		if(result.pageDto.startPage > result.pageDto.pageBlock) {
			strPagination += `	<li class="page-item">
									<a class="page-link previous-page" href="#;">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-left"></i>
										</span>
									</a>
								</li>`
		} //if()
		
		for(let j = 1; j <= result.pageDto.endPage; j++) {
			if(j == result.pageNum) {
				strPagination +=`<li class="page-item"><a class="page-link page-num active" href="#;">`+j+`</a></li>`
			} else {
				strPagination +=`<li class="page-item"><a class="page-link page-num" href="#;">`+j+`</a></li>`
			}	
		} //for()
		
		if(result.pageDto.endPage < result.pageDto.pageCount) {				
		strPagination +=`		<li class="page-item">
									<a class="page-link next-page" href="#;" aria-label="Next">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-right"></i>
										</span>
									</a>
								</li>`
		} //if()
		strPagination +=`		<li class="page-item">
									<a class="page-link last-page" href="#;">
										<span aria-hidden="true">
											<i class="fa-solid fa-forward"></i>
										</span>
									</a>
								</li>
							</ul>
						</nav>`
						
		$('.overdue-pagination-box').html(strPagination);
	} else {
		
		$('.overdue-list-background tbody').html(`<tr></tr>`);
		$('.overdue-pagination-box').html(``);
	}
} //overdueList()

function overdueEvent(result) {
		
	//연체도서 검색
	$('.overdue-search-btn').click(function(){
		
		let category = $('.overdue-select option:selected').val();
		let search = $('.overdue-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueStatus?category=" + category + "&search=" + search
		}).done(function(result){			
			overdueList(result)
		})		
	})
	
	//페이지 맨 앞으로
	$(document).on('click', '.overdue-pagination-box .first-page', function(){
		
		let category = $('.overdue-select option:selected').val();
		let search = $('.overdue-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueStatus?pageNum=1&category=" + category + "&search=" + search
		}).done(function(result){			
			overdueList(result)
		})
	})
	
	//이전 페이지
	$(document).on('click', '.overdue-pagination-box .previus-page', function(){
		
		let startPage = $('.overdue-startPage').val();
		let pageBlock = $('.overdue-pageBlock').val();
		let category = $('.overdue-select option:selected').val();
		let search = $('.overdue-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueStatus?pageNum=" + (startPage - pageBlock) + "&category=" + category + "&search=" + search
		}).done(function(result){			
			overdueList(result)
		})
	})
	
	//클릭한 페이지로 이동
	$(document).on('click', '.overdue-pagination-box .page-num', function(){
		
		let pageNum = $(this).text();
		let category = $('.overdue-select option:selected').val();
		let search = $('.overdue-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueStatus?pageNum=" + pageNum + "&category=" + category + "&search=" + search
		}).done(function(result){			
			overdueList(result)
		})
	})
	
	//다음 페이지
	$(document).on('click', '.overdue-pagination-box .next-page', function(){
		
		let startPage = $('.overdue-startPage').val();
		let pageBlock = $('.overdue-pageBlock').val();
		let category = $('.overdue-select option:selected').val();
		let search = $('.overdue-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueStatus?pageNum=" + (startPage + pageBlock) + "&category=" + category + "&search=" + search
		}).done(function(result){			
			overdueList(result)
		})
	})
	
	//마지막 페이지
	$(document).on('click', '.overdue-pagination-box .last-page', function(){
		
		let pageCount = $('.overdue-pageCount').val();
		let category = $('.overdue-select option:selected').val();
		let search = $('.overdue-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueStatus?pageNum=" + pageCount + "&category=" + category + "&search=" + search
		}).done(function(result){			
			overdueList(result)
		})
	})
} //overdueEvent()

function overdueStatus() {
	$.ajax({
		method:"GET",
		url:"/adminPage/book/overdueStatus"
	}).done(function(result){		
		overdueList(result);
		overdueEvent(result);
	}) 
} //overdueStatus()

overdueStatus();


//분실리스트 가져오기
function lossList(result) {
	$('.loss-search-count').text(result.pageDto.totalCount);
	$('.loss-totalCount').text(result.lossCount);
	
	strTable = "";
	
	if(result.lossList != null) {
		
		console.log(result.lossDateList);
		
		for(let i = 0; i < result.lossList.length; i++) {
			
			strTable += `<tr>
							<input class="num" type="hidden" value="`+ result.lossList[i].num +`"/>
							<td>`+ (result.pageDto.totalCount - (result.pageNum) * result.pageDto.rowCount - (i-3)) +`</td>
							<td>`+ result.lossList[i].id +`</td>
							<td>`+ result.lossList[i].name +`</td>
							<td>`+ result.lossList[i].bookNum +`</td>
							<td>`+ result.lossList[i].title +`</td>
							<td>`+ result.lossDateList[i] +`</td>
							<td>`+ result.lossList[i].endDate +`</td>
							<td>`+ result.lossList[i].overdueDate +`일</td>
							<td>`+ (result.lossList[i].overdueDate * 100) +`</td>
							<td>
								<button class="basic-btn loss-return-btn" type="button">반납</button>
							</td>
						</tr>`;
		} //for()
		
		$('.loss-list-background tbody').html(strTable);
		
		strPagination = "";
		strPagination += `
						<input class="loss-startPage" type="hidden" value=`+ result.pageDto.startPage +`>
						<input class="loss-pageBlock" type="hidden" value=`+ result.pageDto.pageBlock +`>
						<input class="loss-pageCount" type="hidden" value=`+ result.pageDto.pageCount +`>
						<nav class="loss-list-pagination" aria-label="Page navigation">
							<ul class="pagination">
								<li class="page-item">
									<a class="page-link first-page" href="#;" aria-label="first">
										<span aria-hidden="true">
											<i class="fa-solid fa-backward"></i>
										</span>
									</a>
								</li>`;
		if(result.pageDto.startPage > result.pageDto.pageBlock) {
			strPagination += `	<li class="page-item">
									<a class="page-link previous-page" href="#;" aria-label="Previous">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-left"></i>
										</span>
									</a>
								</li>`
		} //if()
		
		for(let j = 1; j <= result.pageDto.endPage; j++) {
			if(j == result.pageNum) {
				strPagination +=`<li class="page-item"><a class="page-link page-num active" href="#;">`+j+`</a></li>`
			} else {
				strPagination +=`<li class="page-item"><a class="page-link page-num" href="#;">`+j+`</a></li>`
			}	
		} //for()
		
		if(result.pageDto.endPage < result.pageDto.pageCount) {				
		strPagination +=`		<li class="page-item">
									<a class="page-link next-page" href="#;" aria-label="Next">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-right"></i>
										</span>
									</a>
								</li>`
		} //if()
		strPagination +=`		<li class="page-item">
									<a class="page-link last-page" href="#;" aria-label="last">
										<span aria-hidden="true">
											<i class="fa-solid fa-forward"></i>
										</span>
									</a>
								</li>
							</ul>
						</nav>`
						
		$('.loss-pagination-box').html(strPagination);
	} else {
		
		$('.loss-list-background tbody').html(`<tr></tr>`);
		$('.loss-pagination-box').html(``);
	}
} //lossList()

function lossEvent(result) {
		
	//연체도서 검색
	$('.loss-search-btn').click(function(){
		
		let category = $('.loss-select option:selected').val();
		let search = $('.loss-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossStatus?category=" + category + "&search=" + search
		}).done(function(result){			
			lossList(result)
		})		
	})
	
	//페이지 맨 앞으로
	$(document).on('click', '.loss-pagination-box .first-page', function(){
		
		let category = $('.loss-select option:selected').val();
		let search = $('.loss-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossStatus?pageNum=1&category=" + category + "&search=" + search
		}).done(function(result){			
			lossList(result)
		})
	})
	
	//이전 페이지
	$(document).on('click', '.loss-pagination-box .previus-page', function(){
		
		let startPage = $('.loss-startPage').val();
		let pageBlock = $('.loss-pageBlock').val();
		let category = $('.loss-select option:selected').val();
		let search = $('.loss-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossStatus?pageNum=" + (startPage - pageBlock) + "&category=" + category + "&search=" + search
		}).done(function(result){			
			lossList(result)
		})
	})
	
	//클릭한 페이지로 이동
	$(document).on('click', '.loss-pagination-box .page-num', function(){
		
		let pageNum = $(this).text();
		let category = $('.loss-select option:selected').val();
		let search = $('.loss-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossStatus?pageNum=" + pageNum + "&category=" + category + "&search=" + search
		}).done(function(result){			
			lossList(result)
		})
	})
	
	//다음 페이지
	$(document).on('click', '.loss-pagination-box .next-page', function(){
		
		let startPage = $('.loss-startPage').val();
		let pageBlock = $('.loss-pageBlock').val();
		let category = $('.loss-select option:selected').val();
		let search = $('.loss-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossStatus?pageNum=" + (startPage + pageBlock) + "&category=" + category + "&search=" + search
		}).done(function(result){			
			lossList(result)
		})
	})
	
	//마지막 페이지
	$(document).on('click', '.loss-pagination-box .last-page', function(){
		
		let pageCount = $('.loss-pageCount').val();
		let category = $('.loss-select option:selected').val();
		let search = $('.loss-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossStatus?pageNum=" + pageCount + "&category=" + category + "&search=" + search
		}).done(function(result){			
			lossList(result)
		})
	})
} //lossEvent()

function lossStatus() {
	$.ajax({
		method:"GET",
		url:"/adminPage/book/lossStatus"
	}).done(function(result){
		lossList(result)
		lossEvent(result)
	}) //done()
} //lossStatus()

lossStatus();


//연체도서 분실처리
$(document).on('click', '.loss-btn', function(){
	
	let lossConfirm = confirm('해당 도서를 분실처리 하시겠습니까?');
	
	if(lossConfirm) {
		let num = $(this).parent().siblings('.num').val();	
		
		$.ajax({
			method: 'PUT',
			url: '/adminPage/book/register/loss?num=' + num
		}).done(function(){
			
			alert('해당 도서가 정상적으로 분실처리 되었습니다.');
			location.reload();
		})
	} //if()
})

// 연체도서 반납처리
$(document).on('click', '.overdue-return-btn', function(){
	
	let returnConfirm = confirm('연체도서는 연체로를 지불받고 반납이 가능합니다.\n반납하시겠습니까?');
	
	if(returnConfirm) {
		let num = $(this).parent().siblings('.num').val();	
		
		$.ajax({
			method: 'DELETE',
			url: '/adminPage/book/returnBook?num=' + num
		}).done(function(){
			
			alert('정상적으로 반납되었습니다.');
			location.reload();
		})
	} //if()
})

// 분실도서 반납처리
$(document).on('click', '.loss-return-btn', function(){
	
	let returnConfirm = confirm('분실 중인 도서입니다.\n만약 연체됐을 시 연체로도 지불 받으셔야 합니다.\n반납하시겠습니까?');
	
	if(returnConfirm) {
		let num = $(this).parent().siblings('.num').val();	
		
		$.ajax({
			method: 'DELETE',
			url: '/adminPage/book/returnBook?num=' + num
		}).done(function(){
			
			alert('정상적으로 반납되었습니다.');
			location.reload();
		})
	} //if()
})



