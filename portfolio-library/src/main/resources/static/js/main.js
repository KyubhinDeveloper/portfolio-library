//메뉴 도서검색 이벤트
$('#btn-search').click(function(){
	let search = $('#menu-book-search').val();	
	location.href = "/bookCollection/searchBook?search="+ search; 
})

// 엔터로 메뉴 도서검색
$('#menu-book-search').keydown(function(e) {
    if (e.keyCode == 13) {
        let search = $('#menu-book-search').val();
		location.href = "/bookCollection/searchBook?search="+ search;
    }
});


// community-icon 애니메이션
$('.community-icon-box').mouseover(function () {
    $('.community-hover-box').css('opacity', 1).css('visibility', 'visible');
}).mouseout(function(){
    $('.community-hover-box').css('opacity', 0).css('visibility', 'hidden');
})


$('.my-icon-box').mouseover(function(){
    $('.my-hover-box').css('opacity', 1).css('visibility', 'visible');
}).mouseout(function(){
    $('.my-hover-box').css('opacity', 0).css('visibility', 'hidden');
})

$('.admin-icon-box').mouseover(function(){
    $('.admin-hover-box').css('opacity', 1).css('visibility', 'visible');
}).mouseout(function(){
    $('.admin-hover-box').css('opacity', 0).css('visibility', 'hidden');
})

// 메뉴클릭 active onoff
$('.menu-item').click(function(){
    
    if($(this).hasClass('active')){
		$(this).removeClass('active');		
	} else {
	    $('.menu-container').find('.active').removeClass('active');
	    $(this).addClass('active');	
	}
})

// sns-icon hover 이벤트
$('.insta').hover(function(){
    $('.insta').attr('src','/img/main/footer-sns-insta-hover.png');
} , function () {
    $('.insta').attr('src','/img/main/footer-sns-insta.png');
});

$('.youtube').hover(function(){
    $('.youtube').attr('src','/img/main/footer-sns-youtube-hover.png');
} , function () {
    $('.youtube').attr('src','/img/main/footer-sns-youtube.png');
});

$('.facebook').hover(function(){
    $('.facebook').attr('src','/img/main/footer-sns-facebook-hover.png');
} , function () {
    $('.facebook').attr('src','/img/main/footer-sns-facebook.png');
});

$('.bookTalk').hover(function(){
    $('.bookTalk').attr('src','/img/main/footer-sns-blog-hover.png');
} , function () {
    $('.bookTalk').attr('src','/img/main/footer-sns-blog.png');
});

//창 맨위로 바로 올라가는 이벤트
$(window).scroll(function(){
    if($(window).scrollTop() > 0) {
        $('.move-top-icon').fadeIn();
    } else {
        $('.move-top-icon').fadeOut();
    }
})

$('.move-top-icon').click(function(){
    $(window).scrollTop(0);
})

//사이드 메뉴 이벤트
$('.hamberger-box').click(function(){
    $('.side-menu-bg').addClass('menu-show');
    setTimeout(()=>{
		$('body').css('overflow', 'hidden')
	},300);
})

$(document).on('click','.btn-close-side', function(){	
	  
    $('.side-menu-bg').removeClass('menu-show');
    $('body').css('overflow', 'auto');
})

//사이드 메뉴 탭 클릭 이벤트
$('.tab-title2').click(function(){
    $('.tab-title2').removeClass('tab-click');
    $(this).addClass('tab-click');

})

$('.tab-title2').click(function(){
    var idName = $(this).attr('id');
    $('.tab-contents2').hide();
    $(`ul#${idName}`).show();
})

// 화면크기에 따른 메뉴 dropdown 이벤트
$(window).resize(function(){
    if($('.side-menu').css('display') == 'block'){
        $('.tab-title2').removeClass('tab-click');
        $('.tab-contents2').hide();
    }
    
    let widthSize = $(window).outerWidth();
    
    if(widthSize < 992) {
		$('.menu-item-box .menu-item').attr('data-bs-toggle', '');
	} else {
		$('.menu-item-box .menu-item').attr('data-bs-toggle', 'dropdown');
	}
}) 

//첫 화면 크기에 따른 dropdown 이벤트
function sizeEvent() {
	if($(window).outerWidth() < 992) {
		$('.menu-item-box .menu-item').attr('data-bs-toggle', '');
	}	
} //sizeEvent()

sizeEvent();

//관리자 페이지 이벤트

$('.menu-admin').click(function(){
	
	location.href = "/adminPage/dashboard";
})


