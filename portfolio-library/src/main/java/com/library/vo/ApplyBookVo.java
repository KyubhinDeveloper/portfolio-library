package com.library.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ApplyBookVo {
	
	private int num;
	private String id;
	private String title;
	private String author;
	private String publisher;
	private String pubdate;
	private String isbn;
	private int price;
	private String remarks;
	private String status;
	private String applyDate;
	
}