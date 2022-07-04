package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.library.vo.QaVo;

public interface QaMapper {
	
	
	@Insert("INSERT INTO qa_forum(question, answer)"
			+ "VALUES(#{question}, #{answer})")
	void writeQa(QaVo qaVo);
	
	@Select("SELECT * FROM qa_forum")
	List<QaVo> getQaList();
	
	@Delete("DELETE FROM qa_forum WHERE num = ${num}")
	void deleteQa(int num);
}