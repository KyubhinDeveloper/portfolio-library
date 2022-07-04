package com.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LoanRecordVo {

	private int num;
	private String id;
	private String name;
	private String bookNum;
	private String title;
	private String author;
	private String publisher;
	private String pubdate;
	private String isbn;
	private String loanDate;
	private String returnDate;
	private String type;
}