package com.library.vo;

import lombok.Data;

@Data
public class CommentVo {
	
	private int cno;
	private int bno;
	private String id;
	private String name;
	private String comment;
	private String regDate;
	private int cmRef; //cm == comment
	private int cmLevel;
	private int cmStep;
	private Integer parent;

}