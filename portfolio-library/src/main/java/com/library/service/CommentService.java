package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.CommentMapper;
import com.library.vo.CommentBlock;
import com.library.vo.CommentDto;
import com.library.vo.CommentVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class CommentService {
	
	@Autowired
	CommentMapper commentMapper;
	
	public void insertComment(CommentVo commentVo) {
		
		commentMapper.insertComment(commentVo);	
	} //insertComment()
	
	public void insertNestedCm(CommentVo commentVo) {
		//nestedCm == nestedComment
			
		Integer result = commentMapper.checkStep(commentVo.getCmRef(), commentVo.getCmStep(), commentVo.getCmLevel());
		
		if(result == null) {
			int step = commentMapper.getMaxStep(commentVo.getCmRef());
			commentVo.setCmStep(step);
			
		} else {
			commentMapper.updateStep(commentVo.getCmRef(), commentVo.getCmLevel());
			commentVo.setCmStep(result);
		}
		
		commentVo.setCmLevel(commentVo.getCmLevel() + 1);
		commentMapper.insertComment(commentVo);	
	} //insertNestedCm()
	
	public void updateComment(CommentVo commentVo) {
		
		commentMapper.updateComment(commentVo);
	} //updateComment()
	
	public void deleteComment(int cno) {
		
		commentMapper.deleteComment(cno);
	} //deleteComment()
	
	public void deleteAllComment(int bno) {
		
		commentMapper.deleteAllComment(bno);
	} //deleteAllComment()
	
	public int getCommentCount(int num) {
		
		int count = commentMapper.getCommentCount(num);
		
		return count;
	} //getTotalCount()
	
	public int getNestedCmCount(int cno) {
		////nestedCm == nestedComment
		int count = commentMapper.getNestedCmCount(cno);
		
		return count;
	} //getNestedCmCount()
	
	public String getNameByCno(int num) {
		
		String name = commentMapper.getNameByCno(num);
		
		return name;
	} //getNameByCno()
	
	public int getCommentNum() {
		
		int commentNum = commentMapper.getCommentNum();
		
		return commentNum;
	} //getCommentNum()
	
	public CommentDto getListWithPasing(int bno, CommentBlock block) {

		List<CommentVo> commentList = commentMapper.getListWithPaging(bno, block);
		int count = commentMapper.getCommentCount(bno);
		CommentDto commentDto = new CommentDto(commentList, count);
		
		return commentDto;
	} //getListWithPasing()
	
	public CommentVo getCommentByCno(int cno) {
		
		CommentVo commentVo = commentMapper.getCommentByCno(cno);
		
		return commentVo;
	} //getCommentByCno()

	
}