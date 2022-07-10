//commentTime()
function commentTime(time) {
	
	var today = new Date();
	var registerDate = new Date(time); // new Date('2022-03-20T14:56:45');
	var timeGap = today.getTime() - registerDate.getTime(); // 밀리초 차이값
	var oneDay = 1000 * 60 * 60 * 24;
	var oneHour = 1000 * 60 * 60
	var strArr = time.split('T');
	var str;
	
	if(timeGap < oneHour ) {
		
		if(timeGap/60000 < 1) {
			str = '1분 전';
		} else {
			str = parseInt(timeGap/60000) + '분 전';
		}	
	} else if (timeGap > oneHour && timeGap < oneDay) {
		
		str = parseInt(timeGap/oneHour) + '시간 전';
		
	} else {
		
		str = strArr[0].substring(0,16);
	}
	
	return str;
}

//getCommentList()
function getCommentList(pageNum) {
	
	if(pageNum == null){
		pageNum = 1;
	}
	
	$.ajax({
		method: 'GET',
		url: '/comment/list?bno='+ bno +'&pageNum=' + pageNum	 
	}).done(function(result){
		
		let commentCnt = result.commentDto.commentCnt; //commentCnt = commentCount
		
		if(commentCnt > 0) {
			
			let commentList = result.commentDto.commentList;
			let parentList = result.parentList;
			let pageNum = result.pageNum
			
			//댓글 리스트 구현
			showCommentList(commentCnt, commentList, parentList, pageNum);
			//댓글 pagination 구현
			showCommentPage(commentCnt,pageNum)
		}
	})
} 

getCommentList();

//showCommentList()
function showCommentList(commentCnt, commentList, parentList, pageNum) {
	// commentCnt = commentCount

	if(commentList == null || commentList.length == 0) {
		return;
	}
	
	let i = 0;
	str = '';
	str += `	<h4 class="comment-count" data-page="`+pageNum+`"><i class="fa-solid fa-comments"></i>댓글 <span class="count">`+ commentCnt +`</span>개</h4>`
	
	for (comment of commentList) {

		let name = comment.name.substring(0, 1).concat('*'.repeat(comment.name.length - 1));

		str += `<div class="comment-content-box" data-cno="` + comment.cno + `" style="margin-left: ` + comment.cmLevel + `0px;">
				 	<div class="d-flex content-top">
                        <div class="d-flex writer-box">`;
		if (comment.id == "admin") {
			if (comment.cmLevel > 0) {
				str += `	<img src="/img/community/icon-comment.png" alt="" style="opacity: 0.5; margin-right: 5px;">`
			}
			str += `		<h5>` + comment.name + `</h5>`;
		} else {
			if (comment.cmLevel > 0) {
				str += `	<img src="/img/community/icon-comment.png" alt="" style="opacity: 0.5; margin-right: 5px;">`
			}
			str += `		<h5>${name}</h5>`;
		}
		str += `			<p>` + commentTime(comment.regDate) + `</p>
                        </div>
                        <div class="comment-icon">`
		if (id == comment.id || id == "admin") {
			str += `		<div class="d-flex btn-box">
		            			<button type="button" class="btn toggle-edit-btn"><i class="fa-solid fa-pencil"></i>수정</button>
		                		<button class="btn comment-delete-btn"><i class="fa-solid fa-eraser"></i>삭제</button>
		            		</div>`
		};
		if (id != "") {
			str += `		<div class="icon-box">	
	        					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
	                                <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
	                                <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"/>
	                            </svg>
	                            답글
	                        </div> `
		}
		str += `         </div>
					</div>
                    <div class="content-main">`
		if (comment.cmLevel > 0) {
			// 댓글단 원본댓글 작성자의 이름
			let parent = parentList[i].substring(0, 1).concat('*'.repeat(comment.name.length - 1));
			
			if (comment.comment == "") {
				str += `<p>[삭제된 댓글입니다.]</p>`
			} else if (parentList[i] == "관리자") {
				str += `<p><span style="color: #aaa; margin-right: 5px">` + parentList[i] + `</span>` + comment.comment + `</p>`
			} else {
				str += `<p><span style="color: #aaa; margin-right: 5px">` + parent + `</span>` + comment.comment + `</p>`
			}

		} else {

			if (comment.comment == "") {
				str += `<p>[삭제된 댓글입니다.]</p>`
			} else {
				str += `<p>` + comment.comment + `</p>`
			}

		}

		str += `    </div>                            
    				<div class="comment-comment-wrap">
                        <div class="d-flex">
                        	<div class="d-flex">
	                            <img src="/img/community/icon-comment.png" alt="">
	                            <h4>댓글 쓰기</h4>
                            </div>
                            <div class="d-flex close-box register-close">
                            	<i class="fa-solid fa-xmark"></i>
                            	<p>닫기</p>
                            </div>
                        </div>
                        <input id="cno" type="hidden" value="` + comment.cno + `"/>
                    	<input id="cmRef" type="hidden" value="` + comment.cmRef + `"/>
                    	<input id="cmLevel" type="hidden" value="` + comment.cmLevel + `"/>
                    	<input id="cmStep" type="hidden" value="` + comment.cmStep + `"/>
                        <textarea id="comment" cols="210" rows="5"></textarea>
                        <div class="d-flex justify-content-end">
                        	<button class="comment-btn cm-register-btn">등록</button>
                        </div>	
                    </div>
                    <div class="comment-edit-wrap">
                        <div class="d-flex">
                        	<div class="d-flex">
                            	<img src="/img/community/icon-comment.png" alt="">
                            	<h4>댓글 수정</h4>
                            </div>
                            <div class="d-flex close-box edit-close">
                            	<i class="fa-solid fa-xmark"></i>
                            	<p>닫기</p>
                            </div>
                        </div>
                        <textarea name="content" cols="210" rows="5">`+ comment.comment + `</textarea>
                        <div class="d-flex justify-content-end">
                        	<button class="comment-btn comment-edit-btn">수정</button>
                        </div>	
                    </div>
            	</div>`;
		i++;
	}
	                                
	$('.comment-list-wrap').html(str);
}

//showCommentPage()
function showCommentPage(commentCnt,pageNum) {
	
	if(commentCnt <= 15){
		
		return;
		
	} else {
		
		// 한 페이지에 보여지는 댓글 총 갯수
		var rowCount = 15;
		// 총 댓글 페이지 갯수
		var pageCount = Math.ceil(commentCnt / rowCount);
		// 한 페이지 당 블록 갯수
		var pageBlock = 5;
		// 한 페이지의 시작번호
		var startPage = (Math.floor((pageNum - 1) / pageBlock)) * pageBlock + 1;
		// 한 페이지 블록의 끝페이지
		var endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
		var str = '';
		
		str += `<ul class="pagination inquiry-pagination">`
		str += `	<li class="page-item first">
						<a class="page-link" href="`+startPage+`">
							<i class="fa-solid fa-backward"></i>
						</a>
					</li>`
		for(let i = startPage; i<=endPage; i++) {
			
			let active = (pageNum == i) ? 'active' : '';
			
			str += `<li class="page-item `+ active +`">
						<a class="page-link number" href="`+i+`">`+i+`</a>
					</li>`
		}
		str += `    <li class="page-item last">
						<a class="page-link" href="`+endPage+`">
							<i class="fa-solid fa-forward"></i>
						</a>
					</li>
				</ul>`		
		$('.navigation').html(str);
	}
}

//댓글등록 이벤트
$('.register-btn').click(function(){
	let cmText = $(this).prev().val(); //cmText == commentText
	
	if(cmText == ""){
		
		alert("댓글 내용을 반드시 입력해주세요.")

	} else {
		
		let registerConfirm = confirm('댓글을 등록하시겠습니까?');

		if (registerConfirm) {

			let commentVo = {
				bno: bno,
				id: id,
				name: name,
				comment: cmText
			}
			var data = JSON.stringify(commentVo);

			$.ajax({
				method: "POST",
				url: "/comment/insert",
				data: data,
				contentType: 'application/json; charset=utf-8'
			}).done(function() {
				getCommentList(1);
				$('.comment-write-wrap #comment').val("");
			})
		}
	}	
});

//대댓글등록 이벤트
$(document).on('click', '.cm-register-btn', function(){
	
	let cmText = $(this).parent().prev().val(); //cmText == commentText
	
	if(cmText == ""){
		
		alert("댓글 내용을 반드시 입력해주세요.")

	} else {
		
		let registerConfirm = confirm('댓글을 등록하시겠습니까?');
		
		if (registerConfirm) {
			
			let pageNum = $('.comment-count').data('page');
			let cno = $(this).parent().siblings('#cno').val()
			let cmRef = $(this).parent().siblings('#cmRef').val()
			let cmLevel = $(this).parent().siblings('#cmLevel').val()
			let cmStep = $(this).parent().siblings('#cmStep').val()
			
			let commentVo = {
				cno: cno,
				bno: bno,
				id: id,
				name: name,
				comment: cmText,
				cmRef: cmRef,
				cmLevel: cmLevel,
				cmStep: cmStep
			}
			
			var data = JSON.stringify(commentVo);
			
			$.ajax({
				method: "POST",
				url: "/comment/insertNestedCm/"+ pageNum,
				data: data,
				contentType: 'application/json; charset=utf-8'
			}).done(function(result) {
				getCommentList(result);
			})
		}
	}
})
//수정화면 토글 이벤트	
$(document).on('click', '.toggle-edit-btn', function() {
	$(this).parents('.content-top').siblings('.comment-edit-wrap').toggle();
})

//수정화면 닫기 버튼 이벤트	
$(document).on('click', '.edit-close', function() {
	$(this).parents('.comment-edit-wrap').hide();
})

//대댓글화면 토글 이벤트	
$(document).on('click', '.icon-box', function() {
	$(this).parents('.content-top').siblings('.comment-comment-wrap').toggle();
})

//대댓글 화면 닫기 이벤트
$(document).on('click', '.register-close', function() {
	$(this).parents('.comment-comment-wrap').hide();
})

//댓글수정 이벤트
$(document).on('click', '.comment-edit-btn', function() {
	
	let cmText = $(this).parent().prev().val();
	
	if(cmText == ""){	
		alert("댓글 내용을 반드시 입력해주세요.")
		
	} else {
		
		let editConfirm = confirm('댓글을 수정하시겠습니까?');
		
		if(editConfirm) {
			
			let pageNum = $('.comment-count').data('page');
			let cno = $(this).parents('.comment-content-box').data('cno');
			let commentVo = {
				cno: cno,
				comment: cmText
			}
			
			var data = JSON.stringify(commentVo);
		
			$.ajax({
				method: 'PUT',
				url: '/comment/update/'+ pageNum,
				data: data,
				contentType: 'application/json; charset=utf-8'
			}).done(function(result){
				
				if($.type(result) == "string") {				
					alert(result);
				} else {
									
					getCommentList(result);
				}

			})
		}
	}
});

//댓글삭제 이벤트
$(document).on('click', '.comment-delete-btn', function() {
	
	let deleteConfirm = confirm('댓글을 삭제하시겠습니까?');
	if(deleteConfirm) {
	 	let cno = $(this).parents('.comment-content-box').data('cno');
	 	
	 	$.ajax({
			method: 'delete',
			url: '/comment/delete/'+ cno
		}).done(function(result){
			
			if(result != "success") {
				
				alert(result)
			}
			
			getCommentList(1);
		})
	}
});

//댓글 페이지 이동 이벤트
$(document).on('click', '.page-item a', function(){
	
	event.preventDefault();
	
	let pageNum = $(this).attr('href');
	
	getCommentList(pageNum);
});


