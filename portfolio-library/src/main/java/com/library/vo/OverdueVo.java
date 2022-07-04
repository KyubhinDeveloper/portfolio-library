package com.library.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class OverdueVo {
	
	private int num;
	private String id;
	private String name;
	private String bookNum;
	private String title;
	private String author;
	private String publisher;
	private String pubdate;
	private String isbn;
	private String returnDate;
	private String overdueDate;
	private int latefee;
}