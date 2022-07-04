package com.library.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.RoomStatusMapper;
import com.library.vo.SeatVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class RoomStatusService {
	
	@Autowired
	RoomStatusMapper roomStatusMapper;
	
	public Map<String, Object> getTotalCount() {
		
		Map<String, Object> totalCount = new HashMap<>();
		
		int room2 = roomStatusMapper.getTotalCount(2);
		int room3 = roomStatusMapper.getTotalCount(3);
		
		totalCount.put("room2",room2);
		totalCount.put("room3",room3);
		
		return totalCount;
	}//getTotalCount()
	
	public int getCountInUse(String location) {
		int countInUse = roomStatusMapper.getCountInUse(location);
		return countInUse;
	}
	
	public int getCountInStop(String location) {
		int countInStop = roomStatusMapper.getCountInStop(location);
		return countInStop;
	}
	
	public boolean duplicateCheckById(String id) {
		
		int count = roomStatusMapper.duplicateCheckById(id);
		
		if(count > 0) {
			
			boolean check = true;
			return check;
			
		} else {
			
			boolean check = false;
			return check;
		}
	} //duplicateCheck()
	
	public boolean duplicateCheckBySno(int sno) {
		
		int count = roomStatusMapper.duplicateCheckBySno(sno);
		
		if(count > 0) {
			
			boolean check = true;
			return check;
			
		} else {
			
			boolean check = false;
			return check;
		}
	} //duplicateCheckBySno
	
	public int getStatus(int sno) {
		
		int status = roomStatusMapper.getStatus(sno);
		
		return status;
	} //getSeatStatus()
	
	public List<SeatVo> getSeatStatus(String location){
		
		List<SeatVo> seatStatus = roomStatusMapper.getSeatStatus(location);
		
		return seatStatus;
	} //getSeatStatus()
	
	public List<SeatVo> getSeatList(int status){
		
		List<SeatVo> seatStatus = roomStatusMapper.getSeatList(status);
		
		return seatStatus;
	} //getSeatList()
	
	public SeatVo getSeatDetail(String location, int sno){
		
		SeatVo seatDetail = roomStatusMapper.getSeatDetail(location, sno);
		
		return seatDetail;
	} //getSeatDetail()
	
	public SeatVo mySeatDetail(String id) {
		
		SeatVo seatVo = roomStatusMapper.mySeatDetail(id);
		
		return seatVo;
	} //mySeatDetail()
	
	public int getNum() {
		
		Integer num = roomStatusMapper.getNum();

		if (num == null) {
			num = 1;
		}

		return num;		
	} //getNum()
	
	public void assignSeat(SeatVo seatVo) {
		
		roomStatusMapper.assignSeat(seatVo);
	} //assignSeat()
	
	public void stop(SeatVo seatVo) {
		
		roomStatusMapper.stop(seatVo);
	} //stop
	
	public void finish(int sno, String location) {
		
		roomStatusMapper.finish(sno, location);
	}//finish
	
}