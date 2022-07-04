package com.library.vo;

public class CommentBlock {
	
	private int pageNum; //댓글 페이지 번호
	private int amount; //가져올 댓글갯수
	private int startRow; //페이지 첫번째 댓글 번호
	
	public CommentBlock() {
		this(1, 20);
	}
	
	public CommentBlock(int pageNum, int amount) {
		
		this.pageNum = pageNum;
		this.amount = amount;
		this.startRow = (this.pageNum - 1) * this.amount;
	}
}