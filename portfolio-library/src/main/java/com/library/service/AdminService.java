package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.AdminMapper;
import com.library.vo.ApplyBookVo;
import com.library.vo.InquiryVo;
import com.library.vo.LoanBookVo;
import com.library.vo.LoanRecordVo;
import com.library.vo.LossRecordVo;
import com.library.vo.OverdueVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class AdminService {
	
	@Autowired
	AdminMapper adminMapper;
		
	public void sendingNotice(LoanBookVo loanBookVo, int type) {
		adminMapper.sendingNotice(loanBookVo, type);
	} //sendingNotice()
	
	public void sendingNotice2(LoanBookVo loanBookVo) {
		adminMapper.sendingNotice2(loanBookVo);
	} //sendingNotice5()
	
	public void sendingNotice6(String id, String content, String regDate) {
		adminMapper.sendingNotice6(id,content,regDate);
	} //sendingNotice6()
	
	public void registerForLoss(int num) {
		adminMapper.registerForLoss(num);
	} //registerForLoss()
	
	public void insertLostRecord(LoanBookVo loanBookVo) {
		adminMapper.insertLostRecord(loanBookVo);
	} //insertLostRecord()
	
	public void insertOverdueRecord(LoanBookVo loanBookVo, int latefee) {
		adminMapper.insertOverdueRecord(loanBookVo,latefee);
	} //insertOverdueRecord()
	
	public void updateOverdue(int num) {
		adminMapper.updateOverdue(num);
	} //updateOverdue()
	
	public void updateLossRecord(String returnDate, int num) {
		adminMapper.updateLossRecord(returnDate, num);
	} //updateLossRecord()
	
	public void changeStatus(int num, String status) {
		adminMapper.changeStatus(num,status);
	} //changeStatus()
	
	public int getLoanRecordCnt() {
		int totalCount = adminMapper.getLoanRecordCnt();
		return totalCount;
	} //getLoanRecordCnt()
	
	public int getLoanRecordSearchCnt(String category, String search, String type) {
		
		int loanRecordSearchCnt = adminMapper.getLoanRecordSearchCnt(category,search,type);
		return loanRecordSearchCnt;
	} //getLoanRecordSearchCnt()
	
	public int getOverdueCnt() {
		int totalCount = adminMapper.getOverdueCnt();
		return totalCount;
	} //getOverdueCnt()
	
	public int getOverdueCntById(String id) {
		int overdueCnt = adminMapper.getOverdueCntById(id);
		return overdueCnt;
	} //getOverdueCnt()
	
	public int getTodayOverdueCnt() {
		int todayOverdueCnt = adminMapper.getTodayOverdueCnt();
		return todayOverdueCnt;
	} //getTodayOverdunCnt()
	
	public int getOverdueRecordCnt() {
		int totalCount = adminMapper.getOverdueRecordCnt();
		return totalCount;
	} //getOverdueRecordCnt()
	
	public int getLossCnt() {
		int totalCount = adminMapper.getLossCnt();
		return totalCount;
	} //getLoanCnt()
	
	public int getLossCountById(String id) {
		int lossCount = adminMapper.getLossCountById(id);
		return lossCount;
	} //getLoanCnt()
	
	public int getLossRecordCnt() {
		int totalCount = adminMapper.getLossRecordCnt();
		return totalCount;
	} //getLoanRecordCnt()
	
	public int getTodayLossCnt(String today) {
		int todayLossCnt = adminMapper.getTodayLossCnt(today);
		return todayLossCnt;
	} //getTodayLossCnt()
	
	public int getHopeCount() {
		int totalCount = adminMapper.getHopeCount();
		return totalCount;
	} //getHopeCount()
	
	public int getOdSearchCnt(String category, String search) {
		int OdSearchCnt = adminMapper.getOdSearchCnt(category,search);
		return OdSearchCnt;
	} //getOverdueCnt()
	
	public int getOdRecordSearchCnt(String category, String search) {
		//od == overdue
		int odRecordSearchCnt = adminMapper.getOdRecordSearchCnt(category,search);
		return odRecordSearchCnt;
	} //getOverdueCnt()
	
	public int getLossSearchCnt(String category, String search) {
		int lossSearchCnt = adminMapper.getLossSearchCnt(category,search);
		return lossSearchCnt;
	} //getLossSearchCnt()
	
	public int getLossRecordSearchCnt(String category, String search) {
		
		int lossRecordSearchCnt = adminMapper.getLossRecordSearchCnt(category,search);
		return lossRecordSearchCnt;
	} //getOverdueCnt()
	
	public int getHopeSearchCnt(String category, String search, String status) {
		int hopeSearchCnt = adminMapper.getHopeSearchCnt(category, search, status);
		return hopeSearchCnt;
	} //getHopeSearchCnt()
	
	public int getInquirySearchCnt(String category, String search, String status) {
		int inquirySearchCnt = adminMapper.getInquirySearchCnt(category, search, status);
		return inquirySearchCnt;
	} //getHopeSearchCnt()
	
	public int getLossRecordNum(String id, String bookNum) {
		int num = adminMapper.getLossRecordNum(id, bookNum);
		return num;
	}//getLossRecordNum()
	
	public String getLossDateByBookNum(String bookNum) {		
		String lossDate = adminMapper.getLossDateByBookNum(bookNum);
		return lossDate;
	} //getLossDateByBookNum()
	
	public int getTotalLatefee() {	
		int totalLatefee = adminMapper.getTotalLatefee() * 100;
		return totalLatefee;
	} //getTotalLatefee()
	
	public List<LoanBookVo> getLoanList() {		
		List<LoanBookVo> loanList = adminMapper.getLoanList();
		return loanList;
	} //getLoanList()
	
	public List<LoanRecordVo> getLoanRecord(int rowCount, int startRow, String category, String search, String type) {	
		List<LoanRecordVo> loanRecord = adminMapper.getLoanRecord(rowCount,startRow,category,search,type);
		return loanRecord;
	} //getOverdueRecord()
	
	
	public List<LoanBookVo> getOverdueList(int rowCount, int startRow, String category, String search) {	
		List<LoanBookVo> overdueList = adminMapper.getOverdueList(rowCount,startRow,category,search);
		return overdueList;
	} //getOverdueList()
	
	public List<OverdueVo> getOverdueRecord(int rowCount, int startRow, String category, String search) {	
		List<OverdueVo> overdueRecord = adminMapper.getOverdueRecord(rowCount,startRow,category,search);
		return overdueRecord;
	} //getOverdueRecord()
	
	public List<LoanBookVo> getLossList(int rowCount, int startRow, String category, String search) {	
		List<LoanBookVo> lossList = adminMapper.getLossList(rowCount,startRow,category,search);
		return lossList;
	} //getOverdueList()
	
	public List<LossRecordVo> getLossRecord(int rowCount, int startRow, String category, String search) {	
		List<LossRecordVo> lossRecord = adminMapper.getLossRecord(rowCount,startRow,category,search);
		return lossRecord;
	} //getOverdueRecord()
	
	public List<LossRecordVo> getRecentLossList() {
		List<LossRecordVo> recentlossList = adminMapper.getRecentLossList();
		return recentlossList;
	} //getRecentLossList()
	
	public List<ApplyBookVo> getHopeList(int rowCount, int startRow, String category, String search, String status) {
		
		List<ApplyBookVo> hopeList = adminMapper.getHopeList(rowCount,startRow,category,search,status);
		return hopeList;
	} //getOverdueList()
	
	public List<InquiryVo> getInquiryList(int rowCount, int startRow, String category, String search, String status) {
		
		List<InquiryVo> inquiryList = adminMapper.getInquiryList(rowCount,startRow,category,search,status);
		return inquiryList;
	} //getOverdueList()
	
}