$("#summernote").summernote({
	toolbar: [
	    // [groupName, [list of button]]
	   ['fontname', ['fontname']],
	   ['fontsize', ['fontsize']],
	   ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	   ['color', ['forecolor','color']],
	   ['table', ['table']],
	   ['para', ['ul', 'ol', 'paragraph']],
	   ['height', ['height']],
	   ['insert',['picture','link','video']],
	   ['view', ['fullscreen', 'help']]
	],
	fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
	fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],	
	height: 250,
	minHeight: null,
	maxHeight: null,
	focus: true, 
	lang: "ko-KR",
	disableResizeEditor: true,
	callbacks: { //이미지 첨부부분
		onImageUpload : function(files) {
			uploadSummernoteImageFile(files[0],this);
		},
		onPaste: function (e) {
			var clipboardData = e.originalEvent.clipboardData;
			if (clipboardData && clipboardData.items && clipboardData.items.length) {
				var item = clipboardData.items[0];
				if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
					e.preventDefault();
				}
			}
		}
	}	
})

// 써머노트 이미지 파일 업로드
function uploadSummernoteImageFile(file, editor) {
	
	data = new FormData();
	data.append("file", file);
	
	$.ajax({
		method : "POST",
		url : "/community/summernote",
		data : data,
		contentType : false,
		processData : false,
		success : function(data) {
        	//항상 업로드된 파일의 url이 있어야 한다.
		   $(editor).summernote('insertImage', data.url);
		}
	});
}

//파일 첨부
var fileCount = 1;
fileCount += $('.old-file-box').length;
console.log($('.old-file-box').length);

var fileTag = ` <div class="d-flex file-input-box">
                    <input id="file-input" class="file-input" type="file" name="filename"> 
                    <i class="fa-solid fa-xmark file-delete-btn"></i>
                </div>`;

$('.file-add-btn').click(function() {
	console.log(fileCount);
	
	if (fileCount < 5) {
		$(this).parent().append(fileTag);
		fileCount++;
	} else {
		alert('파일첨부는 최대 5개 까지 가능합니다.')
	}
})

$(document).on('click', '.file-delete-btn', function() {
	$(this).parent().remove();
	fileCount--;
})
    
//저장버튼 이벤트
$('.save-btn').click(function(){

	let subject = $('#subject-input').val();
	
	if(subject == ""){
		
		alert("제목은 필수 입력값입니다. 반드시 입력해 주세요.");	
	} else {
		
		let writeConfirm = confirm('게시물을 등록하시겠습니까?'); 
    	
    	if(writeConfirm){ 
    		$('.notice-write-wrap').submit();
		}
	}
})	

//공지작성 창 닫기
$('.close-btn').click(function() {
	opener.parent.location.reload();
	window.close();
})
