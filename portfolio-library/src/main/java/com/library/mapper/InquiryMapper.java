package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.library.vo.InquiryVo;
import com.library.vo.NoticeVo;

public interface InquiryMapper {
	
	void insertInquiry(InquiryVo inquiryVo);
	
	@Select("SELECT ifnull(max(num), 0) + 1 as max_num FROM inquiry_forum")
	int getInquiryNum();
	
	@Update("UPDATE inquiry_forum SET views = views + 1 WHERE num = #{ num }")
	void updateViews(int num);
	
	@Update("UPDATE inquiry_forum SET status = '답변완료' WHERE num = #{ num }")
	void updateStatus(int num);
	
	@Update("UPDATE inquiry_forum SET subject = #{subject}, content = #{content}, secret = #{secret} WHERE num = #{num}")
	void updateInquiry(InquiryVo inquiryVo);
	
	@Delete("DELETE FROM inquiry_forum WHERE num = #{num}")
	void deleteInquiry(int num);
	
	int getTotalCount(@Param("category") String category, @Param("search") String search);
	
	int getSearchCount(@Param("category") String category, @Param("search") String search, @Param("id") String id);
	
	@Select("SELECT COUNT(*) FROM inquiry_forum WHERE id = #{id}")
	int totalCountById(String id);
	
	@Select("SELECT COUNT(*) FROM inquiry_forum")
	int getInquiryCnt();
	
	@Select("SELECT * FROM inquiry_forum WHERE num = #{num}")
	InquiryVo getInquiryByNum(int num);
	
	List<InquiryVo> getInquiryList(@Param("startRow") int startRow, 
								   @Param("rowCount") int rowCount,
								   @Param("category") String category,
								   @Param("search") String search);
	
	List<InquiryVo> inquiryListById(@Param("startRow") int startRow, 
			   						@Param("rowCount") int rowCount,
			   						@Param("category") String category,
			   						@Param("search") String search,
			   						@Param("id") String id);
}