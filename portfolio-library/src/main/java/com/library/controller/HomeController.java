package com.library.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.library.service.AdminService;
import com.library.service.BookCollectionService;
import com.library.service.MyLibraryService;
import com.library.service.NoticeService;
import com.library.vo.BookDto;
import com.library.vo.NoticeVo;
import com.library.vo.UploadFileVo;

import lombok.extern.java.Log;

@Log
@Controller
public class HomeController {

	@Autowired
	MyLibraryService myLibraryService;
	
	@Autowired
	BookCollectionService bookCollectionService;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	AdminService adminService;

	@GetMapping("/")
	public String index(HttpSession session, Model model) throws ParseException {

		String id = (String) session.getAttribute("id");
		int listCount = 6;

		if (id != null) {
			if (id.equals("admin")) {

				log.info("관리자");
				int totalLoanCount = bookCollectionService.getLoanCount();
				int reservationCnt = bookCollectionService.getReservationCnt(); // cnt == count
				int totalOverdueCnt = adminService.getOverdueCnt();
				int totalLatefee = adminService.getTotalLatefee();
				int totalWishCnt = adminService.getHopeCount();

				model.addAttribute("totalLoanCount", totalLoanCount);
				model.addAttribute("reservationCnt", reservationCnt);
				model.addAttribute("totalOverdueCnt", totalOverdueCnt);
				model.addAttribute("totalLatefee", totalLatefee);
				model.addAttribute("totalWishCnt", totalWishCnt);

			} else {

				int loanCount = myLibraryService.getLoanCnt(id);
				int overdueCnt = myLibraryService.getOverdueCnt(id); // cnt == count
				int reservationCnt = myLibraryService.getBookedCntById(id);
				int myNoticeCnt = myLibraryService.getMyNoticeCnt(id);
				int wishCount = myLibraryService.getApplicationCnt(id);
				int latefee;

				if (loanCount > 0) {
					latefee = myLibraryService.getLatefee(id);
				} else {
					latefee = 0;
				}

				model.addAttribute("loanCount", loanCount);
				model.addAttribute("overdueCnt", overdueCnt);
				model.addAttribute("reservationCnt", reservationCnt);
				model.addAttribute("latefee", latefee);
				model.addAttribute("wishCount", wishCount);
				model.addAttribute("wishCount", myNoticeCnt);
			} // else
		} // if()

		List<BookDto> popularBookList = bookCollectionService.getPopularBookList(listCount);
		List<NoticeVo> noticeList = noticeService.getNoticeList(0, 5, "", "");
		List<Object> timeList = new ArrayList<>();
		int i = 0;
		Long time;

		for (NoticeVo noticeVo : noticeList) {
			time = this.timeGap(i, noticeVo);
			timeList.add(i, time);
			i++;
		} // for()

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("popularBookList", popularBookList);
		model.addAttribute("timeList", timeList);

		return "/index";
	} //index()
	
	@GetMapping("/messageWindow")
	public void messageWindow() {
	}
	
	private Long timeGap(int i, NoticeVo noticeVo) throws ParseException {

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

		String currentTime = this.currentTime();
		String writeTime = noticeVo.getRegDate();

		Date writeDate = dateFormat.parse(writeTime);
		Date currentDate = dateFormat.parse(currentTime);

		long time = (currentDate.getTime() - writeDate.getTime()) / 60000;

		return time;
	} // timeGap()
	
	private String currentTime() {

		LocalDateTime dateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String date = dateTime.format(formatter);

		return date;
	} // currentTime()
}