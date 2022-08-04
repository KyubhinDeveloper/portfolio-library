package com.library.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.library.service.NoticeService;
import com.library.service.UploadFileService;
import com.library.vo.NoticeVo;
import com.library.vo.PageDto;
import com.library.vo.UploadFileVo;

import lombok.extern.java.Log;
import net.coobird.thumbnailator.Thumbnailator;

@Log
@Controller
@RequestMapping("/community/*")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	@Autowired
	private UploadFileService uploadFileService;

	@GetMapping("/noticeForum")
	public String noticeForum(@RequestParam(defaultValue = "1") int pageNum, // pagination 번호
							  @RequestParam(defaultValue = "") String category, // 게시판 검색 카테고리
							  @RequestParam(defaultValue = "") String search, // 게시판 검색어
							  Model model, HttpSession session) throws ParseException {
		
		// 게시글 총 갯수
		int totalCount = noticeService.getTotalCount(category, search);
		// 한 화면에 보여줄 갯수
		int rowCount = 10;
		// 첫 글 번호
		int startRow = (pageNum - 1) * rowCount;

		if (totalCount > 0) {
			Long time;
			List<NoticeVo> noticeList = noticeService.getNoticeList(startRow, rowCount, category, search);
			List<Object> timeList = new ArrayList<>();
			List<UploadFileVo> thumbnailList = new ArrayList<UploadFileVo>();
			int i = 0;

			for (NoticeVo noticeVo : noticeList) {				
				// 게시글 작성 시간과 현재 시간 차이 리스트에 담기
				time = this.timeGap(i, noticeVo);
				timeList.add(i, time);
				UploadFileVo thumbnail = noticeVo.getThumbnail();
				
				// 썸네일 여부에 따라 리스트에 추가
				if (thumbnail != null) {
					thumbnailList.add(i, thumbnail);
					i++;
				} else {
					thumbnailList.add(i, null);
					i++;
				}
			} //for()

			int pageCount = totalCount / rowCount;
			if (totalCount % rowCount > 0) {
				pageCount += 1;
			}

			// 페이지 블록에 보여줄 최대 갯수
			int pageBlock = 10;
			// pagination 첫 번호
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
			// pagination 마지막 번호
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

			model.addAttribute("noticeList", noticeList);
			model.addAttribute("thumbnailList", thumbnailList);
			model.addAttribute("timeList", timeList);
			model.addAttribute("pageDto", pageDto);
		} // if

		model.addAttribute("pageNum", pageNum);

		return "/community/noticeForum";
	}// noticeForum()

	@GetMapping("/noticeContent")
	public String noticeContent(@ModelAttribute("pageNum") String pageNum, 
								int num, HttpSession session, Model model) {

		String id = (String) session.getAttribute("id");
		noticeService.updateViews(num);

		NoticeVo noticeVo = noticeService.getNoticeAndFilesByNum(num);

		List<UploadFileVo> fileList = noticeVo.getAttachments();

		String content = "";

		if (noticeVo.getContent() != null) {

			content = noticeVo.getContent().replace("\r\n", "<br>");
			noticeVo.setContent(content);
		}

		model.addAttribute("id", id);
		model.addAttribute("notice", noticeVo);
		model.addAttribute("fileList", fileList);

		return "/community/noticeContent";
	} // noticeContent()

	@GetMapping("/writeNotice")
	public String writeNotice(HttpSession session, @ModelAttribute("pageNum") String pageNum) {
		
		String id = (String)session.getAttribute("id");
		
		if (id == null || !id.equals("admin")) {
			return "redirect:/member/login";
		}
		
		return "community/writeNotice";
	} //writeNotice()

	@PostMapping("/writeNotice")
	public String writeNoite(@RequestParam("thumbnailname") MultipartFile thumbnail, 
							 @RequestParam("filename") List<MultipartFile> uploadFile, 
							 HttpServletRequest request, NoticeVo noticeVo, HttpSession session) throws Exception {
		
		String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");
		
		// 작성할 게시글 번호 가져오기
		int num = noticeService.getNoticeNum();
		
		// 게시글 작성 시간
		String date = this.currentTime();
		
		noticeVo.setRegDate(date);
		noticeVo.setId(id);
		noticeVo.setName(name);
		noticeVo.setNum(num);
		
		
		if (!thumbnail.isEmpty()) {
			
			UploadFileVo thumbnailVo = new UploadFileVo();
			thumbnailVo = this.uploadThumbnail(thumbnailVo, request, thumbnail, num);
			uploadFileService.insertThumbnail(thumbnailVo);
			
		} // if()

		List<UploadFileVo> fileList = new ArrayList<>();

		if (!uploadFile.isEmpty()) {

			for (MultipartFile multipartFile : uploadFile) {

				if (multipartFile.isEmpty()) {
					continue;
				}

				UploadFileVo attachments = this.uploadFile(request, multipartFile, num);
				fileList.add(attachments);
			} // for

			uploadFileService.insertFiles(fileList);
		} // if

		noticeService.insertNotice(noticeVo);

		return "redirect:/community/noticeForum";
	} // writeNotice()

	@GetMapping("/editNotice")
	public String editNotice(@ModelAttribute("pageNum") String pageNum, 
							 int num, HttpSession session, Model model) {

		String id = (String) session.getAttribute("id");

		if (id == null || !id.equals("admin")) {

			return "/member/login";

		} else {

			NoticeVo noticeVo = noticeService.getNoticeAndThumbnailByNum(num);
			UploadFileVo thumbnail = noticeVo.getThumbnail();

			if (thumbnail != null) {

				model.addAttribute("thumbnail", thumbnail);
			}

			NoticeVo fileVo = noticeService.getNoticeAndFilesByNum(num);
			List<UploadFileVo> attachments = fileVo.getAttachments();

			model.addAttribute("notice", noticeVo);
			model.addAttribute("attachments", attachments);

			return "/community/editNotice";
		}
	} // editNotice()

	@PutMapping("/editNotice")
	public String editNotice(@RequestParam("newThumbnail") @Nullable MultipartFile uploadThumbnail, 
							 @RequestParam("deletedThumbnail") @Nullable String deletedThumbnail,
							 @RequestParam("newFile") @Nullable List<MultipartFile> uploadFile, 
							 @RequestParam("deletedFile") @Nullable List<String> deletedFile,
							 @ModelAttribute("pageNum") String pageNum, int num, NoticeVo noticeVo,
							 HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		// 삭제된 기존 썸네일 처리
		if (deletedThumbnail != null) {
			
			log.info("deletedThumbnail: " + deletedThumbnail);
			UploadFileVo oldThumbnailVo = uploadFileService.getThumbnailByNum(num);
			log.info("oldThumbnailVo: " + oldThumbnailVo);
			this.deleteThumbnail(oldThumbnailVo);

			uploadFileService.deleteThumbnailByNum(num);
		}

		// 새로운 썸네일 입력
		if (uploadThumbnail != null) {
			if (!uploadThumbnail.isEmpty()) {
				UploadFileVo thumbnailVo = new UploadFileVo();
				thumbnailVo = this.uploadThumbnail(thumbnailVo, request, uploadThumbnail, num);
				uploadFileService.insertThumbnail(thumbnailVo);
			}
		}

		// 삭제된 기존 첨부파일 처리
		if (deletedFile != null) {

			List<String> deleteFileList = new ArrayList<>();

			for (String fileUuid : deletedFile) {

				UploadFileVo deleteFileVo = uploadFileService.getFileByUuid(fileUuid);

				this.deleteFile(deleteFileVo);

				deleteFileList.add(fileUuid);
			} // for

			uploadFileService.deleteFilesByUuid(deleteFileList);
		} // if

		// 새로운 첨부파일 입력
		if (uploadFile != null) {
			
			log.info("새로운 첨부파일 업로드");
			
			List<UploadFileVo> uploadFileList = new ArrayList<>();

			for (MultipartFile multipartFile : uploadFile) {

				if (multipartFile.isEmpty()) {
					continue;
				}

				UploadFileVo fileVo = this.uploadFile(request, multipartFile, num);
				uploadFileList.add(fileVo);
			} // for
			
			log.info("uploadFileList: " + uploadFileList);

			uploadFileService.insertFiles(uploadFileList);
		}
		
		noticeService.updateNotice(noticeVo);

		return "redirect:/community/noticeContent?pageNum=" + pageNum + "&num=" + num;	
	} // editNotice()

	@DeleteMapping("/deleteNotice/{num}")
	public ResponseEntity<String> deleteNotice(@PathVariable("num") int num) {

		NoticeVo thumbnailVo = noticeService.getNoticeAndThumbnailByNum(num);

		if (thumbnailVo.getThumbnail() != null) {

			UploadFileVo thumbnail = thumbnailVo.getThumbnail();

			this.deleteThumbnail(thumbnail);

			uploadFileService.deleteThumbnailByNum(num);
		} // if
		
		NoticeVo attachMentVo = noticeService.getNoticeAndFilesByNum(num); 

		if (attachMentVo.getAttachments() != null) {

			List<UploadFileVo> deletefileList = attachMentVo.getAttachments();

			if (!deletefileList.isEmpty()) {

				for (UploadFileVo deleteFileVo : deletefileList) {

					this.deleteFile(deleteFileVo);
				}

				uploadFileService.deleteFilesByNum(num);
			}
		} // if

		noticeService.deleteNotice(num);

		String message = "공지글이 삭제되었습니다.";
		  
		return new ResponseEntity<String>(message, HttpStatus.OK);
	} // deleteNotice()

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> download(@RequestParam("uuid") String uuid) throws Exception {

		UploadFileVo downloadFileVo = uploadFileService.getFileByUuid(uuid);

		File downloadFile = new File(downloadFileVo.getPath(), downloadFileVo.getUuid() + "_" + downloadFileVo.getFilename());

		Resource resource = new FileSystemResource(downloadFile);

		if (!resource.exists()) {

			log.info("다운로드할 파일이 존재하지 않습니다.");
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}

		String resFileName = resource.getFilename();

		// 다운로드할 파일이름에서 UUID 제거하기
		int uuidIndex = resFileName.indexOf("_") + 1;
		String originalFileName = resFileName.substring(uuidIndex);

		// 다운로드 파일명의 문자셋을 utf-8에서 iso-8859-1로 변환
		String downloadFilename = new String(originalFileName.getBytes("utf-8"), "iso-8859-1");
		log.info("iso-8859-1 filename = " + downloadFilename);

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; fileName= " + downloadFilename);

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	} // download()

	//uploadSummernoteImageFile()
	@PostMapping(value = "/summernote", produces = "application/json")
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {

		JsonObject jsonObject = new JsonObject();
		
		// String fileRoot = "C:\\Users\\lve25\\Desktop\\libraryImg\\summernote_image\\"; // 저장될 외부 파일 경로
		//String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		//String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		
		ServletContext application = request.getServletContext();
		// 썸네일 파일 업로드할 경로 
		String summernotePath = application.getRealPath("/upload/summernote");
		// 오늘 날짜
		LocalDateTime dateTime = LocalDateTime.now();
		String stringDate = dateTime.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		
		File summernoteDir = new File(summernotePath, stringDate);
		
		// 실제 파일 이름
		String originalName = multipartFile.getOriginalFilename();
		log.info("originalName: " + originalName);
		String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);
		
		// 썸네일 업로드할 폴더 없을 경우 폴더 생성
		if (!summernoteDir.exists()) {
			summernoteDir.mkdirs();
		}

		// UUID
		String stringUuid = UUID.randomUUID().toString();
		// 저장할 파일이름
		String uploadFileName = stringUuid + "_" + fileName;
		
		File saveFile = new File(summernoteDir, uploadFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, saveFile); // 파일 저장
			jsonObject.addProperty("url", "/upload/summernote/" + stringDate + "/" + uploadFileName); // 파일을 저장한 url 정보
			jsonObject.addProperty("responseCode", "success"); // 파일 저장 성공여부
		} catch (IOException e) {

			FileUtils.deleteQuietly(saveFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		return jsonObject;
	}

	private String currentTime() {

		LocalDateTime dateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String date = dateTime.format(formatter);

		return date;
	} // currentTime()

	private Long timeGap(int i, NoticeVo noticeVo) throws ParseException {

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

		String currentTime = this.currentTime();
		String writeTime = noticeVo.getRegDate();

		Date writeDate = dateFormat.parse(writeTime);
		Date currentDate = dateFormat.parse(currentTime);

		long time = (currentDate.getTime() - writeDate.getTime()) / 60000;

		return time;
	} // timeGap()

	private UploadFileVo uploadThumbnail(UploadFileVo thumbnailVo, HttpServletRequest request, MultipartFile thumbnail, int num) throws FileNotFoundException, IOException {
		
		ServletContext application = request.getServletContext();
		// 썸네일 파일 업로드할 경로 
		String thumbnailPath = application.getRealPath("/upload/thumbnail");
		// 오늘 날짜
		LocalDateTime dateTime = LocalDateTime.now();
		String stringDate = dateTime.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		
		File thumbnailDir = new File(thumbnailPath, stringDate);
		
		// 썸네일 업로드할 폴더 없을 경우 폴더 생성
		if (!thumbnailDir.exists()) {
			thumbnailDir.mkdirs();
		}
		
		// 실제 파일 이름
		String originalName = thumbnail.getOriginalFilename();
		String thumbnailName = originalName.substring(originalName.lastIndexOf("\\") + 1);
		
		// UUID
		String stringUuid = UUID.randomUUID().toString();
		// 저장할 파일이름
		String uploadFileName = stringUuid + "_" + thumbnailName;
		
		// 섬네일 파일 생성 (섬네일 파일 이름은 중간에 "s_"로 시작하도록)
		File thumbnailFile = new File(thumbnailDir, "s_" + uploadFileName);
		
		try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
			Thumbnailator.createThumbnail(thumbnail.getInputStream(), fos, 97, 130);
		}
		
		thumbnailVo.setBno(num);
		thumbnailVo.setPath(thumbnailDir.getPath().replace("\\", "/"));
		thumbnailVo.setUuid(stringUuid);
		thumbnailVo.setFilename(thumbnailName);

		return thumbnailVo;
	} // uploadThumbnail()

	private UploadFileVo uploadFile(HttpServletRequest request, MultipartFile multipartFile, int num) throws IllegalStateException, IOException {
		
		log.info("uploadFile() 실행");
		
		ServletContext application = request.getServletContext();
		// 첨부파일 업로드할 경로 
		String filePath = application.getRealPath("/upload/file");
		// 오늘 날짜
		LocalDateTime dateTime = LocalDateTime.now();
		String stringDate = dateTime.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));

		File fileDir = new File(filePath, stringDate);
		
		// 첨부파일 업로드할 폴더 없을 경우 폴더 생성
		if (!fileDir.exists()) {		
			fileDir.mkdirs();
			log.info("fileDir.mkdirs() 실행");
		}
		
		// 실제 파일 이름
		String originalName = multipartFile.getOriginalFilename();
		log.info("originalName: " + originalName);
		String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);
		
		// UUID
		String stringUuid = UUID.randomUUID().toString();
		// 저장할 파일이름
		String uploadFileName = stringUuid + "_" + fileName;
		
		File saveFile = new File(fileDir, uploadFileName);
		log.info("저장할 파일: " + saveFile);
		// 파일 업로드하기 
		multipartFile.transferTo(saveFile);
		
		UploadFileVo uploadFile = new UploadFileVo();

		uploadFile.setBno(num);
		uploadFile.setPath(fileDir.getPath().replace("\\", "/"));
		uploadFile.setUuid(stringUuid);
		uploadFile.setFilename(fileName);

		return uploadFile;
	} // uploadFile()
	
	private void deleteThumbnail(UploadFileVo thumbnailVo) {

		log.info("deleteFile()");
		String fileName = "s_" + thumbnailVo.getUuid() + "_" + thumbnailVo.getFilename();
		log.info("fileName:" + fileName);
		File deleteFile = new File(thumbnailVo.getPath(), fileName);

		if (deleteFile.exists()) {
			deleteFile.delete();
		}
	} // deleteThumbnail()
	
	private void deleteFile(UploadFileVo fileVo) {

		log.info("deleteFile()");
		String fileName = fileVo.getUuid() + "_" + fileVo.getFilename();
		log.info("fileName:" + fileName);
		File deleteFile = new File(fileVo.getPath(), fileName);

		if (deleteFile.exists()) {

			deleteFile.delete();
		}
	} // deleteFile()
	
}