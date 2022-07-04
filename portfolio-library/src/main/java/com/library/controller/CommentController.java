package com.library.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.library.service.CommentService;
import com.library.service.InquiryService;
import com.library.vo.CommentBlock;
import com.library.vo.CommentDto;
import com.library.vo.CommentVo;

import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/comment/*")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	@Autowired
	private InquiryService inquiryService;
	
	
	@GetMapping("/list")
	public @ResponseBody ResponseEntity<Map<String, Object>> getListWithPaging(@RequestParam("bno") int bno,
																 			   @RequestParam("pageNum") int pageNum) {
		
		CommentBlock block = new CommentBlock(pageNum, 20);
		CommentDto commentDto = commentService.getListWithPasing(bno, block);
		List<Object> parentList = new ArrayList<>();
		int i = 0;
		
		for(CommentVo commentVo : commentDto.getCommentList()) {
			
			if(commentVo.getParent() != null) {
				
				int cno = commentVo.getParent();
				String parent  = commentService.getNameByCno(cno);
				
				parentList.add(i , parent);
				i++;
			} else {
				parentList.add(i , null);
				i++;
			}
		} //for()
		
		Map<String, Object> result = new HashMap<>();
		result.put("commentDto", commentDto);
		result.put("parentList", parentList);
		result.put("pageNum", pageNum);
		
		return new ResponseEntity<Map<String, Object>>(result, HttpStatus.OK);
	} //getListWithPaging()
	
	@PostMapping("/insert")
	public void insertComment(@RequestBody CommentVo commentVo) {
		
		String id = commentVo.getId();
		int bno = commentVo.getBno();
		int num = commentService.getCommentNum();
		
		commentVo.setCno(num);
		commentVo.setCmRef(num);
		commentVo.setCmLevel(0);
		commentVo.setCmStep(0);
		
		commentService.insertComment(commentVo);
		if( id.equals("admin")) {	
			inquiryService.updateStatus(bno);
		}
	} //insertComment()
	
	@PostMapping("/insertNestedCm/{pageNum}")
	public int insertNestedCm(@RequestBody CommentVo commentVo,
							  @PathVariable("pageNum") int pageNum, HttpSession session) {
		//nestedCm == nestedComment
		
		Integer parent = commentVo.getCno();
		int num = commentService.getCommentNum();
		commentVo.setParent(parent);
		commentVo.setCno(num);
		String id = commentVo.getId();

		commentService.insertNestedCm(commentVo);
		
		if( id.equals("admin")) {
			int bno = commentVo.getBno();
			inquiryService.updateStatus(bno);
		}
		
		return pageNum;
	} //insertNestedCm()
	
	@PutMapping("/update/{pageNum}")
	public Object updateComment(@RequestBody CommentVo commentVo,
								@PathVariable("pageNum") int pageNum) {
		
		int cno = commentVo.getCno();
		int count = commentService.getNestedCmCount(cno);
		if(count > 0) {
			
			String result = "대댓글이 있으면 수정하실 수 없습니다.";
			
			return result;
			
		} else {
			
			commentService.updateComment(commentVo);
			
			return pageNum;
		}
	}//updateComment()
	
	@DeleteMapping("/delete/{cno}")
	public Object deleteComment(@PathVariable("cno") int cno) {
		
		CommentVo comment = commentService.getCommentByCno(cno);
		
		if(comment.getComment().equals("")) {
			
			String result = "이미 삭제된 댓글입니다.";
			
			return result;

		} else {
			
			int count = commentService.getNestedCmCount(cno);
			
			if(count == 0) {
				commentService.deleteComment(cno);
			} else {
				
				CommentVo commentVo = new CommentVo();
				commentVo.setCno(cno);
				commentVo.setComment("");
				
				commentService.updateComment(commentVo);
			}
			
			String result = "success";
			
			return result;
		}
	} //deleteComment()
}