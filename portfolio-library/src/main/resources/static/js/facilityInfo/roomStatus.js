//열람실 현황 함수
function getRoomStatus(){
	
	$.ajax({
		method: 'GET',
		url: '/room/status'
	}).done(function(result){
		
		let room2 = result.room2;
		let room3 = result.room3;

		
		if(room2 > 0) {
			
			let seatCount = $('#room2-status .total-seat').text() - room2;
			let seatPercent = Math.round(room2*100/$('#room2-status .total-seat').text());
			
			$('#room2-status .remaining-seat').text(seatCount);
			$('.room2-bar').css('width', seatPercent + '%');
			
			if(70 > seatPercent > 35) {
				$('.room2-bar').css('background', '-webkit-linear-gradient(top, rgba(250,165,26,1) 10%,rgba(244,122,32,1) 90%)');
				$('.room2-bar').css('border', '1px solid rgb(244, 122, 32)');
			} else if(seatPercent > 70) {
				$('.room2-bar').css('background', '-webkit-linear-gradient(top, rgba(221,95,95,1) 10%,rgba(169,44,44,1) 90%)');	
				$('.room2-bar').css('border', '1px solid rgba(169,44,44,1)');
			}
			
			$('.room2-bar .bar-percent').text(seatPercent + '%');
			$('.room2-bar').attr('aria-valuenow', seatPercent );
		}
		
		if(room3 > 0) {
			
			let seatCount = $('#room3-status .total-seat').text() - room3;
			let seatPercent = Math.round(room3*100/$('#room3-status .total-seat').text());
			
			$('#room3-status .remaining-seat').text(seatCount);
			$('.room3-bar').css('width', seatPercent + '%');
			
			if(70 > seatPercent > 35) {
				$('.room3-bar').css('background', '-webkit-linear-gradient(top, rgba(250,165,26,1) 10%,rgba(244,122,32,1) 90%)');
				$('.room3-bar').css('border', '1px solid rgb(244, 122, 32)');
			} else if(seatPercent > 70) {
				$('.room3-bar').css('background', '-webkit-linear-gradient(top, rgba(221,95,95,1) 10%,rgba(169,44,44,1) 90%)');	
				$('.room3-bar').css('border', '1px solid rgba(169,44,44,1)');
			}
			
			$('.room3-bar .bar-percent').text(seatPercent + '%');
			$('.room3-bar').attr('aria-valuenow', seatPercent );
		}
	})
} //getRoomStatus()

getRoomStatus();

//나의 좌석현황
function mySeatDetail() {
	
	$.ajax({
		method:'GET',
		url: '/room/mySeatDetail'
	}).done(function(result){
		
		if(result != "") {
			
			//예약좌석 시간
			let reserveTime = result.reserveTime.substring(0,16).split(' ');
			
			let date = new Date();
			let offset = date.getTimezoneOffset() * 60000; //toISOString() 변환시간과 한국시간이 9시간 차이 나서 9시간 더해줘야한다.
			let dateOffset = new Date(date.getTime() - offset);
			let nowTime = String(dateOffset.toISOString()).replace('T',' ').split(' ');
			let startTime1 = nowTime[0].split('-');
			let startTime2 = nowTime[1].split(':');
			let time1 = new Date(startTime1[0], startTime1[1]-1, startTime1[2], startTime2[0], startTime2[1]);
			
			let endTime = result.endTime.split(' ');
			let endTime1 = endTime[0].split('-');
			let endTime2 = endTime[1].split(':');
			let time2 = new Date(endTime1[0], endTime1[1]-1, endTime1[2], endTime2[0], endTime2[1]);
			
			let timeGap =  time2.getTime() - time1.getTime(); 
			let oneHour = 1000 * 60 * 60;
			let oneMinute = 1000 * 60;
			
			let hour = Math.floor(timeGap / oneHour); //남은 시간
			let minute = Math.floor(timeGap / oneMinute) - (hour * 60); //남은 분
			
			if(result.location == 2) {
				
				let location = `<input type="hidden" class="room-name-val" value="2"><span>2층 제 1열람실<span>`;
				$('.my-reservation-box .room-name').html(location)
			} else if(result.location == 3) {
				
				let location = `<input type="hidden" class="room-name-val" value="3"><span>3층 제 2열람실<span>`;
				$('.my-reservation-box .room-name').html(location);
			}
			
			let reservationTime = `<span>`+ reserveTime[1] +`</span> - <span>`+ endTime[1] +`</span>`;
			let remainTime = `<span>`+ hour +` 시간 `+ minute +` 분 남음</span>`;
			
			$('.my-reservation-box .seat-num').text(result.sno);
			$('.my-reservation-box .seat-status').text('사용중');
			$('.my-reservation-box .reservation-time').html(reservationTime);
			$('.my-reservation-box .remain-time').html(remainTime);
			$('.my-reservation-box .seat-service').html('<button class="btn finish-btn">이용종료</button>')
		} //if()
	}) //done()
} //mySeatStatus()

mySeatDetail();

//좌석별 현황 함수
function getSeatStatus(location){
	
	console.log("실행");
	
	$.ajax({
		method: 'GET',
		url: '/room/seatStatus/' + location
	}).done(function(result){
		
		$('.cover-box').removeClass('update');
		
		for(seat of result) {
			
			let sno = seat.sno;
			let num = seat.location;
			let coverBox = $('#room'+num+'-detail').find('.seat'+sno+'');
		
			if(seat.status == 1) {
				
				let date = new Date();
				let offset = date.getTimezoneOffset() * 60000; //toISOString() 변환시간과 한국시간이 9시간 차이 나서 9시간 더해줘야한다.
				let dateOffset = new Date(date.getTime() - offset);
				let nowTime = String(dateOffset.toISOString()).replace('T',' ').split(' ');
				let startTime1 = nowTime[0].split('-');
				let startTime2 = nowTime[1].split(':');
				let time1 = new Date(startTime1[0], startTime1[1]-1, startTime1[2], startTime2[0], startTime2[1]);
				
				let endTime = seat.endTime.split(' ');
				let endTime1 = endTime[0].split('-');
				let endTime2 = endTime[1].split(':');
				let time2 = new Date(endTime1[0], endTime1[1]-1, endTime1[2], endTime2[0], endTime2[1]);
				
				//3시간 차이  timeGap * 100 / 10740000 
				let timeGap =  time2.getTime() - time1.getTime();
				let remainTime = Math.floor(timeGap * 100 / 10740000)
				
				coverBox.addClass('using').addClass('update');
				coverBox.css('width', remainTime + '%');
					
			} else if(seat.status == 0) {
				
				coverBox.addClass('stop').addClass('update');
				coverBox.attr('data-bs-toggle','');
				coverBox.attr('data-bs-target','');
				
			} 
			
			$('.using').parent().css("border","1px solid #92148d");
			$('.stop').parent().css("border","1px solid #762331");
		}
		
		// 사용중지 해제 후 자리복구
		for(i = 0; i < $('#room'+location+'-detail').find('.stop').length; i++) {
			
			if(!$('.stop').eq(i).hasClass('update')) {
				$('.stop').eq(i).parent().css('border', '1px solid #0033CC');
				$('.stop').eq(i).removeClass('stop');
			}
		}
		
		// 자리배정 종료 후 자리복구
		for(i = 0; i < $('#room'+location+'-detail').length; i++) {
			
			if(!$('.using').eq(i).hasClass('update')) {
				$('.using').eq(i).parent().css('border', '1px solid #0033CC');
				$('.using').eq(i).css('width', '27px').removeClass('using');
			} 
		} 
	})
} //getSeatStatus()


//선택한 좌석 정보 함수
function getSeatDetail(location, sno){
	
	$.ajax({
		method: 'GET',
		url: '/room/seatDetail/'+location+ '/'+ sno
	}).done(function(seatDetail){
		
		let room = $('#room'+ location + '-status').children('.room-name').text();
		let sno = seatDetail.sno;
		let reserver = seatDetail.id;
		
		//예약좌석 시간
		let reserveTime = seatDetail.reserveTime.substring(0,16).split(' ');

		let date = new Date();
		let offset = date.getTimezoneOffset() * 60000; //toISOString() 변환시간과 한국시간이 9시간 차이 나서 9시간 더해줘야한다.
		let dateOffset = new Date(date.getTime() - offset);
		let nowTime = String(dateOffset.toISOString()).replace('T',' ').split(' ');
		let startTime1 = nowTime[0].split('-');
		let startTime2 = nowTime[1].split(':');
		let time1 = new Date(startTime1[0], startTime1[1]-1, startTime1[2], startTime2[0], startTime2[1]);
		
		let endTime = seatDetail.endTime.split(' ');
		let endTime1 = endTime[0].split('-');
		let endTime2 = endTime[1].split(':');
		let time2 = new Date(endTime1[0], endTime1[1]-1, endTime1[2], endTime2[0], endTime2[1]);
		
		let timeGap =  time2.getTime() - time1.getTime(); 
		let oneHour = 1000 * 60 * 60
		let oneMinute = 1000 * 60;
		
		let hour = Math.floor(timeGap / oneHour); //남은 시간
		let minute = Math.floor(timeGap / oneMinute) - (hour * 60); //남은 분
		
		$('.body-text-box').html("");
		
		str = "";
		str += `<h5>`+room+`</h5>
				<p>좌석번호 : <span class="sno">`+sno+`</span></p>
				<h4>사용중 <span>`+ reserveTime[1] +`</span> - <span>`+ endTime[1] +`</span></h4>
				<h4>( <span>`+ hour +` 시간 `+ minute +` 분 남음</span> )</h4>`;
				
		if(sno < 10) {
			$('.roomMark-num').css('right', '32px');
		} else if(sno < 100 ) {
			$('.roomMark-num').css('right', '28px');
		} else {
			$('.roomMark-num').css('right', '24px');
		}
		
		$('.body-text-box').html(str);
		$('.roomMark-num').html(sno);
		$('.assign-btn').hide();
		if(reserver == id || id == "admin") {
			$('.finish-btn').show();
			
		} 		
	})
} //getSeatDetail()


//열람실 상세 정보 이벤트
$('.detail-btn').click(function() {
	
	let location = $(this).prev().val();
					
	$('.tab').removeClass('active');
	$('.seat-status-bg').hide();
	
	for (let i = 0; i < $('.tab').length; i++) {
		let tab = $('.tab').eq(i);
		let status = $('.seat-status-bg').eq(i);
		let tabName = status.children('.seat-status-title').children('input').val()

		if (tab.children('input').val() == location) {
			tab.addClass('active');
		}

		if (tabName == location) {
			status.show();
		}
	}
	
	for(i = 0; i < $('.item-box').length; i++) {
		
		let num = $('.item-box').eq(i).children('.cover-box').text()	
		$('.item-box').eq(i).children('.cover-box').addClass('seat' + num);
	}
	
	getSeatStatus(location);
	
	setInterval(function(){
	
		getSeatStatus(location);
	
	}, 5000);
	
	$('.item-box').attr('data-bs-toggle','modal');
	$('.item-box').attr('data-bs-target','#roomModal');
		

	$('.seat-reservation-wrap').show();
}); 
     
// 열람실 탭 이벤트
 $('.tab').click(function(){
	
    let location = $(this).children('input').val()
    
    $('.tab').removeClass('active');
    $(this).addClass('active');
    $('.seat-status-bg').hide();

    for(let i = 0; i < $('.tab').length; i++) {
        let status= $('.seat-status-bg').eq(i);
        let tabName = status.children('.seat-status-title').children('input').val();
        if(tabName == location) {
            status.show();
        }
    }
    
    getSeatStatus(location);
})

// 비로그인시 toggle 효과 삭제
$('.item-box').hover(function(){
	
	let now = new Date(); 
	let open = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 06, 00, 00) //배정가능 시간 아침 6시
	
	if(id == "") {
		$(this).attr('data-bs-toggle','');
		$(this).attr('data-bs-target','');
	} else if(now.getTime() < open.getTime() && id != "admin") {
		$(this).attr('data-bs-toggle','');
		$(this).attr('data-bs-target','');
	}
})

$('.cover-box').hover(function(){ 
	
	if($(this).hasClass('stop')) {
		$(this).parent().attr('data-bs-toggle','');
		$(this).parent().attr('data-bs-target','');
	}
})


//좌석 상태창 이벤트
$('.item-box').click(function(){
	
	//이용가능시간과 현재시간 비교
	let now = new Date(); 
	let open = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 06, 00, 00)
	
	if(id == "") {
    	
    	alert("세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.");
    	location.href = "/member/login";
		
	} else if(now.getTime() < open.getTime() && id != "admin") {
		
		alert("지금은 이용가능 시간이 아닙니다.");
		
	} else {
		
		let sno = $(this).children('.cover-box').text();
		
		if($(this).children('.cover-box').hasClass('using')) {
			
			let location = $('.active').children('input').val();
			
			getSeatDetail(location,sno);
			
		} else if($(this).children('.cover-box').hasClass('stop')){
	
			if(id == "admin") {
				
				let restoreConfirm = confirm('지정한 좌석을 사용 가능하도록 하시겠습니까?');
				
				if(restoreConfirm) {
					$.ajax({
						method: 'DELETE',
						url: '/room/finish/' + sno 
					}).done(function(){
						location.reload();				
					})	
				}
			} else {
				alert('배정 불가능한 좌석입니다.');	
			}
			
		} else {
			
			let location = $('.active').children('input').val();
			let room = $('#room'+ location + '-status').children('.room-name').text();
			
			//좌석 예약 후 사용시간
			let offset = now.getTime() + (1000 * 60 * 60 * 9);//toISOString()로 변환시 한국시간과 9시간 차이나서 9시간 더해줌.
			let offset2 = now.getTime() + (1000 * 60 * 60 * 3) //예약종료 시간은 예약시간 + 3시간(초)
			let dateOffset = new Date(offset);
			let dateOffset2 = new Date(offset + (1000 * 60 * 60 * 3)); 
			let reserveTime = String(dateOffset.toISOString()).replace('T',' ').substring(0, 16);
			let endTime = String(dateOffset2.toISOString()).replace('T',' ').substring(0, 16);
			let start = reserveTime.split(' ')[1];
			let end = endTime.split(' ')[1];

		 	let fixedTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 23 , 59, 59 ).getTime(); //11시 59분 59 배정종료 고정시간;
		 	let closeTime = new Date(fixedTime + (1000 * 60 * 60 * 9)).toISOString().replace('T',' ').substring(0, 16);
		 	let close = closeTime.split(' ')[1];
		 	
			$('.body-text-box').html("");
			
			str = "";
			str += `<h5>`+room+`</h5>
					<p>좌석번호 : <span class="sno">`+sno+`</span></p>
					<h4>
						<input class="reserveTime" type="hidden" value="`+reserveTime+`"/>`;
			if(offset2 > fixedTime) {
			
				str +=	`<input class="endTime" type="hidden" value="`+closeTime+`"/>
						배정 가능 ( <span>`+ start +`</span> - <span>`+ close +`</span> )
					</h4> `;
				
			} else {
				
				str += `<input class="endTime" type="hidden" value="`+endTime+`"/>
						배정 가능 ( <span>`+ start +`</span> - <span>`+ end +`</span> )
					</h4>`;
			}		
						
			
			// 북마크 이미지의 좌석번호 위치조정 css
			if(sno < 10) {
				$('.roomMark-num').css('right', '30px');
			} else if(10 < sno < 100 ) {
				$('.roomMark-num').css('right', '24px');
			} else {
				$('.roomMark-num').css('right', '18px');
			}
		
			$('.body-text-box').html(str);
			$('.roomMark-num').html(sno);
			
			$('.assign-btn').show();
			$('.finish-btn').hide();
			if(id == "admin"){
				$('.stop-btn').show();
			}
	   }

	}
})

//좌석배정 이벤트
$('.assign-btn').click(function(){
		
	if(id == "") {
	
		alert("세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.");
		location.href = "/member/login";
	
	} else {
		
		let assignmentConfirm = confirm('선택하신 좌석으로 배정하시겠습니까?');
	
		if(assignmentConfirm) {
		
			let room = $('.active').children('input').val();
			let sno = $(this).parent().siblings('.body-wrap').find('.sno').text();
			let reserveTime = $(this).parent().siblings('.body-wrap').find('.reserveTime').val();
			let endTime = $(this).parent().siblings('.body-wrap').find('.endTime').val();
		
			let seatVo = {
				
				sno: sno,
				id: id,
				location: room,
				reserveTime: reserveTime,
				endTime: endTime,
				status: 1
			}
			
			var data = JSON.stringify(seatVo);
			
			$.ajax({
				method: "POST",
				url: "/room/assignSeat",
				data: data,
				contentType: 'application/json; charset=utf-8'
			}).done(function(result){
				
				alert(result);
				location.reload();
			})
		}
	}
})

//좌석 이용종료 이벤트
$('.finish-btn').click(function(){
	
	if(id == "") {
	
		alert("세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.");
		location.href = "/member/login";
	
	} else {
		
		let finishConfirm = confirm('아직 이용 가능 시간이 남아있습니다. 정말 배정된 좌석의 이용을 종료하시겠습니까?');
		
		if(finishConfirm) {
			
			let sno = $(this).parent().siblings('.body-wrap').find('.sno').text();
			let room = $('.active').children('input').val();
			
			$.ajax({
				method: "DELETE",
				url: "/room/finish/"+sno+'/'+room,
			}).done(function(){
				
				alert("이용이 종료되었습니다. 사용하신 자리의 뒷처리 꼭 부탁드립니다.")
				location.reload();
			})
			
		}
	} //else()
})

//나의 자리에서 이용종료 이벤트
$(document).on('click','.my-reservation-box .finish-btn', function(){
	
	if(id == "") {
	
		alert("세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.");
		location.href = "/member/login";
	
	} else {
		
		let finishConfirm = confirm('아직 이용 가능 시간이 남아있습니다. 정말 배정된 좌석의 이용을 종료하시겠습니까?');
		
		if(finishConfirm) {
			
			let sno = $('.my-reservation-box .seat-num').text();
			let room = $('.room-name-val').val();
			
			$.ajax({
				method: "DELETE",
				url: "/room/finish/"+sno+'/'+room,
			}).done(function(){
				
				alert("이용이 종료되었습니다. 사용하신 자리의 뒷처리 꼭 부탁드립니다.")
				location.reload();
			})
			
		}
	} //else()
	
})

//좌석 사용중지 이벤트
$('.stop-btn').click(function(){
	
	let stopConfirm = confirm('지정한 좌석을 사용 불가능하도록 하시겠습니까?');
	
	if(stopConfirm) {
		
		let room = $('.active').children('input').val();
		let sno = $(this).parent().siblings('.body-wrap').find('.sno').text();
		
		let seatVo = {	
			sno: sno,
			location: room,
			status: 0
		}
			
		var data = JSON.stringify(seatVo);
		
		$.ajax({
			method: "POST",
			url: "/room/stop",
			data: data,
			contentType: 'application/json; charset=utf-8'
		}).done(function(){		
			getSeatStatus(room);
		})
	}
})