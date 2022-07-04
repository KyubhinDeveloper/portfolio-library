package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.library.vo.QaVo;
import com.library.vo.UploadFileVo;

public interface UploadFileMapper {
	
	@Insert("INSERT INTO notice_thumbnail(bno, uuid, filename, path)"
			+ "VALUES(#{bno}, #{uuid}, #{filename}, #{path})")
	void insertThumbnail(UploadFileVo thumbnailVo);
	
	@Insert("INSERT INTO notice_attachments(bno, uuid, filename, path)"
			+ "VALUES(#{bno}, #{uuid}, #{filename}, #{path})")
	void insertFile(UploadFileVo file);
	
	@Select("SELECT * FROM notice_attachments WHERE uuid = #{uuid}")
	UploadFileVo getFileByUuid(String uuid);
	
	@Select("SELECT * FROM notice_thumbnail WHERE bno = #{num}")
	UploadFileVo getThumbnailByNum(int num);
	
	@Delete("DELETE FROM notice_thumbnail WHERE bno = #{num}")
	void deleteThumbnailByNum(int num);
	
	@Delete("DELETE FROM notice_attachments WHERE bno = #{num}")
	void deleteFilesByNum(int num);
	
	@Delete("DELETE FROM notice_attachments WHERE uuid = #{uuid}")
	void deleteFilesByUuid(String uuid);
}