//수정화면 토글 이벤트	
$('.toggle-edit-btn').click(function(){
	$(this).parents('.content-top').siblings('.comment-edit-wrap').toggle();
})

//수정화면 닫기 버튼 이벤트	
$('.edit-close').click(function(){
	$(this).parents('.comment-edit-wrap').hide();
})

//대댓글화면 토글 이벤트	
$('.nested-comment-btn').click(function(){
	$(this).parents('.content-top').siblings('.comment-comment-wrap').toggle();
})

//대댓글 화면 닫기 이벤트
$('.register-close').click(function(){
	$(this).parents('.comment-comment-wrap').hide();
})

//댓글등록 이벤트
$('.regist-btn').click(function(){
	let cmText = $(this).siblings('.comment-input').val(); //cmText == commentText
	
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
				location.reload();
			})
		}
	}	
});

//대댓글등록 이벤트
$(document).on('click', '.cm-register-btn', function(){
	
	let cmText = $(this).siblings('.nested-comment-input').val(); //cmText == commentText
	
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
				location.href="/adminPage/board/comment?pageNum=" + result + "&bno=" + bno
			})
		}
	}
})

//댓글수정 이벤트
$('.comment-edit-btn').click(function(){
	
	let cmText = $(this).siblings('.edit-comment-input').val();
	
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
					location.href="/adminPage/board/comment?pageNum=" + result + "&bno=" + bno
				}

			})
		}
	}
});

//댓글삭제 이벤트
$('.comment-delete-btn').click(function(){
	
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
			location.reload();
		})
	}
});

//창 닫기
$('.close-btn').click(function() {
	opener.parent.location.reload();
	window.close();
})