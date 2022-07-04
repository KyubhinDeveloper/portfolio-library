package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.library.vo.SeatVo;

public interface RoomStatusMapper {
		
		@Insert("INSERT INTO seat_status(num, sno, id, location, reserve_time, end_time, status)"
				+ "VALUES(#{num}, #{sno}, #{id}, #{location}, #{reserveTime}, #{endTime}, #{status})")
		void assignSeat(SeatVo seatVo);
		
		@Insert("INSERT INTO seat_status(num, sno, location, status)"
				+ "VALUES(#{num}, #{sno}, #{location}, #{status})")
		void stop(SeatVo seatVo);
	
		@Select("SELECT COUNT(*) FROM seat_status WHERE location = #{location}")
		int getTotalCount(int location);
		
		@Select("SELECT COUNT(*) FROM seat_status WHERE location = #{location} AND STATUS = 1")
		int getCountInUse(String location);
		
		@Select("SELECT COUNT(*) FROM seat_status WHERE location = #{location} AND STATUS = 0")
		int getCountInStop(String location);
		
		@Select("SELECT status FROM seat_status WHERE sno = #{sno}")
		int getStatus(int sno);
		
		@Select("SELECT min(num + 1) FROM seat_status WHERE (num + 1) NOT IN (SELECT num FROM seat_status)")
		Integer getNum();
	
		@Select("SELECT * FROM seat_status WHERE location = #{location}")
		List<SeatVo> getSeatStatus(String location);
		
		@Select("SELECT * FROM seat_status WHERE status = #{status}")
		List<SeatVo> getSeatList(int status);
		
		@Select("SELECT * FROM seat_status WHERE location = #{location} AND sno = #{sno}")
		SeatVo getSeatDetail(String location, int sno);
		
		@Select("SELECT * FROM seat_status WHERE id = #{id}")
		SeatVo mySeatDetail(String id);
		
		@Select("SELECT count(*) FROM seat_status WHERE id = #{id}")
		int duplicateCheckById(String id);
		
		@Select("SELECT count(*) FROM seat_status WHERE sno = #{sno}")
		int duplicateCheckBySno(int sno);
		
		@Delete("DELETE FROM seat_status WHERE sno = #{sno} AND location = #{location}")
		void finish(int sno, String location);
}