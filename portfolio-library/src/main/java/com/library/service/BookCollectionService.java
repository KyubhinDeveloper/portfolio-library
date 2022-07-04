package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.BookCollectionMapper;
import com.library.vo.BookDto;
import com.library.vo.BookmarkVo;
import com.library.vo.LoanBookVo;
import com.library.vo.ReserveBookVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class BookCollectionService {

	@Autowired
	BookCollectionMapper bookCollectionMapper;

	public List<LoanBookVo> getLoanStatus(String isbn) {

		List<LoanBookVo> loanList = bookCollectionMapper.getLoanStatus(isbn);
		return loanList;
	} // getLoanStatus()

	public List<ReserveBookVo> getReserveStatus(String isbn) {

		List<ReserveBookVo> ReserveStatus = bookCollectionMapper.getReserveStatus(isbn);
		return ReserveStatus;
	} // getReserveStatus()
	
	public List<LoanBookVo> getLoanBookList(int rowCount, int startRow, String category, String search, String status){
		
		List<LoanBookVo> loanBookList = bookCollectionMapper.getLoanBookList(rowCount, startRow, category, search, status);		
		return loanBookList;
	} //getLoanBookList()
	
	public List<LoanBookVo> getRecentLoanList() {
		List<LoanBookVo> loanList = bookCollectionMapper.getRecentLoanList();
		return loanList;
	} //getLoanList()
	
	public List<ReserveBookVo> getReservationList(int rowCount, int startRow, String category, String search){
		
		 List<ReserveBookVo> reservationList = bookCollectionMapper.getReservationList(rowCount, startRow, category, search);		 
		 return reservationList;
	} //getReservationList() 
	
	public List<BookDto> getPopularBookList(int listCount) {
		
		List<BookDto> popularBookList = bookCollectionMapper.getPopularBookList(listCount);
		return popularBookList;
	} //getPopularBookList()

	public int getLoanNum() {

		Integer num = bookCollectionMapper.getLoanNum();
		
		if (num == null) {
			num = 1;
		}

		return num;
	} //getLoanNum()
	
	public int getLoanNumFromRecord() {
		
		Integer num = bookCollectionMapper.getLoanNumFromRecord();
		
		if (num == null) {
			num = 1;
		}

		return num;
	} //getrecordLoanNum()

	public int getReserveNum() {

		Integer num = bookCollectionMapper.getReserveNum();

		if (num == null) {
			num = 1;
		}

		return num;
	} // getReserveNum()
	
	public int getStopNum() {
		
		Integer num = bookCollectionMapper.getStopNum();
		
		if (num == null) {
			num = 1;
		}
		
		return num;
	} //getStopNum()
	
	public int getBookmarkNum() {
		
		Integer num = bookCollectionMapper.getBookmarkNum();
		
		if (num == null) {
			num = 1;
		}
		
		return num;
	} //getBookmarkNum()
	
	public int getNewTurn(String bookNum) {
 
		Integer turn = bookCollectionMapper.getReservationCount(bookNum);

		if (turn == null) {
			turn = 1;
		} else {
			turn += 1;
		}
		
		return turn;
	} // getOrder()
	
	public int getReservationTurn(String reserverId, String bookNum) {
		
		int turn = bookCollectionMapper.getReservationTurn(reserverId, bookNum);
		return turn;
	} //getReservationTurn()
		
	public String getReserver(String bookNum, int turn) {
		
		String id = bookCollectionMapper.getReserver(bookNum,turn);
		
		return id;
	} //getReserver()
	
	public int getReservationCount(String bookNum) {		
		int count = bookCollectionMapper.getReservationCount(bookNum);
		return count;
	} //getReservationCount()
	
	public int getReservationCnt() {
		int count = bookCollectionMapper.getReservationCnt();
		return count;
	} //getReserveCnt()
	
	public int getRsSearchCnt(String category, String search) {
		int searchCount = bookCollectionMapper.getRsSearchCnt(category, search);
		return searchCount;
	} //getRsSearchCnt()
	
	public int getLoanCount(){	
		int totalCount = bookCollectionMapper.getLoanCount();		
		return totalCount;
	} //getLoanCount()
	
	public int getTodayLoanCnt(String today) {
		int todayLoanCnt = bookCollectionMapper.getTodayLoanCnt(today);
		return todayLoanCnt;
	} // getTodayLoanCnt()
	
	public int getLoanSearchCnt(String category, String search, String status){
		
		int searchCount = bookCollectionMapper.getLoanSearchCnt(category, search, status);
		return searchCount;
	}
	
	public String getIdByNum(int num) {
		
		String id = bookCollectionMapper.getIdByNum(num);
		return id;
	} //getIdByNum()
	
	public String getBookNumByNum(int num) {
		
		String bookNum = bookCollectionMapper.getBookNumByNum(num);
		return bookNum;
	} //getBookNumByNum()
	
	public String getIsbnByBookNum(String bookNum) {
		
		String isbn = bookCollectionMapper.getIsbnByBookNum(bookNum);
		
		return isbn;
	} //getIsbnByBookNum()
	
	public LoanBookVo getLoanBook(int num) {
		
		LoanBookVo loanBookVo = bookCollectionMapper.getLoanBook(num);
		
		return loanBookVo;
	} //getLoanBook()
	
	public LoanBookVo getLoanBookByBookNum(String bookNum) {
		
		LoanBookVo loanBookVo = bookCollectionMapper.getLoanBookByBookNum(bookNum);
		
		return loanBookVo;
	} //getLoanBook()
		
	public boolean rvDuplication(String isbn, String id) {
		
		int count = bookCollectionMapper.rvDuplication(isbn, id);
		boolean status = false;
		
		if(count > 0) {
			status = true;
		}
	
		return status;
	} //rvDuplication()
	
	public boolean loanDuplication(String isbn, String id) {
		
		int count = bookCollectionMapper.loanDuplication(isbn,id);
		boolean status = false;
		
		if(count > 0) {
			status = true;
		}
	
		return status;
	} //loanDuplication()
	
	public boolean bookmarkDup(String isbn, String id) {
		
		int count = bookCollectionMapper.bookmarkDup(isbn,id);
		boolean status = false;
		
		if(count > 0) {
			status = true;
		}
	
		return status;
	} //bookmarkDup() == bookmarkDuplication()
	
	public boolean loanStatus(String bookNum) {
		
		int count = bookCollectionMapper.loanStatus(bookNum);
		boolean status = false;
		
		if(count > 0) {
			status = true;
		}
		
		return status;
	} //loanStatus()
	
	public boolean checkStop(String bookNum, String isbn) {
		
		int count = bookCollectionMapper.checkStop(bookNum, isbn);
		boolean check = false;
		
		if(count > 0) {
			check = true;
		}
	
		return check;
	} //checkStop()
	
	public boolean checkOverdue(String id) {
		
		int count = bookCollectionMapper.checkOverdue(id);
		boolean check = false;
		
		if(count > 0) {
			check = true;
		}
	
		return check;
 	} //checkOverdue()
	
	public boolean checkDupBook(String isbn){
		int count = bookCollectionMapper.checkDupBook(isbn);
		boolean check = false;
		
		if(count > 0) {
			check = true;
		}
		
		return check;
	} //checkDupBook()
	
	public void loanBook(LoanBookVo loanBookVo) {
		bookCollectionMapper.loanBook(loanBookVo);
	} // loanBook()
	
	public void approveLoan(int num) {
		bookCollectionMapper.approveLoan(num);
	} //approveLoan()
	
	public void updateLoan(LoanBookVo loanBookVo) {
		bookCollectionMapper.updateLoan(loanBookVo);
	} //updateLoan()
	
	public void updateLoanCnt(String isbn) {
		bookCollectionMapper.updateLoanCnt(isbn);
	} //updateLoanCnt()
	
	public void returnBook(int num) {
		bookCollectionMapper.returnBook(num);
	} //returnBook()

	public void recordLoanBook(LoanBookVo loanBookVo, String type) {
		bookCollectionMapper.recordLoanBook(loanBookVo, type);
	} //recordLoanBook()
	
	public void recordBook(LoanBookVo loanBookVo, String image) {
		bookCollectionMapper.recordBook(loanBookVo, image);
	} //recordBook()
	
	public void updateLoanDate(LoanBookVo loanBookVo) {
		bookCollectionMapper.updateLoanDate(loanBookVo);
	} //updateLoan()
	
	public void updateLoanExtension(int num, int extension) {
		bookCollectionMapper.updateLoanExtension(num,extension);
	} //updateLoanExtension()
	
	public void updateReservation(String bookNum) {
		bookCollectionMapper.updateReservation(bookNum);
	} //updateReservation()

	public void cancelLoan(String bookNum) {
		bookCollectionMapper.cancelLoan(bookNum);
	} //cancelLoan()
	
	public void cancelReservations(String bookNum, String isbn) {	
		bookCollectionMapper.cancelReservations(bookNum,isbn);
	} //cancelReservation()
	
	public void cancelReservationById(String bookNum, String id) {
		bookCollectionMapper.cancelReservationById(bookNum, id);
	} //cancelReservation()
	
	public void cancelReservationByTurn(String bookNum, int turn) {
		bookCollectionMapper.cancelReservationByTurn(bookNum, turn);
	} //cancelReservation()

	public void reserveBook(ReserveBookVo reserveBookVo) {
		bookCollectionMapper.reserveBook(reserveBookVo);
	} //loanBook()
	
	public void stopUsing(BookDto bookDto) {
		bookCollectionMapper.stopUsing(bookDto);
	} //stopUsing()
	
	public void recoveryBook(String bookNum, String isbn) {
		bookCollectionMapper.recoveryBook(bookNum,isbn);
	} //recoveryBook()
	
	public void insertBookmark(BookmarkVo bookmarkVo) {
		bookCollectionMapper.insertBookmark(bookmarkVo);
	} //insertBookmark()
	
	public void deleteBookmark(String id, String isbn) {
		bookCollectionMapper.deleteBookmark(id, isbn);
	} //deleteBookmark()
	
}