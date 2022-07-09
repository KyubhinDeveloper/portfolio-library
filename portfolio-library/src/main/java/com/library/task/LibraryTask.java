package com.library.task;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.library.service.AdminService;
import com.library.service.BookCollectionService;
import com.library.service.MemberService;
import com.library.service.RoomStatusService;
import com.library.vo.LoanBookVo;
import com.library.vo.SeatVo;

import lombok.extern.java.Log;

@Log
@Component
public class LibraryTask {
	
	@Autowired
	RoomStatusService roomStatusService;
	
	@Autowired
	BookCollectionService bookCollectionService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Scheduled(cron = "0 0/1 * * * *")
	public void seatUpdate() throws ParseException {
		
		List<SeatVo> seatVo = roomStatusService.getSeatList(1);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		LocalDateTime dateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String currentTime = dateTime.format(formatter);
		Date current = dateFormat.parse(currentTime);
		
		for(SeatVo seat : seatVo ) {
			
			String endTime = seat.getEndTime();
			Date end = dateFormat.parse(endTime);
			
			if(end.getTime() <= current.getTime()) {
				
				int sno = seat.getSno();
				String location = seat.getLocation();
				
				roomStatusService.finish(sno,location);
				log.info("삭제완료");
			}
		} //for()
		
		log.info("좌석체크");
	} //seatUpdate()
	
	//연체체크
	@Scheduled(cron = "0 0 0 * * *")
	public void overdueCheck() throws ParseException {
		
		//대출중인 도서 목록 가져오기
		List<LoanBookVo> loanBookList = adminService.getLoanList();
		
		for(LoanBookVo loanBookVo : loanBookList ) {		
			 Date now = new Date();
			 String endDate = loanBookVo.getEndDate().replace(".", "");
			 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			 Date returnTime = dateFormat.parse(endDate);
			 
			 if(now.getTime() > returnTime.getTime()) {
				 int num = loanBookVo.getNum();
				 String id = loanBookVo.getId();
				 //미반납도서 연체처리			 
				 adminService.updateOverdue(num);
				//미반납도서 공지알림 
				 adminService.sendingNotice2(loanBookVo);
			 } //if()
		} //for()
		log.info("연체체크");
	} //overdueCheck()
	
	//대출대기중 2틀후 삭제
	@Scheduled(cron = "0 0 0 * * *")
	public void loanStatusCheck() throws ParseException { 
		
		//대출중인 도서 목록 가져오기
		List<LoanBookVo> loanBookList = adminService.getLoanList();
		
		for(LoanBookVo loanBookVo : loanBookList ) {
		
			String status = loanBookVo.getStatus();
				
			if(status.equals("대기중")) {
				
				 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
				 Date now = new Date();
				 String loanDate = loanBookVo.getLoanDate().replace(".", "");
				 String strNow = dateFormat.format(now);
				 Date loanTime = dateFormat.parse( loanDate);
				 Date nowTime =  dateFormat.parse(strNow);
				
				 if((nowTime.getTime() - loanTime.getTime()) >= (1000*60*60*24*2)) {
					 
					 String bookNum = loanBookVo.getBookNum();
					 int num = loanBookVo.getNum();
					 int reserverCnt = bookCollectionService.getReservationCount(bookNum); //cnt == count
					 
					 if(reserverCnt > 0) {
						 if(reserverCnt >= 1) {
							 
							//도서대출취소
							bookCollectionService.returnBook(num);
							 
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
							String reserverId = bookCollectionService.getReserver(bookNum, 1);
							String name = memberService.getNameById(reserverId);
							LocalDateTime now2 = LocalDateTime.now();
							LocalDateTime end =  now2.plusDays(14);
							loanDate = now2.format(formatter);
							String endDate = end.format(formatter);
							int newNum = bookCollectionService.getLoanNum();
							 
							loanBookVo.setNum(newNum);
							loanBookVo.setId(reserverId);
							loanBookVo.setName(name);
							loanBookVo.setLoanDate(loanDate);
							loanBookVo.setEndDate(endDate);
							 
							bookCollectionService.loanBook(loanBookVo);
							//1번 예약자 삭제 
							bookCollectionService.cancelReservationByTurn(bookNum, 1);
							//예약도서 대출가능 알림발송
							adminService.sendingNotice(loanBookVo,5); 
							
							if(reserverCnt > 1) {			
								bookCollectionService.updateReservation(bookNum);
							}
						 }
					 } else {
						//도서대출취소
					 	 bookCollectionService.returnBook(num);
					 } //else 
				 } //if()
			} //if()	
		}//for()
		log.info("대기중 체크");		
	} //loanStatusCheck()
	
	//반납일 체크
	@Scheduled(cron = "0 0 0 * * *")
	public void returnDateCheck() throws ParseException {
		
		//대출중인 도서 목록 가져오기
		List<LoanBookVo> loanBookList = adminService.getLoanList();
		
		for(LoanBookVo loanBookVo : loanBookList ) {
			
			 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			 Date now = new Date();
			 String endDate = loanBookVo.getEndDate().replace(".", "");
			 String strNow = dateFormat.format(now);
			 
			 Date returnTime = dateFormat.parse(endDate);
			 Date nowTime =  dateFormat.parse(strNow);
			 
			 if((returnTime.getTime() - nowTime.getTime()) == (1000*60*60*24*3)) {
				 //반납예정알림 공지보내기
				 adminService.sendingNotice(loanBookVo, 3);
			 } //if()
		} //for()	
		log.info("반납일 체크");
	} //returnDateCheck()
}



