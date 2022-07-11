package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.UploadFileMapper;
import com.library.vo.UploadFileVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class UploadFileService {

	@Autowired
	UploadFileMapper uploadFileMapper;

	public void insertThumbnail(UploadFileVo thumbnailVo) {
		
		if (thumbnailVo != null) {
			uploadFileMapper.insertThumbnail(thumbnailVo);
		}
	} // insertThumbnail()

	public void insertFiles(List<UploadFileVo> fileList) {

		if (fileList.size() > 0) {
			for (UploadFileVo file : fileList) {
				uploadFileMapper.insertFile(file);
			}
		}
	} // insertFile()
	
	public UploadFileVo getFileByUuid(String uuid) {
		
		UploadFileVo fileVo = uploadFileMapper.getFileByUuid(uuid);
			
		return fileVo;
		
	} //getFilesByUuid()
	
	public UploadFileVo getThumbnailByNum(int num) {
		
		UploadFileVo thumbnailVo = uploadFileMapper.getThumbnailByNum(num);
		
		return thumbnailVo;	
	} //getThumbnailByUuid()
	
	public void deleteFilesByUuid(List<String> deleteUuid) {
		
		for(String uuid : deleteUuid ) {
			
			uploadFileMapper.deleteFilesByUuid(uuid);
		}	
	} //deleteFilesByUuid()
	
	public void deleteThumbnailByNum(int num) {
		
		uploadFileMapper.deleteThumbnailByNum(num);
		
	} //deleteThumbnailByNum()
	
	public void deleteFilesByNum(int num) {
		
		uploadFileMapper.deleteFilesByNum(num);
	} //deleteFilesByNum()

}