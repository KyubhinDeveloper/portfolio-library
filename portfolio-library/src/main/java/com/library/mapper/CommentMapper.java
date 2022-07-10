package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.library.vo.CommentBlock;
import com.library.vo.CommentVo;

public interface CommentMapper {
	
	@Insert("INSERT INTO inquiry_comment(cno,bno,id,name,comment,cm_ref,cm_level,cm_step,parent)"
			+ "VALUES(#{cno},#{bno},#{id},#{name},#{comment},#{cmRef},#{cmLevel},#{cmStep},#{parent})")
	void insertComment(CommentVo commentVo);
	
	@Select("SELECT * "
			+ "FROM inquiry_comment " 
			+ "WHERE bno = #{bno} "
			+ "ORDER BY cm_ref asc, cm_step asc "
			+ "LIMIT #{block.startRow}, #{block.amount} ")
	List<CommentVo> getListWithPaging(@Param("bno") int bno, @Param("block") CommentBlock block);
	
	@Select("SELECT ifnull(max(cno), 0) + 1 as max_num FROM inquiry_comment")
	int getCommentNum();
	
	@Select("SELECT min(cm_step) FROM inquiry_comment WHERE cm_ref = #{cmRef} AND cm_step > #{cmStep} AND cm_level <= #{cmLevel}")
	Integer checkStep(@Param("cmRef") int cmRef, @Param("cmStep") int cmStep, @Param("cmLevel") int cmLevel);
	
	@Select("SELECT COUNT(*) FROM inquiry_comment WHERE bno = #{num}")
	int getCommentCount(int num);
	
	@Select("SELECT name FROM inquiry_comment WHERE cno = #{num}")
	String getNameByCno(int num);
	
	@Select("SELECT max(cm_step) + 1 FROM inquiry_comment WHERE cm_ref = #{cmRef}")
	int getMaxStep(int cmRef);
	
	@Select("SELECT COUNT(*) FROM inquiry_comment WHERE parent = #{cno}")
	int getNestedCmCount(int cno);
	
	@Select("SELECT * FROM inquiry_comment WHERE cno = #{cno}")
	CommentVo getCommentByCno(int cno);
	
	@Update("UPDATE inquiry_comment set cm_step = cm_step + 1 WHERE cm_ref = #{cmRef} AND cm_step >= #{cmStep}")
	void updateStep(@Param("cmRef") int cmRef, @Param("cmStep") int cmStep);
		
	@Update("UPDATE inquiry_comment set comment = #{comment} WHERE cno = #{cno}")
	void updateComment(CommentVo commentVo);
	
	@Delete("DELETE FROM inquiry_comment WHERE cno = #{cno}")
	void deleteComment(int cno);
	
	@Delete("DELETE FROM inquiry_comment WHERE bno = #{bno}")
	void deleteAllComment(int bno);
	
}