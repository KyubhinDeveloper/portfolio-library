package com.library.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UploadFileVo {
	
	 private String uuid;
	 private int bno;
	 private String filename;
	 private String path;
}