package com.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonalNoticeVo {

	private int num;
	private String id;
	private String content;
	private String bookNum;
	private String title;
	private String loanDate;
	private String returnDate;
	private int overdueDate;
	private int type;
	private String regDate;
	private String readDate;
}