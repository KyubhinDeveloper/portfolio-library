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
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.service.AdminService;
import com.library.service.BookCollectionService;
import com.library.service.MemberService;
import com.library.service.MyLibraryService;
import com.library.vo.BookDto;
import com.library.vo.BookmarkVo;
import com.library.vo.LoanBookVo;
import com.library.vo.PageDto;
import com.library.vo.ReserveBookVo;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/bookCollection/*")
public class BookCollectionController {
	
	@Autowired
	BookCollectionService bookCollectionService;
	
	@Autowired
	MyLibraryService myLibraryService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;
	
	@GetMapping("/searchBook")
	public String searchBook(@RequestParam(defaultValue = "1") int pageNum,
						   	 @RequestParam(defaultValue = "10") int rowCount,
						     @RequestParam(defaultValue = "") String search,
						     Model model, HttpSession session) throws ParseException {
		
		
		if(!search.equals("")) {
			
			log.info("pageNum: " + pageNum);
			String clientId = "V13D110SmuPrLT7qX_te";
			String clientSecret = "3FiEveNOE4";
			String text = null;
			int startRow;
			
			try { 
				text = URLEncoder.encode(search , "UTF-8"); 
			} catch (UnsupportedEncodingException e){
				throw new RuntimeException("검색어 인코딩 실패", e);
			}
					
			if(pageNum == 1) {
				startRow = 1;
			} else {
				startRow = (pageNum - 1) * rowCount + 1;
				log.info("startRow: " + startRow);
			}
			
			String apiURL = "https://openapi.naver.com/v1/search/book.json?query='"+text+"'&start="+startRow+"&display="+rowCount;
			
			Map<String,String> requestHeaders = new HashMap<>();
			requestHeaders.put("X-Naver-Client-Id", clientId);
			requestHeaders.put("X-Naver-Client-Secret", clientSecret);

			String responseBody = get(apiURL, requestHeaders);
			
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject)parser.parse(responseBody);	
			
			//검색 결과 개수
			Object total = obj.get("total");
			String strTotal = String.valueOf(total);
			int totalCount = Integer.parseInt(strTotal);
			log.info("totalCount: " + totalCount);
			
			
			if(totalCount > 0) {
			
				JSONArray item = (JSONArray)obj.get("items");
				
				List<BookDto> bookList = new ArrayList<BookDto>();
				List<Boolean> stopList = new ArrayList<Boolean>();
				
				for (int i = 0; i < item.size(); i ++) {
					
					BookDto book = new BookDto();
					JSONObject tmp = (JSONObject)item.get(i);
				
					String title = (String)tmp.get("title");
					String image = (String)tmp.get("image");
					String author = (String)tmp.get("author");
					String publisher = (String)tmp.get("publisher");
					String pubdate = (String)tmp.get("pubdate");
					String isbn = (String)tmp.get("isbn");
					String description = (String)tmp.get("description");
					book.setTitle(title);
					book.setImage(image);
					book.setAuthor(author);
					book.setPublisher(publisher);
					book.setPubdate(pubdate);
					book.setIsbn(isbn);
					book.setDescription(description);
					
					if(book != null) {
						
						bookList.add(book);
						log.info("book: " + book);
					}
					
					Boolean check = bookCollectionService.checkStop("", isbn.substring(isbn.length()-13, isbn.length()));
					
					stopList.add(check);
				}//for()
				
				model.addAttribute("stopCheck", stopList);
				model.addAttribute("bookList", bookList);
				
				log.info("addBookList()");
			}//if()
			
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
			pageDto.setSearch(search);
			pageDto.setTotalCount(totalCount);
			pageDto.setRowCount(rowCount);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
			
			model.addAttribute("pageDto", pageDto);
			model.addAttribute("pageNum", pageNum);
			
			log.info("addPageDto()");
		}
			
		return "/bookCollection/searchBook";	
	} //searchBook()
	
	@GetMapping("/bookStatus/{isbn}")
	public ResponseEntity<Map<String,Object>> bookStatus(@PathVariable("isbn") String isbn) {
		
		List<LoanBookVo> loanStatus = bookCollectionService.getLoanStatus(isbn);
		List<ReserveBookVo> reserveStatus = bookCollectionService.getReserveStatus(isbn);
		
		Map<String, Object> result = new HashMap<>();
		result.put("reserveStatus", reserveStatus);
		result.put("loanStatus", loanStatus);
	
		return new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);
	} //bookStatus()
	
	@GetMapping("/popularBook")
	public String popularBook(@RequestParam(defaultValue = "20") int listCount, Model model) {		
		List<BookDto> popularBookList = bookCollectionService.getPopularBookList(listCount); 		
		model.addAttribute("popularBookList", popularBookList);
		model.addAttribute("listCount", listCount);
		
		return "/bookCollection/popularBook";		
	} //popularBook()
	
	@GetMapping("/bookDetail")
	public String bookDetail(@RequestParam("isbn") String isbnVal,
		   	 			     Model model) throws ParseException {
		
		String clientId = "V13D110SmuPrLT7qX_te";
		String clientSecret = "3FiEveNOE4";
		String text = null;
		
		try { 
			text = URLEncoder.encode(isbnVal , "UTF-8"); 
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
		String image = (String)tmp.get("image");
		String author = (String)tmp.get("author");
		String publisher = (String)tmp.get("publisher");
		String pubdate = (String)tmp.get("pubdate");
		String isbn = (String)tmp.get("isbn");
		String description = (String)tmp.get("description");
		book.setTitle(title);
		book.setImage(image);
		book.setAuthor(author);
		book.setPublisher(publisher);
		book.setPubdate(pubdate);
		book.setIsbn(isbn);
		book.setDescription(description);
		
		Boolean check = bookCollectionService.checkStop("", isbn.substring(isbn.length()-17, isbn.length()).replace("</b>",""));
		
		model.addAttribute("book", book);
		model.addAttribute("check", check);
		
		return "/bookCollection/bookDetail";
	}//bookDetail()
	
	@PostMapping("/loanBook")
	public @ResponseBody ResponseEntity<String> loanBook(@RequestBody LoanBookVo loanBookVo , HttpSession session) {
		
		String id = (String)session.getAttribute("id");
		
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
						
			String name = memberService.getNameById(id);
			String isbn = loanBookVo.getIsbn();
			int overdueCnt = myLibraryService.getOverdueCnt(id);
			int loanCount =  myLibraryService.getLoanCnt(id);
			boolean reserveCheck = bookCollectionService.rvDuplication(isbn, id);
			String grade = memberService.getGradeById(id);
			String str = "";
			
			if(overdueCnt > 0) {
				str = "연체 도서가 있는 경우 대출할 수 없습니다.";
			} else if(reserveCheck) {
				str = "예약 중인 도서는 대출할 수 없습니다.";
			} else {
				
				if(grade == "vip") {
					
					if(loanCount < 10) {
						
						String bookNum = loanBookVo.getBookNum();
						
						boolean loanStatus = bookCollectionService.loanStatus(bookNum);
						boolean loanDuplication = bookCollectionService.loanDuplication(isbn, id);
						
						if(loanStatus) {
							str = "대출 중인 도서입니다. 대출 하실 수 없습니다";
						} else {
							
							if(loanDuplication) {
								str = "이미 대출 중인 도서는 중복대출 하실 수 없습니다.";
							} else {
								
								int num = bookCollectionService.getLoanNum();
							 	
								LocalDateTime now = LocalDateTime.now();
								LocalDateTime end =  now.plusDays(14);
								DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
								String loanDate = now.format(formatter);
								String endDate = end.format(formatter);
								
								loanBookVo.setId(id);
								loanBookVo.setName(name);
								loanBookVo.setNum(num);
								loanBookVo.setLoanDate(loanDate);
								loanBookVo.setEndDate(endDate);
								
								bookCollectionService.loanBook(loanBookVo);
								
								str = "대출 신청이 완료되었습니다.\n대출 도서는 당일 안으로 도서관에 찾으러 오셔야 합니다.";
							} //else()
						} //else()
					} else {
						
						str = "도서대출 가능횟수를 초과하셨습니다.";
					}	
				} else {
					
					if(loanCount < 5) {
						
						String bookNum = loanBookVo.getBookNum();
						
						boolean loanStatus = bookCollectionService.loanStatus(bookNum);
						boolean loanDuplication = bookCollectionService.loanDuplication(isbn, id);
						
						if(loanStatus) {
							str = "대출 중인 도서입니다. 대출 하실 수 없습니다";
						} else {
							
							if(loanDuplication) {
								str = "이미 대출 중인 도서는 중복대출 하실 수 없습니다.";
							} else {
								
								int num = bookCollectionService.getLoanNum();
							 	
								LocalDateTime now = LocalDateTime.now();
								LocalDateTime end =  now.plusDays(14);
								DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
								String loanDate = now.format(formatter);
								String endDate = end.format(formatter);
								
								loanBookVo.setId(id);
								loanBookVo.setName(name);
								loanBookVo.setNum(num);
								loanBookVo.setLoanDate(loanDate);
								loanBookVo.setEndDate(endDate);
								
								bookCollectionService.loanBook(loanBookVo);
								
								str = "대출 신청이 완료되었습니다.\n대출 도서는 당일 안으로 도서관에 찾으러 오셔야 합니다.";
							} //else
						} //else
					} else {
						
						str = "대출 가능 횟수를 초과하셨습니다.";
					}	
				} //else
			} //else	
			
			return new ResponseEntity<String>(str, headers, HttpStatus.OK);
		} // else
	} //loanBook()
	
	@PutMapping("/updateLoanDate")
	public @ResponseBody void updateLoanDate(@RequestBody LoanBookVo loanBookVo) {
		
		bookCollectionService.updateLoanDate(loanBookVo);
		
	} //updateLoan()
	
	@DeleteMapping("/cancelLoan/{bookNum}")
	public @ResponseBody Object cancelLoan(@PathVariable("bookNum") String bookNum,  HttpSession session) {
		
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
			
			//대출도서 예약자수
			int reserverCnt = bookCollectionService.getReservationCount(bookNum); //cnt == count
			String str = "대출신청이 취소되었습니다.";
			
			if(reserverCnt > 0) {
				if(reserverCnt >= 1) {
					
					LoanBookVo loanBookVo = bookCollectionService.getLoanBookByBookNum(bookNum);	
					//반납기록 번호 가져오기
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
			
			return new ResponseEntity<String>(str, headers, HttpStatus.OK);
		} //else
	} //cancelLoan()
	
	@PostMapping("/reserveBook")
	public @ResponseBody String reserveBook(@RequestBody ReserveBookVo reserveBookVo) {
		
		String id  = reserveBookVo.getId();
		String bookNum = reserveBookVo.getBookNum();
		String isbn = reserveBookVo.getIsbn();
		
		int count = bookCollectionService.getReservationCount(bookNum);
		int overdueCnt = myLibraryService.getOverdueCnt(id);
		boolean rvDuplication = bookCollectionService.rvDuplication(isbn, id); //rvDuplication == reservationDuplication
		boolean loanDuplication = bookCollectionService.loanDuplication(isbn, id);
		String str;
		
		if(count == 3) {
			str = "예약 횟수를 초과한 도서로 예약할 수 없습니다.";
		} else if(overdueCnt > 0) {
			str = "연체 도서가 있는 경우 예약할 수 없습니다.";
		} else {
			
			if(rvDuplication) {
				str = "이미 예약 중인 도서는 중복 예약할 수 없습니다.";
			} else if(loanDuplication) {
				str = "이미 대출 중인 도서는 예약할 수 없습니다.";
			} else {
				
				int num = bookCollectionService.getReserveNum();
				int turn = bookCollectionService.getNewTurn(bookNum);
				String name = memberService.getNameById(id);
				String reserveDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));

				reserveBookVo.setNum(num);
				reserveBookVo.setName(name);
				reserveBookVo.setTurn(turn);
				reserveBookVo.setReserveDate(reserveDate);
			
				bookCollectionService.reserveBook(reserveBookVo);
				
				if(turn == 1) {		
					LoanBookVo loanBookVo = bookCollectionService.getLoanBookByBookNum(bookNum);
					int loanNum = loanBookVo.getNum();
					int extension = loanBookVo.getExtension();
					
					if(extension == 0) {
						//대출연장 불능처리
						bookCollectionService.updateLoanExtension(loanNum, 2);
					}

					//대출도서 예약 알림발송
					adminService.sendingNotice(loanBookVo,4); 
				}
				
				str = "도서예약이 완료되었습니다.\n대출가능 여부는 알림으로 알려드립니다.";				
			}
		}
		return str;
	} //reserveBook()
	
	@DeleteMapping("/cancelReservation/{bookNum}/{id}")
	public @ResponseBody Object cancelReservation(@PathVariable("bookNum") String bookNum, 
												  @PathVariable("id") String reserverId, HttpSession session) {
		
		String id = (String)session.getAttribute("id");
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
			
			String str = "예약신청이 취소되었습니다.";
			//대출도서 예약자수
			int reserverCnt = bookCollectionService.getReservationCount(bookNum); //cnt == count
			int turn = bookCollectionService.getReservationTurn(reserverId, bookNum);
			
			//도서예약 취소
			bookCollectionService.cancelReservationById(bookNum, reserverId);
			
			if(turn == 1) {
				LoanBookVo loanBookVo = bookCollectionService.getLoanBookByBookNum(bookNum);
				int loanNum = loanBookVo.getNum();
				int extension = loanBookVo.getExtension();
				
				if(extension == 2) {
					//대출연장 가능처리
					bookCollectionService.updateLoanExtension(loanNum, 0);
				}
			}
			
			if(reserverCnt > 1) {
				//예약순서 당기기
				bookCollectionService.updateReservation(bookNum);
			}

			return new ResponseEntity<String>(str, headers, HttpStatus.OK);
		}
	} //cancelReserve()
		
	@PostMapping("/stopUsing")
	public @ResponseBody boolean stopUsing(@RequestParam(defaultValue = "") String bookNum,
										   @RequestParam(defaultValue = "") String isbn){
		
		int num = bookCollectionService.getStopNum();
		
		boolean check = bookCollectionService.checkStop(bookNum, isbn);
		
		if(check) {
			check = false;
		} else {
			
			BookDto bookDto = new BookDto();
			
			bookDto.setNum(num);
			bookDto.setBookNum(bookNum);
			bookDto.setIsbn(isbn);
			
			bookCollectionService.stopUsing(bookDto);
			bookCollectionService.cancelReservations(bookNum,isbn);
			check = true;
		}
		
		return check;
	} //stopUsing()
	
	@GetMapping("/checkStop")
	public @ResponseBody boolean checkStop(@RequestParam(defaultValue = "") String bookNum,
			 							   @RequestParam(defaultValue = "") String isbn) {
		
		boolean check = bookCollectionService.checkStop(bookNum, isbn);
		
		return check;
	} //checkStop()
	
	@DeleteMapping("/recoveryBook")
	public @ResponseBody void recoveryBook(@RequestParam(defaultValue = "") String bookNum,
			   							   @RequestParam(defaultValue = "") String isbn) {
		
		bookCollectionService.recoveryBook(bookNum,isbn);
	} //recoveryBook()
	
	@PostMapping("/bookmark")
	public @ResponseBody void bookmark(@RequestBody BookmarkVo bookmarkVo, HttpSession session) {
		
		String id = (String)session.getAttribute("id");	
		String isbn = bookmarkVo.getIsbn();
		int num = bookCollectionService.getBookmarkNum();
		
		boolean check = bookCollectionService.bookmarkDup(isbn, id); //BookmarkDuplication()
		
		if(check == false) {
		
			bookmarkVo.setNum(num);
			bookmarkVo.setId(id);
			bookCollectionService.insertBookmark(bookmarkVo);
		} 
	} //bookmark()
	
	@PostMapping("/bookmarkList")
	public @ResponseBody void bookmarkList(@RequestParam("isbnList[]") ArrayList<String> isbnList, HttpSession session) throws ParseException {
		
		String id = (String)session.getAttribute("id");

		if(isbnList.size() > 0) {
			
			for (String isbn : isbnList) {
				
				boolean check = bookCollectionService.bookmarkDup(isbn, id); //BookmarkDuplication()
				
				if(check == false) {
					
					BookmarkVo bookmarkVo = new BookmarkVo();
					
					String clientId = "V13D110SmuPrLT7qX_te";
					String clientSecret = "3FiEveNOE4";
					
					String apiURL = "https://openapi.naver.com/v1/search/book.json?query='"+isbn;
					
					Map<String,String> requestHeaders = new HashMap<>();
					requestHeaders.put("X-Naver-Client-Id", clientId);
					requestHeaders.put("X-Naver-Client-Secret", clientSecret);

					String responseBody = get(apiURL, requestHeaders);
					
					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject)parser.parse(responseBody);	
					
					JSONArray item = (JSONArray)obj.get("items");
					
					JSONObject tmp = (JSONObject)item.get(0);
					
					int num = bookCollectionService.getBookmarkNum();
					String title = (String)tmp.get("title");
					String author = (String)tmp.get("author");
					String publisher = (String)tmp.get("publisher");
					String pubdate = (String)tmp.get("pubdate");
					
					bookmarkVo.setNum(num);
					bookmarkVo.setId(id);
					bookmarkVo.setTitle(title);
					bookmarkVo.setAuthor(author);
					bookmarkVo.setPublisher(publisher);
					bookmarkVo.setPubdate(pubdate);
					bookmarkVo.setIsbn(isbn);
					
					bookCollectionService.insertBookmark(bookmarkVo);
				} // if()	
			} // for()
		} //if()
	} //bookmarkList()
	
	@DeleteMapping("/deleteBookmark")
	public @ResponseBody void deleteBookmark(@RequestParam("isbn") String isbn, HttpSession session) {
		
		String id = (String)session.getAttribute("id");	
		
		bookCollectionService.deleteBookmark(id,isbn);
	} //deleteBookmark()

	
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