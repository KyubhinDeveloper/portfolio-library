//체크중복처리x
$('.type').click(function(){
	
	let type = $('.type');
	
	for(let i = 0; i<type.length; i++) {
		type[i].checked = false;
	}
	
	this.checked = true;
})

//대출기록 리스트
function loanList(result) {
	
	$('.loanRecord-search-count').text(result.pageDto.totalCount);
	$('.loanRecord-totalCount').text(result.loanRecordCnt);
	
	if(result.loanRecord != null) {
		
		strTable = "";
		
		for(let i = 0; i < result.loanRecord.length; i++) {
			
			strTable += `<tr>
							<td>`+ (result.pageDto.totalCount - (result.pageNum) * result.pageDto.rowCount - (i-7)) +`</td>
							<td>`+ result.loanRecord[i].id +`</td>
							<td>`+ result.loanRecord[i].name +`</td>
							<td>`+ result.loanRecord[i].bookNum +`</td>
							<td>`+ result.loanRecord[i].title +`</td>
							<td>`+ result.loanRecord[i].loanDate +`</td>
							<td>`+ result.loanRecord[i].returnDate +`일</td>
							<td>`+ result.loanRecord[i].type +`</td>
						</tr>`;
		} //for()
		
		$('.loanRecord-list-table tbody').html(strTable);
		
		strPagination = "";
		
		strPagination += `
						<input class="loanRecord-startPage" type="hidden" value=`+ result.pageDto.startPage +`>
						<input class="loanRecord-pageBlock" type="hidden" value=`+ result.pageDto.pageBlock +`>
						<input class="loanRecord-pageCount" type="hidden" value=`+ result.pageDto.pageCount +`>
						<nav class="record-pagination" aria-label="Page navigation">
							<ul class="pagination">
								<li class="page-item">
									<a href="#;" class="page-link loanRecord-first-page" aria-label="First">
										<span aria-hidden="true">
											<i class="fa-solid fa-backward"></i>
										</span>
									</a>
								</li>`;
		if(result.pageDto.startPage > result.pageDto.pageBlock) {
			strPagination += `	<li class="page-item">
									<a href="#;" class="page-link loanRecord-previous-page" aria-label="Prev">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-left"></i>
										</span>
									</a>
								</li>`
		} //if()
		
		for(let j = 1; j <= result.pageDto.pageCount; j++) {
			if(j == result.pageNum) {
				strPagination +=`<li class="page-item">
									<a href="#;" class="page-link loanRecord-page-num active" >`+j+`</a>
								</li>`
			} else {
				strPagination +=`<li class="page-item">
									<a href="#;" class="page-link loanRecord-page-num" >`+j+`</a>
								</li>`
			}	
		} //for()
		
		if(result.pageDto.endPage < result.pageDto.pageCount) {				
		strPagination +=`		<li class="page-item">
									<a href="#;" class="page-link loanRecord-next-page" aria-label="Next">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-right"></i>
										</span>
									</a>
								</li>`
		} //if()
		strPagination +=`		<li class="page-item">
									<a href="#;" class="page-link loanRecord-last-page" aria-label="Last">
										<span aria-hidden="true">
											<i class="fa-solid fa-forward"></i>
										</span>
									</a>
								</li>
							</ul>
						</nav>`
						
		$('.loanRecord-pagination-box').html(strPagination);
						
	} else {
		
		$('.loanRecord-list-table tbody').html(`<tr></tr>`);
		$('.loanRecord-pagination-box').html(``);
	}
} //loanList()

function loanRecordEvent(result) {
	
	//대출기록 검색
	$('.loanRecord-search-btn').click(function(){
		
		let type = $('.type:checked').val();
		let category = $('.loanRecord-search-select option:selected').val();
		if(type == null) {
			type = "";
		}	
		let search = $('.loanRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/loanRecord?category=" + category + "&search=" + search + "&type=" + type,
			async : false
		}).done(function(result){		
			loanList(result)
		})	
	})
	
	//페이지 맨 앞으로
	$(document).on('click','.loanRecord-first-page', function(){
		
		let type = $('.type:checked').val();
		if(type == null) {
			type = "";
		}
		let category = $('.loanRecord-search-select option:selected').val();
		let search = $('.loanRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/loanRecord?pageNum=1&category=" + category + "&search=" + search + "&type=" + type,
			async : false
		}).done(function(result){			
			loanList(result)
		})
	})
	
	//이전 페이지
	$(document).on('click','.loanRecord-previus-page', function(){
		
		let startPage = $('.loanRecord-startPage').val();
		let pageBlock = $('.loanRecord-pageBlock').val();
		let type = $('.type:checked').val();
		let category = $('.loanRecord-search-select option:selected').val();
		if(type == null) {
			type = "";
		}	
		let search = $('.loanRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/loanRecord?pageNum=" + (startPage - pageBlock) + "&category=" + category + "&search=" + search + "&type=" + type,
			async : false
		}).done(function(result){			
			loanList(result)
		})
	})
	
	//클릭한 페이지로 이동
	$(document).on('click','.loanRecord-page-num', function(){
		
		let type = $('.type:checked').val();
		let category = $('.loanRecord-search-select option:selected').val();
		if(type == null) {
			type = "";
		}	
		let search = $('.loanRecord-search-input').val();
		let pageNum = $(this).text();

		$.ajax({
			method:"GET",
			url:"/adminPage/book/loanRecord?pageNum=" + pageNum + "&category=" + category + "&search=" + search + "&type=" + type,
			async : false
		}).done(function(result){			
			loanList(result)
		})
	})
			
	//다음 페이지
	$(document).on('click','.loanRecord-next-page', function(){
		
		let startPage = $('.loanRecord-startPage').val();
		let pageBlock = $('.loanRecord-pageBlock').val();
		let type = $('.type:checked').val();
		let category = $('.loanRecord-search-select option:selected').val();
		if(type == null) {
			type = "";
		}	
		let search = $('.loanRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/loanRecord?pageNum=" +(startPage + pageBlock)+ "&category=" + category + "&search=" + search + "&type=" + type,
			async : false
		}).done(function(result){			
			loanList(result)
		})
	})
	
	//마지막 페이지
	$(document).on('click', '.loanRecord-last-page', function(){
		
		let pageCount = $('.loanRecord-pageCount').val();
		let type = $('.type:checked').val();
		if(type == null) {
			type = "";
		}	
		let category = $('.loanRecord-search-select option:selected').val();
		let search = $('.loanRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/loanRecord?pageNum=" + pageCount + "&category=" + category + "&search=" + search + "&type=" + type,
			async : false
		}).done(function(result){			
			loanList(result)
		})
	})
} //loanRecordEvent()

//대출기록 가져오기
function loanRecord() {
	$.ajax({
		method:"GET",
		url:"/adminPage/book/loanRecord",
		async : false
	}).done(function(result){		
		loanList(result)
		loanRecordEvent(result)	
	}) //done()
} //lossStatus()

loanRecord()

//----------------------------------------------------

//연체기록 리스트
function overdueList(result) {
	$('.overdueRecord-search-count').text(result.pageDto.totalCount);
	$('.overdueRecord-totalCount').text(result.odRecordCnt);
	
	if(result.overdueRecord != null) {
		
		strTable = "";
		
		for(let i = 0; i < result.overdueRecord.length; i++) {
			
			strTable += `<tr>
							<td>`+ (result.pageDto.totalCount - (result.pageNum) * result.pageDto.rowCount - (i-5)) +`</td>
							<td>`+ result.overdueRecord[i].id +`</td>
							<td>`+ result.overdueRecord[i].name +`</td>
							<td>`+ result.overdueRecord[i].bookNum +`</td>
							<td>`+ result.overdueRecord[i].title +`</td>
							<td>`+ result.overdueRecord[i].returnDate +`</td>
							<td>`+ result.overdueRecord[i].overdueDate +`일</td>
							<td>`+ result.overdueRecord[i].latefee +`</td>
						</tr>`;
		} //for()
		
		$('.overdueRecord-list-table tbody').html(strTable);
		
		strPagination = "";
		
		strPagination += `
						<input class="overdueRecord-startPage" type="hidden" value=`+ result.pageDto.startPage +`>
						<input class="overdueRecord-pageBlock" type="hidden" value=`+ result.pageDto.pageBlock +`>
						<input class="overdueRecord-pageCount" type="hidden" value=`+ result.pageDto.pageCount +`>
						<nav class="record-pagination" aria-label="Page navigation">
							<ul class="pagination">
								<li class="page-item">
									<a href="#;" class="page-link overdueRecord-first-page" aria-label="First">
										<span aria-hidden="true">
											<i class="fa-solid fa-backward"></i>
										</span>
									</a>
								</li>`;
		if(result.pageDto.startPage > result.pageDto.pageBlock) {
			strPagination += `	<li class="page-item">
									<a href="#;" class="page-link overdueRecord-previous-page" aria-label="Prev">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-left"></i>
										</span>
									</a>
								</li>`
		} //if()
		
		for(let j = 1; j <= result.pageDto.pageCount; j++) {
			if(j == result.pageNum) {
				strPagination +=`<li class="page-item">
									<a href="#;" class="page-link overdueRecord-page-num active" >`+j+`</a>
								</li>`
			} else {
				strPagination +=`<li class="page-item">
									<a href="#;" class="page-link overdueRecord-page-num" >`+j+`</a>
								</li>`
			}	
		} //for()
		
		if(result.pageDto.endPage < result.pageDto.pageCount) {				
		strPagination +=`		<li class="page-item">
									<a href="#;" class="page-link overdueRecord-next-page" aria-label="Next">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-right"></i>
										</span>
									</a>
								</li>`
		} //if()
		strPagination +=`		<li class="page-item">
									<a href="#;" class="page-link overdueRecord-last-page" aria-label="Last">
										<span aria-hidden="true">
											<i class="fa-solid fa-forward"></i>
										</span>
									</a>
								</li>
							</ul>
						</nav>`
						
		$('.overdueRecord-pagination-box').html(strPagination);
						
	} else {
		
		$('.overdueRecord-list-table tbody').html(`<tr></tr>`);
		$('.overdueRecord-pagination-box').html(``);
	}
} //overdueList()

function overdueRecordEvent(result) { //overdue == od
	
	//연체기록 검색
	$('.overdueRecord-search-btn').click(function(){
		
		let category = $('.overdueRecord-search-select option:selected').val();	
		let search = $('.overdueRecord-search-input').val();
	
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueRecord?category=" + category + "&search=" + search,
			async : false
		}).done(function(result){		
			overdueList(result)
		})	
	})
	
	//페이지 맨 앞으로
	$(document).on('click','.overdueRecord-first-page', function(){
		
		let category = $('.overdueRecord-search-select option:selected').val();
		let search = $('.overdueRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueRecord?pageNum=1&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			overdueList(result)
		})
	})
	
	//이전 페이지
	$(document).on('click','.overdueRecord-previus-page', function(){
		
		let startPage = $('.overdueRecord-startPage').val();
		let pageBlock = $('.overdueRecord-pageBlock').val();
		let category = $('.overdueRecord-search-select option:selected').val();
		let search = $('.overdueRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueRecord?pageNum=" + (startPage - pageBlock) + "&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			overdueList(result)
		})
	})
	
	//클릭한 페이지로 이동
	$(document).on('click','.overdueRecord-page-num', function(){
		
		let category = $('.overdueRecord-search-select option:selected').val();	
		let search = $('.overdueRecord-search-input').val();
		let pageNum = $(this).text();

		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueRecord?pageNum=" + pageNum + "&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			overdueList(result)
		})
	})
			
	//다음 페이지
	$(document).on('click','.overdueRecord-next-page', function(){
		
		let startPage = $('.overdueRecord-startPage').val();
		let pageBlock = $('.overdueRecord-pageBlock').val();
		let category = $('.overdueRecord-search-select option:selected').val();	
		let search = $('.overdueRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueRecord?pageNum=" +(startPage + pageBlock)+ "&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			overdueList(result)
		})
	})
	
	//마지막 페이지
	$(document).on('click', '.overdueRecord-last-page', function(){
		
		let pageCount = $('.overdueRecord-pageCount').val();	
		let category = $('.overdueRecord-search-select option:selected').val();
		let search = $('.overdueRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/overdueRecord?pageNum=" + pageCount + "&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			overdueList(result)
		})
	})
} //overdueRecordEvent()

//연체기록 가져오기
function overdueRecord() {
	$.ajax({
		method:"GET",
		url:"/adminPage/book/overdueRecord"
	}).done(function(result){		
		overdueList(result)
		overdueRecordEvent(result)
	}) 
} //overdueStatus()

overdueRecord();

//----------------------------------------------------

//분실기록 리스트
function lossList(result) {
	$('.lossRecord-search-count').text(result.pageDto.totalCount);
	$('.lossRecord-totalCount').text(result.lossRecordCnt);
	
	if(result.lossRecord != null) {
		
		strTable = "";
		
		for(let i = 0; i < result.lossRecord.length; i++) {
			
			strTable += `<tr>
							<td>`+ (result.pageDto.totalCount - (result.pageNum) * result.pageDto.rowCount - (i-5)) +`</td>
							<td>`+ result.lossRecord[i].id +`</td>
							<td>`+ result.lossRecord[i].name +`</td>
							<td>`+ result.lossRecord[i].bookNum +`</td>
							<td>`+ result.lossRecord[i].title +`</td>
							<td>`+ result.lossRecord[i].lossDate +`</td>
							<td>`+ result.lossRecord[i].returnDate +`</td>
						</tr>`;
		} //for()
		
		$('.lossRecord-list-table tbody').html(strTable);
		
		strPagination = "";
		
		strPagination += `
						<input class="lossRecord-startPage" type="hidden" value=`+ result.pageDto.startPage +`>
						<input class="lossRecord-pageBlock" type="hidden" value=`+ result.pageDto.pageBlock +`>
						<input class="lossRecord-pageCount" type="hidden" value=`+ result.pageDto.pageCount +`>
						<nav class="record-pagination" aria-label="Page navigation">
							<ul class="pagination">
								<li class="page-item">
									<a href="#;" class="page-link lossRecord-first-page" aria-label="First">
										<span aria-hidden="true">
											<i class="fa-solid fa-backward"></i>
										</span>
									</a>
								</li>`;
		if(result.pageDto.startPage > result.pageDto.pageBlock) {
			strPagination += `	<li class="page-item">
									<a href="#;" class="page-link lossRecord-previous-page" aria-label="Prev">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-left"></i>
										</span>
									</a>
								</li>`
		} //if()
		
		for(let j = 1; j <= result.pageDto.pageCount; j++) {
			if(j == result.pageNum) {
				strPagination +=`<li class="page-item">
									<a href="#;" class="page-link lossRecord-page-num active" >`+j+`</a>
								</li>`
			} else {
				strPagination +=`<li class="page-item">
									<a href="#;" class="page-link lossRecord-page-num" >`+j+`</a>
								</li>`
			}	
		} //for()
		
		if(result.pageDto.endPage < result.pageDto.pageCount) {				
		strPagination +=`		<li class="page-item">
									<a href="#;" class="page-link lossRecord-next-page" aria-label="Next">
										<span aria-hidden="true">
											<i class="fa-solid fa-angle-right"></i>
										</span>
									</a>
								</li>`
		} //if()
		strPagination +=`		<li class="page-item">
									<a href="#;" class="page-link lossRecord-last-page" aria-label="Last">
										<span aria-hidden="true">
											<i class="fa-solid fa-forward"></i>
										</span>
									</a>
								</li>
							</ul>
						</nav>`
						
		$('.lossRecord-pagination-box').html(strPagination);
						
	} else {
		
		$('.lossRecord-list-table tbody').html(`<tr></tr>`);
		$('.lossRecord-pagination-box').html(``);	
	}
} //lossList()

function lossRecordEvent(result) { 
	
	//분실기록 검색
	$('.lossRecord-search-btn').click(function(){
		
		let category = $('.lossRecord-search-select option:selected').val();	
		let search = $('.lossRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossRecord?category=" + category + "&search=" + search,
			async : false
		}).done(function(result){		
			lossList(result)
		})	
	})
	
	//페이지 맨 앞으로
	$(document).on('click','.lossRecord-first-page', function(){
		
		let category = $('.lossRecord-search-select option:selected').val();
		let search = $('.lossRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossRecord?pageNum=1&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			lossList(result)
		})
	})
	
	//이전 페이지
	$(document).on('click','.lossRecord-previus-page', function(){
		
		let startPage = $('.lossRecord-startPage').val();
		let pageBlock = $('.lossRecord-pageBlock').val();
		let category = $('.lossRecord-search-select option:selected').val();
		let search = $('.lossRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossRecord?pageNum=" + (startPage - pageBlock) + "&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			lossList(result)
		})
	})
	
	//클릭한 페이지로 이동
	$(document).on('click','.lossRecord-page-num', function(){
		
		let category = $('.lossRecord-search-select option:selected').val();	
		let search = $('.lossRecord-search-input').val();
		let pageNum = $(this).text();

		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossRecord?pageNum=" + pageNum + "&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			lossList(result)
		})
	})
			
	//다음 페이지
	$(document).on('click','.lossRecord-next-page', function(){
		
		let startPage = $('.lossRecord-startPage').val();
		let pageBlock = $('.lossRecord-pageBlock').val();
		let category = $('.lossRecord-search-select option:selected').val();	
		let search = $('.lossRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossRecord?pageNum=" +(startPage + pageBlock)+ "&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			lossList(result)
		})
	})
	
	//마지막 페이지
	$(document).on('click', '.lossRecord-last-page', function(){
		
		let pageCount = $('.lossRecord-pageCount').val();	
		let category = $('.lossRecord-search-select option:selected').val();
		let search = $('.lossRecord-search-input').val();
		
		$.ajax({
			method:"GET",
			url:"/adminPage/book/lossRecord?pageNum=" + pageCount + "&category=" + category + "&search=" + search,
			async : false
		}).done(function(result){			
			lossList(result)
		})
	})
} //lossRecordEvent()

//분실기록 가져오기
function lossRecord() {
	$.ajax({
		method:"GET",
		url:"/adminPage/book/lossRecord"
	}).done(function(result){		
		lossList(result)
		lossRecordEvent(result)
	}) 
} //lossRecord()

lossRecord();

