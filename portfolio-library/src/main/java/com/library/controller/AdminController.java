package com.library.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.service.AdminService;
import com.library.service.BookCollectionService;
import com.library.service.CommentService;
import com.library.service.InquiryService;
import com.library.service.MemberService;
import com.library.service.NoticeService;
import com.library.vo.ApplyBookVo;
import com.library.vo.BookDto;
import com.library.vo.CommentBlock;
import com.library.vo.CommentDto;
import com.library.vo.CommentVo;
import com.library.vo.InquiryVo;
import com.library.vo.LoanBookVo;
import com.library.vo.LoanRecordVo;
import com.library.vo.LossRecordVo;
import com.library.vo.MemberVo;
import com.library.vo.MemoVo;
import com.library.vo.NoticeVo;
import com.library.vo.OverdueVo;
import com.library.vo.PageDto;
import com.library.vo.ReserveBookVo;
import com.library.vo.UploadFileVo;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/adminPage/*")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private InquiryService inquiryService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private BookCollectionService bookCollectionService;
	
	
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("id");
		
		if(!id.equals("admin")) {
			return "/index";
		} else if(id.equals(null)) {
			return "/member/login";
		} else {
			List<LoanBookVo> recentloanList = bookCollectionService.getRecentLoanList();
			List<LossRecordVo> recentLossList = adminService.getRecentLossList(); 
			model.addAttribute("recentloanList", recentloanList);
			model.addAttribute("recentLossList", recentLossList);
			return "/adminPage/dashboard";	
		}
	} //dashboard()
	
	@GetMapping("/dashboard/chart")
	public ResponseEntity<Map<String,Object>> getDashboardChart() {
		
		int listCount = 5;		
		List<MemberVo> memberLankingList = memberService.getLankingList(listCount);
		List<BookDto> bookLankingList = bookCollectionService.getPopularBookList(listCount);
		Map<String,Object> result = new HashMap<>();
		result.put("memberLank", memberLankingList);
		result.put("bookLank", bookLankingList);
		
		return new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);
	} //getDashboardChart()
	
	@GetMapping("/dashboard/loanInfo")
	public ResponseEntity<Map<String,Object>> getLoanInfo() {
    	
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		String today = now.format(formatter);
		Map<String,Object> result = new HashMap<>();
		Map<String,Object> loanInfo = new HashMap<>();
		Map<String,Object> overdueInfo = new HashMap<>();
		Map<String,Object> lossInfo = new HashMap<>();

		//대출정보
    	int loanCount = bookCollectionService.getLoanCount(); //cnt == count
    	int todayLoanCnt = bookCollectionService.getTodayLoanCnt(today);
    	loanInfo.put("loanCount", loanCount);
		loanInfo.put("todayLoanCnt", todayLoanCnt);	
		
		//연체정보
    	int overdueCnt = adminService.getOverdueCnt();
    	int todayOverdueCnt = adminService.getTodayOverdueCnt();
    	overdueInfo.put("overdueCnt", overdueCnt);
    	overdueInfo.put("todayOverdueCnt", todayOverdueCnt);
    	
    	//대출정보
    	int lossCount = adminService.getLossCnt();
    	int todayLossCnt = adminService.getTodayLossCnt(today);
    	lossInfo.put("lossCount", lossCount);
    	lossInfo.put("todayLossCnt", todayLossCnt);
    	
    	//연체료 정보
    	int totalLatefee = adminService.getTotalLatefee();
    	
    	result.put("loanInfo", loanInfo);
    	result.put("overdueInfo", overdueInfo);
    	result.put("lossInfo", lossInfo);
    	result.put("totalLatefee", totalLatefee);
    	
    	
    	
    	return new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);	
    } //getLoanInfo()

	@GetMapping("/member/management")
	public void memberManagement(@RequestParam(defaultValue = "1") int pageNum,
								 @RequestParam(defaultValue = "") String category,
								 @RequestParam(defaultValue = "") String search,
								 @RequestParam(defaultValue = "") String grade, 
								 HttpSession session, Model model) {

		int searchCount = memberService.getSearchCount(category, search, grade);
		int totalCount = memberService.getTotalCount();

		int rowCount = 7;
		int startRow = (pageNum - 1) * rowCount;

		if (searchCount > 0) {

			List<MemberVo> memberList = memberService.getMemberList(startRow, rowCount, category, search, grade);
			List<Object> overdueCntList = new ArrayList<>();
			List<Object> lossCntList = new ArrayList<>();
			int i = 0;
						
			for(MemberVo member : memberList) {			
				String id = member.getId();
				int overdueCnt = adminService.getOverdueCntById(id);
				int lossCount = adminService.getLossCountById(id);
				overdueCntList.add(i,overdueCnt);
				lossCntList.add(i,lossCount);
				i++;
			} //for()
			
			int pageCount = searchCount / rowCount;

			if (searchCount % rowCount > 0) {
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

			model.addAttribute("memberList", memberList);
			model.addAttribute("overdueCnt", overdueCntList);
			model.addAttribute("lossCount", lossCntList);
			model.addAttribute("pageDto", pageDto);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("grade", grade);
			model.addAttribute("searchCount", searchCount);
		} // if()
	} // memberManagement()

	@GetMapping("/member/postList")
	public String memberPostList(@RequestParam("id") String id, 
								 @RequestParam(defaultValue="1") int pageNum,
								 @RequestParam(defaultValue="") String search,
								 @RequestParam(defaultValue="") String category,
								 Model model) {
		
		int totalCount = inquiryService.totalCountById(id);
		int searchCount = inquiryService.getSearchCount(id, category, search);
		String name = memberService.getNameById(id);
		int rowCount = 9;
		int startRow = (pageNum - 1) * rowCount;
		
		if(totalCount > 0) {
			
			List<InquiryVo> inquiryList = inquiryService.inquiryListById(startRow, rowCount, category, search, id);
			List<Object> cmCountList = new ArrayList<>(); //cm == comment
			int i = 0;
			
			for(InquiryVo inquiryVo : inquiryList) {
				
				int num = inquiryVo.getNum();			
				int commentCount = commentService.getCommentCount(num);
				cmCountList.add(i, commentCount);
				i++;
			} 
			
			int pageCount = totalCount / rowCount;
			
			if(totalCount % rowCount > 0) {			
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
			model.addAttribute("inquiryList", inquiryList);
			model.addAttribute("searchCount", searchCount);
			model.addAttribute("cmCountList", cmCountList);		
		} //if()
		
		model.addAttribute("id", id);
		model.addAttribute("name", name);
		
		return "/adminPage/member/postList";
	} //memberPostList()

	@GetMapping("/member/sendMail")
	public void sendMail(@RequestParam ArrayList<String> idList, Model model) {
		
		model.addAttribute("idList", idList);
	} //sendMail()
	
	@PostMapping("/member/sendMail")
	public @ResponseBody void sendMailToId(@RequestParam("id[]") ArrayList<String> idList,
										   @RequestParam("content") String content) {
		
		LocalDateTime dateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		String regDate = dateTime.format(formatter);
		
		for(String id : idList) {		
			adminService.sendingNotice6(id,content,regDate);
		}
	} //sendMailToCheckId()
	
	
	@GetMapping("/member/info")
	public String memberInfo(@RequestParam("id") String id, Model model) {
		
		MemberVo memberVo = memberService.getInfoById(id);
		List<MemoVo> memoList = memberService.getMemoList(id);
		
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("memoList", memoList);
	
		return "/adminPage/member/info";
	} //memberInfo()

	@PostMapping("/member/changeGrade")
	public @ResponseBody void changeGrade(@RequestParam("id[]") ArrayList<String> idList,
										  @RequestParam("grade[]") ArrayList<String> gradeList) {

		 if(idList.size() > 0) {
			 for(int i = 0; i < idList.size(); i++) {	 
				
				 String id = idList.get(i); 
				 String grade = gradeList.get(i);		
				 memberService.changeGrade(id, grade); 
			 } 
		 }
	} // changeGrade()
	
	@DeleteMapping("/member/secession")
	public @ResponseBody void secession(@RequestParam("id[]") ArrayList<String> idList) {
		
		if(idList.size() > 0) {		
			 for(int i = 0; i < idList.size(); i++) {		 
				 String id = idList.get(i); 	
				 memberService.secession(id); 
			 } 
		}
	} //secession()
	
	@PostMapping("/member/registMemo")
	public @ResponseBody void registMemo(@RequestBody MemoVo memoVo, HttpSession session) {
		
		String id = (String)session.getAttribute("id");
		String writer = memberService.getNameById(id);
		LocalDateTime dateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		String regDate = dateTime.format(formatter);
	
		memoVo.setWriter(writer);
		memoVo.setRegDate(regDate);

		memberService.registMemo(memoVo);
	} //registMemo()
	
	@DeleteMapping("/member/deleteMemo")
	public @ResponseBody void deleteMemo(@RequestParam("num") int num) {
		
		memberService.deleteMemo(num);
		
	} //deleteMemo()
	
	@DeleteMapping("/member/deletePost")
	public @ResponseBody void deletePost(@RequestParam("num[]") ArrayList<Integer> numList) {
		
		if(numList.size() > 0) {
			 for(int i = 0; i < numList.size(); i++) {		 
				 int num = numList.get(i); 	
				 inquiryService.deleteInquiry(num); 
			 } 
		}
	} //deletePost()
	
	@GetMapping("/book/detail")
	public void bookDetail() {

	}

	@GetMapping("/book/loanStatus")
	public String loanPage(@RequestParam(defaultValue = "1") int pageNum,
			 			   @RequestParam(defaultValue = "") String category,
			 			   @RequestParam(defaultValue = "") String search,
			 			   @RequestParam(defaultValue = "") String status,
			 			   HttpSession session, Model model) {
		
		int totalCount = bookCollectionService.getLoanCount();
		int searchCount = bookCollectionService.getLoanSearchCnt(category, search, status); //cnt == count
		int rowCount = 7;
		int startRow = (pageNum - 1) * rowCount;
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("searchCount", searchCount);
		
		if(totalCount > 0) {
			List<LoanBookVo> loanBookList = bookCollectionService.getLoanBookList(rowCount, startRow, category, search, status);
			model.addAttribute("loanBookList", loanBookList);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		model.addAttribute("status", status);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchCount", searchCount);
			
		return "/adminPage/book/loanStatus";
	} //loanPage()
	
	@GetMapping("/book/loanRecord")
	public @ResponseBody Object loanRecord(@RequestParam(defaultValue = "1") int pageNum,
										   @RequestParam(defaultValue = "") String category,
										   @RequestParam(defaultValue = "") String search,
										   @RequestParam(defaultValue = "") String type,
										   HttpSession session, Model model) {
	
		int loanRecordCnt= adminService.getLoanRecordCnt();
		int totalCount = adminService.getLoanRecordSearchCnt(category,search,type);
		int rowCount = 7;
		int startRow = (pageNum - 1) * rowCount;
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(totalCount > 0) {	
			List<LoanRecordVo> loanRecord = adminService.getLoanRecord(rowCount, startRow, category, search, type);
			result.put("loanRecord", loanRecord);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		
		result.put("pageDto", pageDto);
		result.put("pageNum", pageNum);
		result.put("type", type);
		result.put("loanRecordCnt", loanRecordCnt);

		return result;
	} //loanRecord()
	
	@PostMapping("/book/approveLoan")
	public @ResponseBody String approveLoan(@RequestParam("num") int num) throws ParseException {
		
		//대출자 연체체크
		String borrowerId = bookCollectionService.getIdByNum(num);
		boolean check = bookCollectionService.checkOverdue(borrowerId);
		String str = "";
		
		if(check) {		
			str = "연체중인 도서가 있어 대출하실 수 없습니다.";
			return str;	
		} else {
			LoanBookVo loanBookVo = bookCollectionService.getLoanBook(num);
			String id = loanBookVo.getId();
			String isbn = loanBookVo.getIsbn();
			//도서기록 중복체크
			boolean checkDupBook = bookCollectionService.checkDupBook(isbn);
			
			if(checkDupBook) {
				bookCollectionService.updateLoanCnt(isbn);
			} else {
				
				String clientId = "V13D110SmuPrLT7qX_te";
				String clientSecret = "3FiEveNOE4";
				String text = null;
				
				try { 
					text = URLEncoder.encode(isbn , "UTF-8"); 
				} catch (UnsupportedEncodingException e){
					throw new RuntimeException("검색어 인코딩 실패", e);
				}
				
				String apiURL = "https://openapi.naver.com/v1/search/book.json?query='"+ text +"'";
				
				Map<String,String> requestHeaders = new HashMap<>();
				requestHeaders.put("X-Naver-Client-Id", clientId);
				requestHeaders.put("X-Naver-Client-Secret", clientSecret);
				
				String responseBody = get(apiURL, requestHeaders);			
				JSONParser parser = new JSONParser();
				JSONObject obj = (JSONObject)parser.parse(responseBody);				
					
				Object total = obj.get("total");
				String strTotal = String.valueOf(total);
				int totalCount = Integer.parseInt(strTotal);
				
				if(totalCount > 0) {				
					JSONArray item = (JSONArray)obj.get("items");
					
					for (int i = 0; i < item.size(); i ++) {
						
						JSONObject tmp = (JSONObject)item.get(i);
						String image = (String)tmp.get("image");
						bookCollectionService.recordBook(loanBookVo,image);
					} 	
				} //if()
			} //else
			
			//대출승인
			bookCollectionService.approveLoan(num);
			//대출자 대출횟수 증가
			memberService.updateLoanCnt(id); //cnt == count
			
			str = "대출이 승인되었습니다.";
			return str;
		} //else
	} //approveLoan()
	
	@DeleteMapping("/book/returnBook/checked")
	public @ResponseBody void approvecheckedLoan(@RequestParam("num[]") ArrayList<Integer> numList) {
		
		if(numList.size() > 0) { 
			for(int i = 0; i < numList.size(); i++) {
				
				int num = numList.get(i);
				LoanBookVo loanBookVo = bookCollectionService.getLoanBook(num);
				String bookNum = loanBookVo.getBookNum();
				String status = loanBookVo.getStatus();
				int reserverCnt = bookCollectionService.getReservationCount(bookNum); //cnt == count
				String type = "정상반납";
				
				if(reserverCnt > 0) {
					if(reserverCnt >= 1) {
						//반납기록할 새 번호 
						int newNum = bookCollectionService.getLoanNumFromRecord();
						//반납날짜
						LocalDateTime now = LocalDateTime.now();
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
						String returnDate = now.format(formatter);
						
						loanBookVo.setNum(newNum);
						loanBookVo.setEndDate(returnDate);
						
						//반납도서 기록
						bookCollectionService.recordLoanBook(loanBookVo, type);					
						//반납공지 발송
						adminService.sendingNotice(loanBookVo, 1);
						
						String reserverId = bookCollectionService.getReserver(bookNum, 1);
						String name = memberService.getNameById(reserverId);			
						LocalDateTime end =  now.plusDays(14);
						String loanDate = now.format(formatter);
						String endDate = end.format(formatter);
						newNum = bookCollectionService.getLoanNum();
						
						loanBookVo.setNum(newNum);
						loanBookVo.setId(reserverId);
						loanBookVo.setName(name);
						loanBookVo.setLoanDate(loanDate);
						loanBookVo.setEndDate(endDate);
						loanBookVo.setStatus("대기중");
						
						//기존 대출자정보 위에 새로운 대출자 정보 덮어씌우기
						bookCollectionService.updateLoan(loanBookVo);
						//1번 예약자 삭제 
						bookCollectionService.cancelReservationByTurn(bookNum, 1);
						//예약도서 대출가능 알림발송
						adminService.sendingNotice(loanBookVo,5); 
				
						if(reserverCnt > 1) {			
							bookCollectionService.updateReservation(bookNum);
						}
					} //if()
				} else {
					bookCollectionService.returnBook(num); //도서반납
					//반납공지 발송
					adminService.sendingNotice(loanBookVo, 1);
					//반납기록할 새 번호 
					int newNum = bookCollectionService.getLoanNumFromRecord();
					//반납날짜
					LocalDateTime now = LocalDateTime.now();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
					String returnDate = now.format(formatter);
					
					loanBookVo.setNum(newNum);
					loanBookVo.setEndDate(returnDate);
					bookCollectionService.recordLoanBook(loanBookVo, type); //반납기록
				}	
			} //for()
		} //if()
	} //approvecheckedLoan()
	
	@DeleteMapping("/book/returnBook")
	public @ResponseBody void returnBook(@RequestParam("num") int num) {
		
		LoanBookVo loanBookVo = bookCollectionService.getLoanBook(num);
		String bookNum = loanBookVo.getBookNum();
		String status = loanBookVo.getStatus();
		//예약자 수
		int reserverCnt = bookCollectionService.getReservationCount(bookNum); //cnt == count
		String type = "정상반납"; 
	
		if(status.equals("연체중")) {
			type = "연체반납"; 
		} else if(status.equals("분실중")) {
			type = "분실반납"; 
		} 
		
		if(reserverCnt > 0) {
			if(reserverCnt >= 1) {
				
				//반납기록할 새 번호 
				int newNum = bookCollectionService.getLoanNumFromRecord();
				//반납날짜
				LocalDateTime now = LocalDateTime.now();
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
				String returnDate = now.format(formatter);
				
				loanBookVo.setNum(newNum);
				loanBookVo.setEndDate(returnDate);
				
				if(status.equals("연체중")) {
					//연체료
					int latefee = loanBookVo.getOverdueDate() * 100;
					//연체반납 기록
					adminService.insertOverdueRecord(loanBookVo, latefee);
				} else if(status.equals("분실중")) {
					
					String id = loanBookVo.getId();
					//분실기록 번호
					int lossNum = adminService.getLossRecordNum(id,bookNum);
					//분실반납 기록수정
					adminService.updateLossRecord(returnDate, lossNum);
				}
				
				//반납도서 기록
				bookCollectionService.recordLoanBook(loanBookVo, type); 
				
				//반납공지 발송
				adminService.sendingNotice(loanBookVo,1);
				
				String reserverId = bookCollectionService.getReserver(bookNum, 1);
				String name = memberService.getNameById(reserverId);			
				LocalDateTime end =  now.plusDays(14);
				String loanDate = now.format(formatter);
				String endDate = end.format(formatter);
				newNum = bookCollectionService.getLoanNum();
				
				loanBookVo.setNum(newNum);
				loanBookVo.setId(reserverId);
				loanBookVo.setName(name);
				loanBookVo.setLoanDate(loanDate);
				loanBookVo.setEndDate(endDate);
				loanBookVo.setStatus("대기중");
				
				//기존 대출자정보 위에 새로운 대출자 정보 덮어씌우기
				bookCollectionService.updateLoan(loanBookVo);
				//1번 예약자 삭제 
				bookCollectionService.cancelReservationByTurn(bookNum, 1);
				//예약도서 대출가능 알림발송
				adminService.sendingNotice(loanBookVo,5); 
		
				if(reserverCnt > 1) {			
					bookCollectionService.updateReservation(bookNum);
				}
			} //if()
		} else {
			
			//반납날짜
			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
			String returnDate = now.format(formatter);
			loanBookVo.setEndDate(returnDate);
						
			if(status.equals("연체중")) {
				//연체료
				int latefee = loanBookVo.getOverdueDate() * 100;
				//연체반납 기록
				adminService.insertOverdueRecord(loanBookVo, latefee);
			} else if(status.equals("분실중")) {
				
				String id = loanBookVo.getId();
				//분실기록 번호
				int lossNum = adminService.getLossRecordNum(id,bookNum);
				log.info("lossNum: " + lossNum);
				log.info("returnDate: " + returnDate);
				//분실반납 기록수정
				adminService.updateLossRecord(returnDate, lossNum);
			}
			
			//도서반납
			bookCollectionService.returnBook(num); 			
			//반납공지 발송
			adminService.sendingNotice(loanBookVo, 1);
			//반납기록할 새 번호 
			int newNum = bookCollectionService.getLoanNumFromRecord();
			
			loanBookVo.setNum(newNum);
			bookCollectionService.recordLoanBook(loanBookVo, type); //반납기록
		}
	} //returnBook()
	
	@DeleteMapping("/book/cancelLoan")
	public @ResponseBody void cancelBook(@RequestParam("num[]") ArrayList<Integer> numList) {
		
		if(numList.size() > 0) {
			for(int i = 0; i < numList.size(); i++) {
				
				int num = numList.get(i);
				LoanBookVo loanBookVo = bookCollectionService.getLoanBook(num);
				String bookNum = loanBookVo.getBookNum();
				
				//대출도서 예약자수
				int reserverCnt = bookCollectionService.getReservationCount(bookNum); //cnt == count
				
				if(reserverCnt > 0) {
					if(reserverCnt >= 1) {
						
						int newNum = bookCollectionService.getLoanNum();
						String reserverId = bookCollectionService.getReserver(bookNum,1);
						String name = memberService.getNameById(reserverId);
						LocalDateTime now = LocalDateTime.now();
						LocalDateTime end =  now.plusDays(14);
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
						String loanDate = now.format(formatter);
						String endDate = end.format(formatter);
					
						loanBookVo.setNum(newNum);
						loanBookVo.setId(reserverId);
						loanBookVo.setName(name);
						loanBookVo.setLoanDate(loanDate);
						loanBookVo.setEndDate(endDate);
						loanBookVo.setStatus("대기중");
						
						//대출기록 삭제안하고 그위에 새로운 기록 덮어씌우기
						bookCollectionService.updateLoan(loanBookVo);
						//1번예약자 삭제
						bookCollectionService.cancelReservationByTurn(bookNum, 1); 
						//예약도서 대출가능 알림발송
						adminService.sendingNotice(loanBookVo,5); 
						
						if(reserverCnt > 1) {			
							bookCollectionService.updateReservation(bookNum);
						}
					} //if
				} else {
					bookCollectionService.cancelLoan(bookNum);
				}
			} //for()
		} //if()
	} //cancelBook()
	
	@GetMapping("/book/reserveStatus")
	public void reservePage(@RequestParam(defaultValue = "1") int pageNum,
			   				@RequestParam(defaultValue = "") String category,
			   				@RequestParam(defaultValue = "") String search,
			   				HttpSession session, Model model) {
		
		int totalCount = bookCollectionService.getReservationCnt();
		int searchCount = bookCollectionService.getRsSearchCnt(category, search); //cnt == count , rs == reservation
		int rowCount = 10;
		int startRow = (pageNum - 1) * rowCount;
	
		if(totalCount > 0) {		
			List<ReserveBookVo> reservationList = bookCollectionService.getReservationList(rowCount, startRow, category, search);
			model.addAttribute("reservationList", reservationList);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		model.addAttribute("searchCount", searchCount);
	}

	@GetMapping("/book/ercStatus")
	public void ercPage() {
			
	}
	
	@GetMapping("/book/overdueStatus")
	public @ResponseBody Object overdueStatus(@RequestParam(defaultValue = "1") int pageNum,
											  @RequestParam(defaultValue = "") String category,
											  @RequestParam(defaultValue = "") String search,
											  HttpSession session, Model model) {
		
		int overdueCount = adminService.getOverdueCnt(); //cnt == count
		int totalCount = adminService.getOdSearchCnt(category, search); //od == overdue
		int rowCount = 3;
		int startRow = (pageNum - 1) * rowCount;
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(totalCount > 0) {	
			List<LoanBookVo> overdueList = adminService.getOverdueList(rowCount, startRow, category, search);
			result.put("overdueList", overdueList);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		
		result.put("pageDto", pageDto);
		result.put("pageNum", pageNum);
		result.put("overdueCount", overdueCount);
	
		return result;
	} //overdueStatus()
	
	@GetMapping("/book/overdueRecord")
	public @ResponseBody Object overdueRecord(@RequestParam(defaultValue = "1") int pageNum,
											  @RequestParam(defaultValue = "") String category,
											  @RequestParam(defaultValue = "") String search,
											  HttpSession session, Model model) {
		
		int odRecordCnt = adminService.getOverdueRecordCnt(); //cnt == count
		int totalCount = adminService.getOdRecordSearchCnt(category, search); //od == overdue
		int rowCount = 5;
		int startRow = (pageNum - 1) * rowCount;
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(totalCount > 0) {	
			List<OverdueVo> overdueRecord = adminService.getOverdueRecord(rowCount, startRow, category, search);
			result.put("overdueRecord", overdueRecord);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		
		result.put("pageDto", pageDto);
		result.put("pageNum", pageNum);
		result.put("odRecordCnt", odRecordCnt);
	
		return result;
	} //overdueRecord()
	
	@GetMapping("/book/lossStatus")
	public @ResponseBody Object lossStatus(@RequestParam(defaultValue = "1") int pageNum,
										   @RequestParam(defaultValue = "") String category,
										   @RequestParam(defaultValue = "") String search,
										   HttpSession session, Model model) {
		
		int lossCount = adminService.getLossCnt(); //cnt == count
		int totalCount = adminService.getLossSearchCnt(category, search); //od == overdue
		int rowCount = 3;
		int startRow = (pageNum - 1) * rowCount;
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(totalCount > 0) {	
			List<LoanBookVo> lossList = adminService.getLossList(rowCount, startRow, category, search);
			List<Object> lossDateList = new ArrayList<>();
			int i = 0;
			
			for(LoanBookVo loanBookVo : lossList) {
				
				String bookNum = loanBookVo.getBookNum();
				String lossDate = adminService.getLossDateByBookNum(bookNum);
				lossDateList.add(i, lossDate);
				i++;
			} //for()
			
			result.put("lossList", lossList);
			result.put("lossDateList", lossDateList);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		
		result.put("pageDto", pageDto);
		result.put("pageNum", pageNum);
		result.put("lossCount", lossCount);
	
		return result;
	} //lossStatus()
	
	@GetMapping("/book/lossRecord")
	public @ResponseBody Object lossRecord(@RequestParam(defaultValue = "1") int pageNum,
										   @RequestParam(defaultValue = "") String category,
										   @RequestParam(defaultValue = "") String search,
										   HttpSession session, Model model) {
		
		int lossRecordCnt = adminService.getLossRecordCnt(); //cnt == count
		int totalCount = adminService.getLossRecordSearchCnt(category, search); 
		int rowCount = 5;
		int startRow = (pageNum - 1) * rowCount;
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(totalCount > 0) {	
			List<LossRecordVo> lossRecord = adminService.getLossRecord(rowCount, startRow, category, search);
			result.put("lossRecord", lossRecord);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		
		result.put("pageDto", pageDto);
		result.put("pageNum", pageNum);
		result.put("lossRecordCnt", lossRecordCnt);
	
		return result;
	} //lossRecord()
	
	@PutMapping("/book/register/loss")
	public @ResponseBody void registerForLoss(@RequestParam("num") int num) {
		
		LoanBookVo loanBookVo = bookCollectionService.getLoanBook(num);
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		String lossDate = now.format(formatter);
		loanBookVo.setLoanDate(lossDate);
		
		//분실처리
		adminService.registerForLoss(num);
		//분실기록
		adminService.insertLostRecord(loanBookVo);
	} //registerForLoss()
	
	@GetMapping("/book/hopeList")
	public String hopeList(@RequestParam(defaultValue = "1") int pageNum,
						   @RequestParam(defaultValue = "") String category,
						   @RequestParam(defaultValue = "") String search,
						   @RequestParam(defaultValue = "") String status,
						   HttpSession session, Model model) {
		
		int totalCount = adminService.getHopeCount();
		int searchCount = adminService.getHopeSearchCnt(category, search, status); //cnt == count
		int rowCount = 7;
		int startRow = (pageNum - 1) * rowCount;
		
		if(totalCount > 0) {
			List<ApplyBookVo> hopeList = adminService.getHopeList(rowCount, startRow, category, search, status);
			model.addAttribute("hopeList", hopeList);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		model.addAttribute("status", status);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchCount", searchCount);
	
		
		return "/adminPage/book/hopeList";
	} //
	
	@PostMapping("/book/hopeList/changeStatus")
	public @ResponseBody void changeStatus(@RequestParam("num") int num, 
										   @RequestParam("status") String status){
		
		adminService.changeStatus(num,status);
		
	} //changeStatus()
	
	@PostMapping("/book/hopeList/changeStatus/checked")
	public @ResponseBody void changeCheckedStatus(@RequestParam("num[]") ArrayList<Integer> numList, 
										          @RequestParam("status") String status){
		
		for(int num : numList) {
			adminService.changeStatus(num,status);
		}
	} //changeStatus()

	@GetMapping("/book/record")
	public void bookRecord() {

	}
	
	@GetMapping("/board/notice")
	public void noticeList(@RequestParam(defaultValue = "1") int pageNum,
						    @RequestParam(defaultValue = "") String category,
						    @RequestParam(defaultValue = "") String search,
						    HttpSession session, Model model) {
		
		int noticeCount = noticeService.getNoticeCount();
		int totalCount = noticeService.getTotalCount(category, search);
		int rowCount = 7;
		int startRow = (pageNum - 1) * rowCount;
		
		if(totalCount > 0) {
			List<NoticeVo> noticeList = noticeService.getNoticeList(startRow, rowCount, category, search);
			model.addAttribute("noticeList", noticeList);
		} //if()
		
		int pageCount = totalCount / rowCount;
		
		if(totalCount % rowCount > 0) {			
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
		model.addAttribute("noticeCount", noticeCount);	
	} //noticeList()
	
	@GetMapping("/board/writeNotice")
	public void writeNotice() {
		
	}
	
	@GetMapping("/board/manageNotice")
	public void manageNotice(@RequestParam("num") int num, HttpSession session, Model model) {
		
		NoticeVo noticeVo = noticeService.getNoticeAndFilesByNum(num);	
		List<UploadFileVo> fileList = noticeVo.getAttachments();
		
		String content = "";

		if (noticeVo.getContent() != null) {
			content = noticeVo.getContent().replace("\r\n", "<br>");
			noticeVo.setContent(content);
		}
		
		model.addAttribute("notice", noticeVo);
		model.addAttribute("fileList", fileList);
	} //manageNotice()
	
	@GetMapping("/board/editNotice")
	public void editNotice(@RequestParam("num") int num, HttpSession session, Model model) {
		
		NoticeVo noticeVo = noticeService.getNoticeAndThumbnailByNum(num);
		UploadFileVo thumbnail = noticeVo.getThumbnail();

		if (thumbnail != null) {

			model.addAttribute("thumbnail", thumbnail);
		}

		NoticeVo fileVo = noticeService.getNoticeAndFilesByNum(num);
		List<UploadFileVo> attachments = fileVo.getAttachments();

		model.addAttribute("notice", noticeVo);
		model.addAttribute("attachments", attachments);
		
	} //editNotice()
	
	
	@DeleteMapping("/board/delete/notice")
	public @ResponseBody void deleteNotice(@RequestParam("num[]") ArrayList<Integer> numList) {
		
		for(int num: numList) {
			noticeService.deleteNotice(num);
		}
	} //deleteNotice()

	@GetMapping("/board/inquiry")
	public void inquiryBoard(@RequestParam(defaultValue = "1") int pageNum, 
				  	 	     @RequestParam(defaultValue = "") String category, 
				  	 	     @RequestParam(defaultValue = "") String search,
				  	 	     @RequestParam(defaultValue = "") String status, 
				  	 	     Model model, HttpSession session) {
		
		int inquiryCnt = inquiryService.getInquiryCnt(); //cnt == count
		int totalCount = adminService.getInquirySearchCnt(category, search, status);
		int rowCount = 7;
		int startRow = (pageNum - 1) * rowCount;
		
		if (totalCount > 0) {	
			List<InquiryVo> inquiryList = adminService.getInquiryList(rowCount, startRow, category, search, status);	
			model.addAttribute("inquiryList", inquiryList);

		}	
		
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
		model.addAttribute("status", status);
		model.addAttribute("inquiryCount", inquiryCnt);

	} //inquiryBoard()
	
	@GetMapping("/board/manageInquiry")
	public void manageInquiry(@RequestParam("num") int num, HttpSession session, Model model) {
		
		InquiryVo inquiryVo = inquiryService.getInquiryByNum(num);	
		String content = "";

		if (inquiryVo.getContent() != null) {

			content = inquiryVo.getContent().replace("\r\n", "<br>");
			inquiryVo.setContent(content);
		}
		
		model.addAttribute("inquiry", inquiryVo);
	} //manageNotice()
	
	@GetMapping("/board/editInquiry")
	public void editInquiry(@RequestParam("num") int num, HttpSession session, Model model) {
		
		InquiryVo inquiryVo = inquiryService.getInquiryByNum(num);
		String content = "";

		if (inquiryVo.getContent() != null) {

			content = inquiryVo.getContent().replace("\r\n", "<br>");
			inquiryVo.setContent(content);
		}
		
		model.addAttribute("inquiry", inquiryVo);
	} //manageNotice()
	
	@PutMapping("/board/editInquiry")
	public String editInquiry(@RequestParam("num") int num, InquiryVo inquiryVo) {
		
		String secret = inquiryVo.getSecret();
		
		if(secret == null) {		
			inquiryVo.setSecret("일반글");
		}
		
		inquiryService.updateInquiry(inquiryVo);
		
		return "redirect:/adminPage/board/manageInquiry?num=" + num;		
	} //editInquiry()
	
	@DeleteMapping("/board/delete/inquiry")
	public @ResponseBody void deleteInquiry(@RequestParam("num[]") ArrayList<Integer> numList) {
		
		for(int num: numList) {
			inquiryService.deleteInquiry(num);
		}
	} //deleteInquiry()
	
	@GetMapping("/board/comment")
	public void manageComment(@RequestParam("bno") Integer bno,
							  @RequestParam(defaultValue = "1") int pageNum, Model model) {
		
		int rowCount = 5;
		
		CommentBlock block = new CommentBlock(pageNum, rowCount);
		CommentDto commentDto = commentService.getListWithPasing(bno, block);
		int commentCnt = commentDto.getCommentCnt();
		InquiryVo inquiry = inquiryService.getInquiryByNum(bno);
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
		

		
		int pageCount = commentCnt / rowCount;

		if (commentCnt % rowCount > 0) {
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

		pageDto.setTotalCount(commentCnt);
		pageDto.setRowCount(rowCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		
		model.addAttribute("commentDto", commentDto);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("parentList", parentList);
		model.addAttribute("inquiry", inquiry);
		model.addAttribute("pageNum", pageNum);
	} //manageComment()
	
	private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { //정상 호출
                return readBody(con.getInputStream());
            } else { //에러 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    } //get()

    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    } //connect()

    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }
            
            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    } //readyBody()

}