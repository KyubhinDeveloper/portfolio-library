package com.library.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.library.service.RoomStatusService;
import com.library.vo.SeatVo;

import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/room/*")
public class RoomStatusController {
	
	@Autowired
	private RoomStatusService roomStatusService;
	
	
	@GetMapping("/status")
	public ResponseEntity<Map<String, Object>> getRoomStatus() {
		
		Map<String, Object> totalCount = roomStatusService.getTotalCount();
		
		return new ResponseEntity<Map<String, Object>>(totalCount, HttpStatus.OK);
	} //getRoomStatus()
	
	@GetMapping("/dashboard/status")
	public ResponseEntity<Map<String, Object>> getStatusForDashboard(@RequestParam("location") String location) {
		
		//열람실 정보
		int countInUse = roomStatusService.getCountInUse(location); 
		int countInStop = roomStatusService.getCountInStop(location);
		//좌석 정보
		List<SeatVo> seatStatus =  roomStatusService.getSeatStatus(location);

		Map<String, Object> result = new HashMap<>();
		result.put("countInUse", countInUse);
		result.put("countInStop", countInStop);
		result.put("seatStatus", seatStatus);
		
		return new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);	
	} //getStatusForDashboard()
	
	@GetMapping("/seatStatus/{location}")
	public Object getSeatStatus(@PathVariable("location") String location) {
		
		List<SeatVo> seatStatus =  roomStatusService.getSeatStatus(location);
		
		return new ResponseEntity<List<SeatVo>>(seatStatus, HttpStatus.OK);
	}//getSeatStatus()
	
	@GetMapping("/mySeatDetail")
	public Object mySeatDetail(HttpSession session) {
		
		String id = (String) session.getAttribute("id");
		SeatVo seatVo = roomStatusService.mySeatDetail(id); 
		
		return new ResponseEntity<SeatVo>(seatVo, HttpStatus.OK);
	} //mySeatDetail()
	
	@GetMapping("/seatDetail/{location}/{sno}")
	public ResponseEntity<SeatVo> getSeatDetail(@PathVariable("location") String location, 
												@PathVariable("sno") int sno) {
	
		SeatVo seatDetail = roomStatusService.getSeatDetail(location, sno);

		return new ResponseEntity<SeatVo>(seatDetail, HttpStatus.OK);		
	}//getSeatDetail()
		
	@PostMapping("/assignSeat")
	public String assignSeat(@RequestBody SeatVo seatVo) {
		
		String id = seatVo.getId();
		boolean check = roomStatusService.duplicateCheckById(id);
		
		if(check) {
			
			String str = "자리 중복 배정은 불가능합니다.";
			
			return str;
			
		} else {
			
			int num = roomStatusService.getNum();
			seatVo.setNum(num);
			
			roomStatusService.assignSeat(seatVo);
			
			String str = "자리 배정이 완료되었습니다.";
			
			return str;
		}
	} //assignSeat()
	
	@PostMapping("/stop")
	public void stop(@RequestBody SeatVo seatVo) {
		
		int num = roomStatusService.getNum();
		seatVo.setNum(num);
		
		roomStatusService.stop(seatVo);	
	} //stop()
	
	@DeleteMapping("/finish/{sno}/{room}")
	public void finish(@PathVariable("sno") int sno,
					   @PathVariable("room") String location) {
		
		roomStatusService.finish(sno,location);
	} //finish()
	
}