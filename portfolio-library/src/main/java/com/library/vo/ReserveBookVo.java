package com.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReserveBookVo {
	
	private int num;
	private String id;
	private String name;
	private String bookNum;
	private String title;
	private String isbn;
	private String reserveDate;
	private int turn;
}