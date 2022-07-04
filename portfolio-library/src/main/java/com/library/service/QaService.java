package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.QaMapper;
import com.library.vo.QaVo;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class QaService {
	
	@Autowired
	QaMapper qaMapper;
	
	
	public List<QaVo> getQaList() {
		
		List<QaVo> qaList = qaMapper.getQaList();
		
		return qaList;
	} //getQaList()
	
	public void writeQa(QaVo qaVo) {
		
		qaMapper.writeQa(qaVo);
	}//writeQa()
	
	
	public void deleteQa(int num) {
		
		qaMapper.deleteQa(num);
	}//deleteQa()
	
}