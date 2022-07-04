package com.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVo {
	
	private int num;
	private String id;
	private String password;
	private String name;
	private String gender;
	private String birth;
	private String phone;
	private String email;
	private String regDate;
	private String grade;
	private int loanCount;
}