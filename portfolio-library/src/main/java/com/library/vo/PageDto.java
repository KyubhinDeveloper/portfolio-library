package com.library.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageDto {
	
	private int totalCount; //글 총 개수
	private int rowCount; //화면에 보여줄 글 개수
	private int pageCount; //page 총 개수
	private int pageBlock; //화면에 보여줄 page block 개수
	private int startPage; //page block 첫 번호
	private int endPage; //page blcok 마지막 번호
	private String category; 
	private String search; 	
}