//차트
function loanLankingChart() {
	$.ajax({
		method:'GET',
		url:'/adminPage/dashboard/chart '
	}).done(function(result){
		
		let labels1 = [];
		let labels2 = [];
		
		for(let i = 0; i < 5; i++) {
			labels1.push(result.memberLank[i].name);
			labels2.push(result.bookLank[i].title);	
		}
		
		const data1 = {
		  labels: labels1,
		  datasets: [{
		    label: '회원 대출 순위',
		    data: [result.memberLank[0].loanCount, result.memberLank[1].loanCount, result.memberLank[2].loanCount, result.memberLank[3].loanCount, result.memberLank[4].loanCount],
		    backgroundColor: [
		      '#1793bb',
		      '#df7386',
		      '#56d689',
		      '#d6e3f8',
		      '#fff3a7'
		    ],
		    hoverOffset: 5
		  }]
		};
		
		const data2 = {
		  labels: labels2,
		  datasets: [{
		    label: '도서 인기 순위',
		    data: [result.bookLank[0].loanCount, result.bookLank[1].loanCount, result.bookLank[2].loanCount, result.bookLank[3].loanCount, result.bookLank[4].loanCount],
		    backgroundColor: [
		      '#1793bb',
		      '#df7386',
		      '#56d689',
		      '#d6e3f8',
		      '#fff3a7'
		    ],
		    hoverOffset: 5
		  }]
		};
		
		const ctx1 = document.getElementById('loanLanking-chart').getContext('2d');
		const ctx2 = document.getElementById('bookLanking-chart').getContext('2d');
		
		const config1 = new Chart(ctx1, {
		  	type: 'doughnut',
		  	data: data1,
			options: {		
				 plugins: {
					 title: {
				        display: true,
				        text: '회원 대출 순위',
				        fontSize: 12,
				    },	
		             legend: {
					    display: true,
					    position: 'bottom',
					},
					pieceLabel: {
			           mode:"label",
			           position:"outside",
			           fontSize: 11,
			           fontStyle: 'bold'
				    }, 			    			 
		        },                 
				responsive: false,
			} //options
		});
		
		const config2 = new Chart(ctx2, {
		  	type: 'pie',
		  	data: data2,
			options: {		
				 plugins: {
					 title: {
				        display: true,
				        text: '도서 인기 순위',
				        fontSize: 12,
				    },	
		             legend: {
					    display: false,
					    position: 'bottom',
					},
					pieceLabel: {
			           mode:"label",
			           position:"outside",
			           fontSize: 11,
			           fontStyle: 'bold'
				    }, 			    			 
		        },                 
				responsive: false,
			} //options
		});
	}) //done()
} //loanLankingChart()

loanLankingChart();



const NOW_DATE = new Date();
endDate = NOW_DATE.getDate();
var xValues = Array.apply(null, Array(endDate)).map(function (_, i) {return i+1;});

const data2 = {
  labels: xValues,
  datasets: [{
    label: 'My First Dataset',
    data: [65, 59, 80, 81, 56, 55, 40, 90, 70, 55, 60, 30, 
    	   45, 39, 90, 91, 46, 65, 70, 50, 80, 35, 50, 40, 50, 60, 70, 70, 90],
    fill: false,
    borderColor: '#1793bb',
    tension: 0.1
  }]
};

const data3 = {
  labels: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  datasets: [{
    label: '일별 도서대출 현황',
    data: [65, 59, 80, 81, 56, 55, 40, 90, 70, 55, 60, 30],
	backgroundColor: '#1793bb'
  }]
};




const ctx2 = document.getElementById('daily-loanChart').getContext('2d');
const ctx3 = document.getElementById('month-loanChart').getContext('2d');


const config2 = new Chart(ctx2, {
  	type: 'line',
  	data: data2,
	options: {		
		 plugins: {
			 title: {
		        display: true,
		        text: '이번달 도서 대출현황',
		        fontSize: 12,
		    },
		     legend: {
			    display: false,
			},			    			 
        },                 
		responsive: false,
	} //options
});

const config3 = new Chart(ctx3, {
  	type: 'bar',
  	data: data3,
	options: {		
		 plugins: {
			 title: {
		        display: true,
		        text: '월별 도서 대출현황',
		        fontSize: 12,
		    },
		     legend: {
			    display: false,
			},			    			 
        },                
		responsive: false,
	} //options
});



//회원정보
function memberInfo() {
	$.ajax({
		method:"GET",
		url:"/member/getMemberInfo"
	}).done(function(result){
		$('.member-count').text(result.memberInfo.totalCount);
		$('.today-join-count').text(result.memberInfo.todayJointCnt)
		$('.hope-book-count').text(result.hopeBookInfo.hopeBookCnt);
		$('.today-apply-count').text(result.hopeBookInfo.todayApplicationCnt);
		
	})
} //memberInfo()

//대출정보
function loanInfo() {
	$.ajax({
		method:"GET",
		url:"/adminPage/dashboard/loanInfo"
	}).done(function(result){
		
		$('.total-loan-count').text(result.loanInfo.loanCount);
		$('.today-loan-count').text(result.loanInfo.todayLoanCnt);
		$('.overdue-count').text(result.overdueInfo.overdueCnt);
		$('.today-overdue-count').text(result.overdueInfo.todayOverdueCnt);
		$('.loss-count').text(result.lossInfo.lossCount);
		$('.today-loss-count').text(result.lossInfo.todayLossCnt);
		$('.total-latefee').text(result.totalLatefee);
	
	})
} //loanInfo()

function roomInfo() {	
	let location = $('.room-name.active').text().charAt(0);
	
	$.ajax({
		method:"GET",
		url:"/room/dashboard/status?location=" + location
	}).done(function(result){
		$('.item-box').removeClass('using').removeClass('stop');
		
		for(seat of result.seatStatus) {		
			let sno = seat.sno;			
					
			if(seat.status == 0) {
				$('.seat'+ sno +'').addClass('stop');			
			} else if(seat.status == 1){
				$('.seat'+ sno +'').addClass('using');
			}
		} //for()
		
		let seatTotalCnt = $('.active').siblings('.room-seat-count').val();		
		let availableCnt = seatTotalCnt - (result.countInUse + result.countInStop)
		$('.seat-totalCount').text(seatTotalCnt);
		$('.available-count').text(availableCnt);
		$('.use-count').text(result.countInUse);
		$('.stop-count').text(result.countInStop);
	})
} //roomInfo()

//열람실 위치 클릭 이벤트
$('.tab').click(function(){	
	let tabNum = $(this).find('.tab-number').val();
	$('.tab-btn').removeClass('active');
	$('.tab-status').removeClass('active');	
	$(this).find('.tab-btn').addClass('active');
	$('.'+tabNum+'').addClass('active');
	roomInfo();
})

memberInfo();
loanInfo();
roomInfo();

setInterval(memberInfo, 60000);
setInterval(loanInfo, 60000);
setInterval(roomInfo, 60000);

//대출정보