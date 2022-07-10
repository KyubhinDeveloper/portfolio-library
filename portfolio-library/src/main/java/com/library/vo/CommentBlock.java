package com.library.vo;

public class CommentBlock {
	
	//댓글 페이지 번호
	private int pageNum; 
	//가져올 댓글갯수
	private int amount; 
	//페이지 첫번째 댓글 번호
	private int startRow; 
	// 댓글 pagination 기본값
	public CommentBlock() {
		this(1, 15);
	}
	
	// 댓글 페이지 번호에 따른 가져올 paginatio 갯수
	public CommentBlock(int pageNum, int amount) {
		
		this.pageNum = pageNum;
		this.amount = amount;
		this.startRow = (this.pageNum - 1) * this.amount;
	}
}

