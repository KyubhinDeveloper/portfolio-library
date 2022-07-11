package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.NoticeMapper;
import com.library.vo.NoticeVo;
import com.library.vo.QaVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;
	
	public void updateViews(int num) {

		noticeMapper.updateViews(num);
	} //updateViews()
	
	public void updateNotice(NoticeVo noticeVo) {
		
		noticeMapper.updateNotice(noticeVo);
	} //updateNotice()
	
	public void deleteNotice(int num) {
		
		noticeMapper.deleteNotice(num);
		
	} //deleteNotice()
	
	public int getTotalCount(String category, String search) {
		
		int totalCount = noticeMapper.getTotalCount(category, search);

		return totalCount;
	} //getTotalCount()
	
	public int getNoticeCount() {
		
		int noticeCount = noticeMapper.getNoticeCount();
		
		return noticeCount;
	} //getNoticeCount()
	
	public void insertNotice(NoticeVo noticeVo) {
		
		noticeMapper.insertNotice(noticeVo);
	
	} //insertNotice()
	
	public int getNoticeNum() {
		
		int noticeNum = noticeMapper.getNoticeNum();

		return noticeNum;
	} //getNoticeNum()
	
	public NoticeVo getNoticeByNum(int num) {
		
		NoticeVo noticeVo = noticeMapper.getNoticeByNum(num);
		
		return noticeVo;
			
	} //getNoticeByNum()
	
	public List<NoticeVo> getNoticeList(int startRow, int rowCount, String category, String search) {
		
		List<NoticeVo> noticelist = noticeMapper.getNoticeList(startRow, rowCount, category, search);

		return noticelist;
		
	} //getNoticeList()
	
	
	public NoticeVo getNoticeAndThumbnailByNum(int num) {

		NoticeVo noticeVo = noticeMapper.getNoticeAndThumbnailByNum(num);

		return noticeVo;

	} //getNoticeAndThumbnailByNum()
	
	public NoticeVo getNoticeAndFilesByNum(int num) {

		NoticeVo noticeVo = noticeMapper.getNoticeAndFilesByNum(num);

		return noticeVo;
	} //getNoticeAndFilesByNum()

	
}