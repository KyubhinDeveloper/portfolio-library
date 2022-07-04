package com.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookmarkVo {

	private int num;
	private String id;
	private String title;
	private String author;
	private String publisher;
	private String pubdate;
	private String isbn;
}