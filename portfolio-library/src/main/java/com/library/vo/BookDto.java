package com.library.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BookDto {
	
	private int num;
	private String bookNum;
	private String title;
	private String image;
	private String author;
	private String publisher;
	private String pubdate;
	private String isbn;
	private String description;
	private int loanCount;
}