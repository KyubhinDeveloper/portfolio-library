package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.InquiryMapper;
import com.library.vo.InquiryVo;
import com.library.vo.NoticeVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class InquiryService {
	
	@Autowired
	InquiryMapper inquiryMapper;
	
	public void updateViews(int num) {
		inquiryMapper.updateViews(num);
	} //updateViews()
	
	public void updateStatus(int num) {
		inquiryMapper.updateStatus(num);
	} //updateStatus()
	
	public void updateInquiry(InquiryVo inquiryVo) {	
		inquiryMapper.updateInquiry(inquiryVo);
	} //updateInquiry()
	
	public void insertInquiry(InquiryVo inquiryVo) {	
		inquiryMapper.insertInquiry(inquiryVo);
	} //insertInquiry()
	
	public void deleteInquiry(int num) {
		//글 삭제
		inquiryMapper.deleteInquiry(num);
	} //deleteInquiry()
	
	public int totalCountById(String id) {	
		int totalCount = inquiryMapper.totalCountById(id);
	
		return totalCount;
	} //totalCountById()
	
	public int getTotalCount(String category, String search) {
		
		int totalCount = inquiryMapper.getTotalCount(category, search);

		return totalCount;
	} //getTotalCount()
	
	public int getInquiryCnt() {
		
		int inquiryCount = inquiryMapper.getInquiryCnt();
		
		return inquiryCount;
	} //getInquiryCnt()
	
	public int getSearchCount(String id, String category, String search) {
		
		int searchCount = inquiryMapper.getSearchCount(category, search, id);
		
		return searchCount;
	} //getSearchCount()
	
	public int getInquiryNum() {
		
		int inquiryNum = inquiryMapper.getInquiryNum();

		return inquiryNum;
	} //getInquiryNum()
	
	public List<InquiryVo> getInquiryList(int startRow, int rowCount, String category, String search) {
		
		List<InquiryVo> inquirylist = inquiryMapper.getInquiryList(startRow, rowCount, category, search);

		return inquirylist;
	} //getInquiryList()
	
	public List<InquiryVo> inquiryListById(int startRow, int rowCount, String category, String search, String id ) {
		
		List<InquiryVo> inquirylist = inquiryMapper.inquiryListById(startRow, rowCount, category, search, id);
		
		return inquirylist;
	} //inquiryListById()
	
	public InquiryVo getInquiryByNum(int num) {
		
		InquiryVo inquiryVo = inquiryMapper.getInquiryByNum(num);
		
		return inquiryVo;
			
	} //getNoticeByNum()
}