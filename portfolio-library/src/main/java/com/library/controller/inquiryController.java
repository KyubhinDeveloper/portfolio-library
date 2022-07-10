package com.library.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.service.CommentService;
import com.library.service.InquiryService;
import com.library.vo.InquiryVo;
import com.library.vo.PageDto;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/community/*")
public class inquiryController {
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	CommentService commentService;
	
	
	@GetMapping("/inquiryForum")
	public String inquiryForum(@RequestParam(defaultValue = "1") int pageNum, 
					  	 	   @RequestParam(defaultValue = "") String category, 
					  	 	   @RequestParam(defaultValue = "") String search, 
					  	 	   Model model, HttpSession session) throws ParseException {
		
		int totalCount = inquiryService.getTotalCount(category, search);
		int rowCount = 10;
		int startRow = (pageNum - 1) * rowCount;

		if (totalCount > 0) {

			Long time;
			List<InquiryVo> inquiryList = inquiryService.getInquiryList(startRow, rowCount, category, search);
			List<Object> timeList = new ArrayList<>();
			int i = 0;

			for (InquiryVo inquiryVo : inquiryList) {
				time = this.timeGap(inquiryVo);
				timeList.add(i, time);
				i++;
			}
			
			model.addAttribute("inquiryList", inquiryList);
			model.addAttribute("timeList", timeList);

		} //if()	

		int pageCount = totalCount / rowCount;

		if (totalCount % rowCount > 0) {

			pageCount += 1;
		}

		// 페이지 블록에 보여줄 최대 갯수
		int pageBlock = 10;

		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;

		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {

			endPage = pageCount;
		}

		PageDto pageDto = new PageDto();

		pageDto.setCategory(category);
		pageDto.setSearch(search);
		pageDto.setTotalCount(totalCount);
		pageDto.setRowCount(rowCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);

		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "/community/inquiryForum";
	} //inquiryForum()
	
	@GetMapping("/inquiryContent")
	public String inquiryContent(@ModelAttribute("pageNum") String pageNum, 
							     @RequestParam("num") int num, HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		inquiryService.updateViews(num);

		InquiryVo inquiryVo = inquiryService.getInquiryByNum(num);

		String content = "";

		if (inquiryVo.getContent() != null) {

			content = inquiryVo.getContent().replace("\r\n", "<br>");
			inquiryVo.setContent(content);
		}

		model.addAttribute("id", id);
		model.addAttribute("inquiry", inquiryVo);

		return "/community/inquiryContent";
	}
	
	@GetMapping("/writeInquiry")
	public void writeInquiry() {
		
	}
	
	@PostMapping("/writeInquiry")
	public ResponseEntity<String> writeInquiry(InquiryVo inquiryVo, HttpServletRequest request, HttpSession session) throws Exception{
		
		String id = (String) session.getAttribute("id");
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		StringBuilder sb = new StringBuilder();

		if (id == null) {

			sb.append("<script>");
			sb.append("alert('세션이 만료되었거나 로그인을 하지 않으셨습니다. 로그인 해주세요.')");
			sb.append("location.href = '/member/login';");
			sb.append("</script>");

			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);

		} else {
			
			String name = (String) session.getAttribute("name");
			int num = inquiryService.getInquiryNum();
			String date = this.currentTime();
			String ip = this.getIp(request);
			String secret = inquiryVo.getSecret();
			
			if(secret == null) {		
				inquiryVo.setSecret("일반글");
			}
			
			inquiryVo.setId(id);
			inquiryVo.setName(name);
			inquiryVo.setIp(ip);
			inquiryVo.setRegDate(date);
			inquiryVo.setNum(num);
			inquiryService.insertInquiry(inquiryVo);
			
			sb.append("<script>");
			sb.append("location.href = '/community/inquiryForum';");
			sb.append("alert('게시물이 등록되었습니다.')");
			sb.append("</script>");

			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}
	}
	
	@GetMapping("/editInquiry")
	public String editInquiry(@ModelAttribute("pageNum") String pageNum, 
							  @RequestParam("num") int num, HttpSession session, Model model) {

		String id = (String)session.getAttribute("id");
		InquiryVo inquiryVo = inquiryService.getInquiryByNum(num);
		
		if (id == null) {
			return "/member/login";
		} else if(id.equals(inquiryVo.getId()) || id.equals("admin")) {
			model.addAttribute("inquiry", inquiryVo);
			return "/community/editInquiry";		
		} else {
			return "/community/inquiryForum";
		}
	} //editInquiry()
	
	@PutMapping("/editInquiry")
	public String editInquiry(@ModelAttribute("pageNum") String pageNum, 
							  @RequestParam("num") int num, InquiryVo inquiryVo,
							  HttpSession session, Model model) {
		
		String secret = inquiryVo.getSecret();
		
		if(secret == null) {		
			inquiryVo.setSecret("일반글");
		}
		
		inquiryService.updateInquiry(inquiryVo);
		
		return "redirect:/community/inquiryContent?pageNum=" + pageNum + "&num=" + num;		
	}
	
	@DeleteMapping("/deleteInquiry")
	public @ResponseBody void deleteInquiry(@RequestParam("pageNum") String pageNum,
											@RequestParam("num") int num) {
		
		int commentCount = commentService.getCommentCount(num);
		if(commentCount > 0) {
			commentService.deleteAllComment(num);
		}
		inquiryService.deleteInquiry(num);		
	} //deleteInquiry()
	
	private String getIp(HttpServletRequest request) {

		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		return ip;
	} // getIp()
	
	private String currentTime() {

		LocalDateTime dateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String date = dateTime.format(formatter);

		return date;

	} // currentTime()

	private String currentDate() {

		LocalDateTime dateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		String strDate = dateTime.format(formatter);
		return strDate;

	} // currentDate()
	
	private Long timeGap(InquiryVo inquiryVo) throws ParseException {

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

		String currentTime = this.currentTime();
		String writeTime = inquiryVo.getRegDate();

		Date writeDate = dateFormat.parse(writeTime);
		Date currentDate = dateFormat.parse(currentTime);

		long time = (currentDate.getTime() - writeDate.getTime()) / 60000;

		return time;

	} // timeGap()
}