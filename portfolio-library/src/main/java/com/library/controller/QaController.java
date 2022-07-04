package com.library.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.service.QaService;
import com.library.vo.QaVo;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/community/*")
public class QaController {
	
	@Autowired
	private QaService qaService;
	
	@GetMapping("/qaForum")
	public String qaForum(HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("id");
		
		List<QaVo> qaList = qaService.getQaList();
		
		model.addAttribute("qaVo", qaList);
		model.addAttribute("id", id);
	
		return "/community/qaForum";
	} //qaForum()
	
	@PostMapping("/writeQa")
	public ResponseEntity<String> writeQa(QaVo qaVo) {
		
		qaService.writeQa(qaVo);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		StringBuilder sb = new StringBuilder();

		sb.append("<script>");
		sb.append("location.href = '/community/qaForum';");
		sb.append("alert('질문과 답변이 등록되었습니다..');");
		sb.append("</script>");
		
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
	}//writeQa()
	
	@DeleteMapping("/deleteQa/{num}")
	public ResponseEntity<String> deleteQa(@PathVariable("num") int num) {
		
		qaService.deleteQa(num);
		
		String message = "질문과 답변이 삭제되었습니다.";
		
		return new ResponseEntity<String> (message, HttpStatus.OK);
	}//deleteQa()
	
}