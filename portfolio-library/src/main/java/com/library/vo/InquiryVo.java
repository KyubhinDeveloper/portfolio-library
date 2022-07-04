package com.library.vo;

import lombok.Data;

@Data
public class InquiryVo {
	
	private int num;
	private String ip;
	private String id;
	private String name;
	private String subject;
	private String content;
	private String regDate;
	private String secret;
	private int views;
	private String status;
	
}