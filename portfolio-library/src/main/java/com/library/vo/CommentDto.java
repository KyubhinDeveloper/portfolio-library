package com.library.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class CommentDto {
	
	private List<CommentVo> commentList;
	private int commentCnt; // commentCnt = commentCount
}