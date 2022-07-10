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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.service.MemberService;
import com.library.service.MyLibraryService;
import com.library.vo.ApplyBookVo;
import com.library.vo.BookDto;
import com.library.vo.BookmarkVo;
import com.library.vo.LoanBookVo;
import com.library.vo.LoanRecordVo;
import com.library.vo.LossRecordVo;
import com.library.vo.MemberVo;
import com.library.vo.OverdueVo;
import com.library.vo.PageDto;
import com.library.vo.PersonalNoticeVo;
import com.library.vo.ReserveBookVo;

import lombok.extern.java.Log;



@Log
@Controller
@RequestMapping("/myLibrary/*")
public class MyLibraryController {

	@Autowired
	private MyLibraryService myLibraryService;

	@Autowired
	private MemberService memberService;

	@GetMapping("/myLibrary")
	public void myLibrary() {
		
	} //myLibrary()

	@GetMapping("/applyPage")
	public void applyPage() {

	}

	@PostMapping("/applyBook")
	public ResponseEntity<String> applyBook(ApplyBookVo applyBookVo, HttpSession session) {

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
			
			int price = applyBookVo.getPrice();	
			int myPrice = myLibraryService.getMyPrice(id);
			int totalPrice = (price + myPrice);
			String grade = memberService.getGradeById(id);

			if (grade.equals("normal") && totalPrice >= 400000) {

				sb.append("<script>");
				sb.append("alert('희망도서 신청 상한금액을 초과해서 신청하실 수 없습니다.');");
				sb.append("location.href = '/myLibrary/applyPage';");
				sb.append("</script>");

			} else if (grade.equals("vip") && totalPrice >= 600000) {

				sb.append("<script>");
				sb.append("alert('희망도서 신청 상한금액을 초과해서 신청하실 수 없습니다.');");
				sb.append("location.href = '/myLibrary/applyPage';");
				sb.append("</script>");

			} else {
				
				String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
				applyBookVo.setId(id);
				applyBookVo.setApplyDate(date);
				
				myLibraryService.applyBook(applyBookVo);
				
				sb.append("<script>");
				sb.append("location.href = '/myLibrary/applyPage';");
				sb.append("alert('희망도서 신청이 완료되었습니다.');");
				sb.append("</script>");
			}
		}
		
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
	}

	@GetMapping("/bookmark")
	public String bookmark(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		int totalCount = myLibraryService.getBookmarkCnt(id); //cnt == count
		
		model.addAttribute("totalCount", totalCount);
		
		if(totalCount> 0) {
			
			List<BookmarkVo> bookmarkList = myLibraryService.getBookmarkList(id);
			model.addAttribute("bookmarkList", bookmarkList);
		}
	
		return "/myLibrary/bookmark";
	} //bookmark()

	@GetMapping("/changeInfo")
	public String changeInfo(HttpSession session, Model model) {

		String id = (String) session.getAttribute("id");
		MemberVo memberVo = memberService.getInfoById(id);
		model.addAttribute("memberVo", memberVo);

		return "/myLibrary/changeInfo";
	}

	@GetMapping("/overdueRecord")
	public String overdueRecord(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		int recordCnt = myLibraryService.overdueRecordCnt(id); //cnt == count
		int overdueCnt = myLibraryService.getOverdueCnt(id); 
		
		model.addAttribute("recordCnt", recordCnt);
		model.addAttribute("overdueCnt", overdueCnt);
		
		if(recordCnt > 0) {
			
			List<OverdueVo> overdueRecordList = myLibraryService.getOdRecordList(id); //od == overdue
			model.addAttribute("overdueRecordList", overdueRecordList);
		}
		
		if(overdueCnt > 0) {
			
			List<LoanBookVo> overdueList = myLibraryService.getOverdueList(id, 2);
			model.addAttribute("overdueList", overdueList);
		}
	
		return "/myLibrary/overdueRecord";
	}

	@GetMapping("/hopeBook")
	public String hopeBook(HttpSession session, Model model) {

		String id = (String)session.getAttribute("id");
		int totalCount = myLibraryService.getApplicationCnt(id); //cnt == count
		
		model.addAttribute("totalCount", totalCount);
		
		if(totalCount > 0) {	
			List<ApplyBookVo> wishList = myLibraryService.getApplicationList(id);
			model.addAttribute("wishList", wishList);
		}
	
		return "/myLibrary/hopeBook";
	} // hopeBook()

	@GetMapping("/loanBook")
	public String loanBook(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		int totalCount = myLibraryService.getLoanCnt(id); //cnt == count
		int overdueCnt = myLibraryService.getOverdueCnt(id);
		int lossCnt = myLibraryService.getLossCnt(id);
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("overdueCnt", overdueCnt);
		model.addAttribute("lossCnt", lossCnt);
		
		if(totalCount > 0) {
			
			List<LoanBookVo> loanBookList = myLibraryService.getLoanBookList(id);
			List<Object> reserveCntList = new ArrayList<>();
			int i = 0;
			
			for(LoanBookVo loanBook : loanBookList) {
				
				String bookNum = loanBook.getBookNum();
				int count = myLibraryService.getBookedCntByBookNum(bookNum);
				reserveCntList.add(i, count);
				i++;
			} //for() 
			
			model.addAttribute("loanBookList", loanBookList);
			model.addAttribute("reserveCnt", reserveCntList);			
		} //if()
		
		return "/myLibrary/loanBook";
	} //loanBook()
	
	@DeleteMapping("/cancelApplication/{num}")
	public @ResponseBody void cancelAppliction(@PathVariable("num") int num) {
		
		myLibraryService.cancelApplication(num);
		
	} //cancelAppliction()

	@GetMapping("/loanRecord")
	public String loanRecord(@RequestParam(defaultValue = "1") int pageNum,
							 HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		int totalCount = myLibraryService.getLoanRecordCnt(id);
		
		if(totalCount > 0) {
			int rowCount = 15;
			int startRow = (pageNum - 1) * rowCount;
			List<LoanRecordVo> loanRecordList = myLibraryService.getLoanRecordList(id,startRow,rowCount);
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

			pageDto.setTotalCount(totalCount);
			pageDto.setRowCount(rowCount);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
			
			model.addAttribute("pageDto", pageDto);
			model.addAttribute("loanRecordList", loanRecordList);
			model.addAttribute("pageNum", pageNum);
		}
		
		return "/myLibrary/loanRecord";
	} //loanRecord()

	@GetMapping("/lossRecord")
	public String lossRecord(HttpSession session, Model model) {

		String id = (String)session.getAttribute("id");
		int totalCount = myLibraryService.getLossCount(id);
		
		model.addAttribute("totalCount", totalCount);
		
		if(totalCount > 0) {
			
			List<LossRecordVo> lossRecordList = myLibraryService.getLossRecordList(id);
			model.addAttribute("lossRecordList", lossRecordList);
		}
		
		return "/myLibrary/lossRecord";
	} //lossRecord()

	@GetMapping("/personalNotice")
	public void personalNotice(@RequestParam(defaultValue = "1") int pageNum,
			 				   HttpSession session, Model model) {
			
		String id = (String) session.getAttribute("id");
		int totalCount = myLibraryService.getNoticeCnt(id); //cnt == count
		
		if(totalCount > 0) {
			
			int rowCount = 10;
			int startRow = (pageNum - 1) * rowCount;
			List<PersonalNoticeVo> noticeList = myLibraryService.getNoticeList(id,startRow,rowCount);
			int pageCount = totalCount / rowCount;
			if (totalCount % rowCount > 0) {
				pageCount += 1;
			}

			// 페이지 블록에 보여줄 최대 갯수
			int pageBlock = 9;

			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;

			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {

				endPage = pageCount;
			}

			PageDto pageDto = new PageDto();

			pageDto.setTotalCount(totalCount);
			pageDto.setRowCount(rowCount);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
						
			model.addAttribute("pageDto", pageDto);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("noticeList", noticeList);
		} //if()
	} //personalNotice()
	
	@GetMapping("/noticeContent")
	public String noticeContent(@RequestParam("num") int num,
							  HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		
		if(id == null) {
			
			return "/member/login";
			
		} else {
			
			LocalDateTime dateTime = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String date = dateTime.format(formatter);
			String name = memberService.getNameById(id);
			
			myLibraryService.updateReadDate(num,date);
			PersonalNoticeVo noticeVo = myLibraryService.getNoticeVo(num);
			
			
			model.addAttribute("noticeVo", noticeVo);
			model.addAttribute("name", name);
			
			return "/myLibrary/noticeContent";
		}
	} //noticeContent()

	@GetMapping("/reservationBook")
	public void reservationBook(HttpSession session, Model model) throws ParseException {
		
		String id = (String) session.getAttribute("id");
		int totalCount = myLibraryService.getBookedCntById(id); //cnt == count
		
		model.addAttribute("totalCount", totalCount);
		
		if(totalCount > 0) {
			
			String clientId = "V13D110SmuPrLT7qX_te";
			String clientSecret = "3FiEveNOE4";
			String text = null;

			List<ReserveBookVo> list = myLibraryService.getReserveList(id);
			List<BookDto> reserveList = new ArrayList<BookDto>();
			List<Object> dateList = new ArrayList<>();
			int i = 0;
			
			for(ReserveBookVo reserveBook : list) {
				
				String isbn =  reserveBook.getIsbn();
				String bookNum = reserveBook.getBookNum();
				String reserveDate = reserveBook.getReserveDate();
				
				dateList.add(i , reserveDate);
				i++;
				
				try { 
					text = URLEncoder.encode(isbn , "UTF-8"); 
				} catch (UnsupportedEncodingException e){
					throw new RuntimeException("검색어 인코딩 실패", e);
				}
								
				String apiURL = "https://openapi.naver.com/v1/search/book.json?query="+text;
				
				Map<String,String> requestHeaders = new HashMap<>();
				requestHeaders.put("X-Naver-Client-Id", clientId);
				requestHeaders.put("X-Naver-Client-Secret", clientSecret);

				String responseBody = get(apiURL, requestHeaders);
				
				JSONParser parser = new JSONParser();
				JSONObject obj = (JSONObject)parser.parse(responseBody);	
				
				JSONArray item = (JSONArray)obj.get("items");
				
				BookDto book = new BookDto();
				JSONObject tmp = (JSONObject)item.get(0);
			
				String title = (String)tmp.get("title");
				String author = (String)tmp.get("author");
				String publisher = (String)tmp.get("publisher");
				String pubdate = (String)tmp.get("pubdate");
				book.setBookNum(bookNum);
				book.setTitle(title);
				book.setAuthor(author);
				book.setPublisher(publisher);
				book.setPubdate(pubdate);
				book.setIsbn(isbn);
				
				if(book != null) {
					
					reserveList.add(book);
				}
				
			} //for()
			
			model.addAttribute("reserveDate", dateList);
			model.addAttribute("reserveList", reserveList);
		}
	} //reservationBook()
	
	
	
	
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