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
	
	// getCommentNum()
	public int getCommentNum() {
		
		int commentNum = commentMapper.getCommentNum();
		
		return commentNum;
	} 
	
	// getNameByCno()
	public String getNameByCno(int num) {
		
		String name = commentMapper.getNameByCno(num);
		
		return name;
	} 
	
	// getListWithPasing()
	public CommentDto getListWithPasing(int bno, CommentBlock block) {

		List<CommentVo> commentList = commentMapper.getListWithPaging(bno, block);
		//해당 글 댓글개수
		int count = commentMapper.getCommentCount(bno);
		CommentDto commentDto = new CommentDto(commentList, count);
		
		return commentDto;
	} 
	
	// 댓글 등록할때
	public void insertComment(CommentVo commentVo) {		
		commentMapper.insertComment(commentVo);	
	} 
	
	// 대댓글 등록할때
	public void insertNestedCm(CommentVo commentVo) { // nestedCm == nestedComment
		
		//대댓글이 다른 댓글들 중간에 들어갈경우 
		Integer result = commentMapper.checkStep(commentVo.getCmRef(), commentVo.getCmStep(), commentVo.getCmLevel());
		
		if(result == null) { // 다른 댓글이 없을경우
			int step = commentMapper.getMaxStep(commentVo.getCmRef());
			commentVo.setCmStep(step);
			
		} else { // 다른 댓글이 있을 경우
			commentMapper.updateStep(commentVo.getCmRef(), result);
			commentVo.setCmStep(result);
		}
		
		commentVo.setCmLevel(commentVo.getCmLevel() + 1);
		commentMapper.insertComment(commentVo);	
	} 
	
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
	

	
	public CommentVo getCommentByCno(int cno) {
		
		CommentVo commentVo = commentMapper.getCommentByCno(cno);
		
		return commentVo;
	} //getCommentByCno()

	
}