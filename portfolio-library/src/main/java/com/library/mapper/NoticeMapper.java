package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.library.vo.NoticeVo;

public interface NoticeMapper {
	
	@Update("UPDATE notice_forum SET views = views + 1 WHERE num = #{ num }")
	void updateViews(int num);
	
	@Update("UPDATE notice_forum SET subject = #{subject}, content = #{content} WHERE num = #{num}")
	void updateNotice(NoticeVo noticeVo);
	
	@Delete("DELETE FROM notice_forum WHERE num = #{num}")
	void deleteNotice(int num);
	
	@Select("SELECT ifnull(max(num), 0) + 1 as max_num FROM notice_forum")
	int getNoticeNum();
	
	@Select("SELECT COUNT(*) FROM notice_forum")
	int getNoticeCount();
	
	@Select("SELECT * FROM notice_forum WHERE num = #{num}")
	NoticeVo getNoticeByNum(int num);
	
	int getTotalCount(@Param("category") String category, @Param("search") String search);
	
	List<NoticeVo> getNoticeList(@Param("startRow") int startRow, 
			 					 @Param("rowCount") int rowCount,
			 					 @Param("category") String category,
			 					 @Param("search") String search);
	
	void insertNotice(NoticeVo noticeVo);
	
	NoticeVo getNoticeAndThumbnailByNum(int num);
	
	NoticeVo getNoticeAndFilesByNum(int num);
}