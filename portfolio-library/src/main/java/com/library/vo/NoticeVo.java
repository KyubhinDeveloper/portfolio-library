package com.library.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeVo {
	
	private List<UploadFileVo> attachments;
	private UploadFileVo thumbnail;
		
	private int num;
	private String id;
	private String name;
	private String subject;
	private String content;
	private String regDate;
	private int views;
	
}

