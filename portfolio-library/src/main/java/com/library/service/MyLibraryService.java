package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.MyLibraryMapper;
import com.library.vo.ApplyBookVo;
import com.library.vo.BookmarkVo;
import com.library.vo.LoanBookVo;
import com.library.vo.LoanRecordVo;
import com.library.vo.LossRecordVo;
import com.library.vo.OverdueVo;
import com.library.vo.PersonalNoticeVo;
import com.library.vo.ReserveBookVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class MyLibraryService {
	
	@Autowired
	private MyLibraryMapper myLibraryMapper;
	
	public void applyBook(ApplyBookVo applyBookVo) {
		myLibraryMapper.applyBook(applyBookVo);
	} //applyBook()
	
	public void cancelApplication(int num) {
		myLibraryMapper.cancelApplication(num);
	} //cancelApplication()
	
	public void updateReadDate(int num, String date) {
		myLibraryMapper.updateReadDate(num,date);
	} //updateReadDate()
	
	public int getMyPrice(String id) {
		
		int myPrice = myLibraryMapper.getMyPriceById(id);
		
		return myPrice;
	}//getMyPrice()
	
	public int getMyNoticeCnt(String id) {
		int myNoticeCnt = myLibraryMapper.getMyNoticeCnt(id);
		return myNoticeCnt;
	}
	
	public int getBookmarkCnt(String id) { 	//Cnt == Count
		
		int totalCount = myLibraryMapper.getBookmarkCnt(id);
		
		return totalCount;
	} //getBookmarkCnt()
	
	public int getLoanCnt(String id) {
		
		int totalCount = myLibraryMapper.getLoanCnt(id);
		
		return totalCount;
	} //getMyLoanCnt()
	
	public int getLoanRecordCnt(String id) {
		
		int totalCount = myLibraryMapper.getLoanRecordCnt(id);
		
		return totalCount;
	} //getMyLoanCnt()
	
	public int getBookedCntByBookNum(String bookNum) {
		
		int reserveCnt = myLibraryMapper.getBookedCntByBookNum(bookNum);
		
		return reserveCnt;
	} //getBookedCntByBookNum()
	
	public int getBookedCntById(String id) {
		
		int reserveCnt = myLibraryMapper.getBookedCntById(id);
		
		return reserveCnt;
	} //getBookedCntById()
	
	public int getOverdueCnt(String id) {
		
		int overdueCnt = myLibraryMapper.getOverdueCnt(id);
		
		return overdueCnt;
	} //getOverdueCnt()
	
	public int getLossCnt(String id) {
		
		int lossCnt = myLibraryMapper.getLossCnt(id);
		
		return lossCnt;
	} //getOverdueCnt()
	
	public int overdueRecordCnt(String id) {
		
		int count = myLibraryMapper.overdueRecordCnt(id);
		
		return count;
	} //overdueRecordCnt()
	
	public int getApplicationCnt(String id) {
		
		int applicationCnt = myLibraryMapper.getApplicationCnt(id);
		
		return applicationCnt;
	} //getApplicationCnt()
	
	public int todayApplicationCnt(String today) {
		int count = myLibraryMapper.todayApplicationCnt(today);
		return count;
	} //todayApplicationCnt()
	
	public int totalApplicationCnt() {
		int totalCount = myLibraryMapper.totalApplicationCnt();
		return totalCount;
	} //totalApplicationCnt()
	
	
	public int getLossCount(String id) {
		
		int lossCount = myLibraryMapper.getLossCount(id);
		
		return lossCount;
	} //getLossCount();
	
	public int getLatefee(String id) {
		
		Integer overdueDay = myLibraryMapper.getOverdueDay(id);
		
		if(overdueDay.equals(null)) {
			int latefee = 0;
			return latefee;
			
		} else {
			
			int latefee = overdueDay * 100;
			return latefee;
		}
	} //getLateFee()
	
	public int getNoticeCnt(String id) {
	
		Integer noticeCnt = myLibraryMapper.getNoticeCnt(id); //cnt == count
		
		return noticeCnt;
	} //getNoticeCnt()
	
	public PersonalNoticeVo getNoticeVo(int num) {
		
		PersonalNoticeVo noticeVo = myLibraryMapper.getNoticeVo(num);
		
		return noticeVo;
	} //getNoticeVo()
	
	public List<BookmarkVo> getBookmarkList(String id) {
		
		List<BookmarkVo> bookmarkList = myLibraryMapper.getBookmarkList(id);
		
		return bookmarkList;
	} //getBookmarkList()
	
	public List<LoanBookVo> getLoanBookList(String id) {
		
		List<LoanBookVo> loanBookList = myLibraryMapper.getLoanBookList(id);
		
		return loanBookList;
	} //getLoanBookList()
	
	public List<LoanRecordVo> getLoanRecordList(String id, int startRow, int rowCount) {
		
		List<LoanRecordVo> loanRecordList = myLibraryMapper.getLoanRecordList(id,startRow,rowCount);
		
		return loanRecordList;
	} //getLoanBookList()
	
	public List<ReserveBookVo> getReserveList(String id) {
		
		List<ReserveBookVo> reserveList = myLibraryMapper.getReserveList(id);
		
		return reserveList;
	} //getReserveList()
	
	public List<ApplyBookVo> getApplicationList(String id) {
		
		List<ApplyBookVo> applicationList = myLibraryMapper.getApplicationList(id);
		
		return applicationList;
	} //getApplicationList()
	
	public List<LoanBookVo> getOverdueList(String id, int status) {
		
		List<LoanBookVo> overdueList = myLibraryMapper.getOverdueList(id,2);
		
		return overdueList;
	}
	
	public List<OverdueVo> getOdRecordList(String id) { //od == overdue
		
		List<OverdueVo> OverdueList = myLibraryMapper.getOdRecordList(id);
		
		return OverdueList;
	} //getOverdueList()
	
	public List<LossRecordVo> getLossRecordList(String id) {
		
		List<LossRecordVo> LossRecordList = myLibraryMapper.getLossRecordList(id);
		
		return LossRecordList;
	} //getLossRecordList()
	
	public List<PersonalNoticeVo> getNoticeList(String id, int startRow, int rowCount) {
		
		List<PersonalNoticeVo> noticeList = myLibraryMapper.getNoticeList(id,startRow,rowCount);
		
		return noticeList;
	} //personalNoticeList()
}