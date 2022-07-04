package com.library.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class SeatVo {
	
	private int num;
	private int sno; //sno == seatNumber
	private String id;
	private String location;
	private String reserveTime;
	private String endTime;
	private int status; 
	
}