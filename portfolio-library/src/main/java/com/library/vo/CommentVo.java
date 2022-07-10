package com.library.vo;

import lombok.Data;

@Data
public class CommentVo {
	
	private int cno; 
	// 댓글을 단 글번호
	private int bno;
	private String id;
	private String name;
	private String comment;
	private String regDate;
	// 댓글그룹 번호
	private int cmRef; //cm == comment
	// 댓글 들여쓰기 간격
	private int cmLevel;
	// 댓글그룹 내 순서
	private int cmStep; 
	// 댓글단 댓글번호
	private Integer parent;
}