package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.library.vo.MemberVo;
import com.library.vo.MemoVo;
import com.library.vo.NoticeVo;

public interface MemberMapper {
	
	@Insert("INSERT INTO member(id, password, name, gender, birth, phone, email, reg_date)" 
			+ "VALUES(#{id}, #{password}, #{name}, #{gender}, #{birth}, #{phone}, #{email}, #{regDate})")
	void join(MemberVo memberVo);
	
	@Insert("INSERT INTO member_memo(id, writer, content, reg_date)"
			+ "VALUES(#{id}, #{writer}, #{content}, #{regDate})")
	void registMemo(MemoVo memoVo);
	
	@Update("UPDATE member SET phone = #{phone}, email = #{email} WHERE id = #{id}")
	void updateInfo(MemberVo memberVo);
	
	@Update("UPDATE member SET password = #{password} WHERE id = #{id}")
	boolean updatePwd(String password, String id);
	
	@Update("UPDATE member SET loan_count = loan_count + 1 WHERE id = #{id}")
	void updateLoanCnt(String id);
	
	@Select("SELECT COUNT(*) FROM member WHERE id = #{id}")
	int countCheckById(String id);
	
	@Select("SELECT COUNT(*) FROM member WHERE email = #{email}")
	int countCheckByEmail(String email);
	
	@Select("SELECT COUNT(*) FROM member")
	int getTotalCount();
	
	@Select("SELECT COUNT(*) FROM member WHERE reg_date = #{today}")
	int getTodayJointCnt(String today);
	
	int getSearchCount(@Param("category") String category, @Param("search") String search, @Param("grade") String grade);
	
	List<MemberVo> getMemberList(@Param("startRow") int startRow, 
			 					 @Param("rowCount") int rowCount,
			 					 @Param("category") String category,
			 					 @Param("search") String search,
			 					 @Param("grade") String grade);
	
	@Select("SELECT * FROM member WHERE id = #{id}")
	MemberVo getInfoById(String id);
	
	@Select("SELECT password FROM member WHERE id = #{id}")
	String getPasswordById(String id);
	
	@Select("SELECT grade FROM member WHERE id = #{id}")
	String getGradeById(String id);
	
	@Select("SELECT name FROM member WHERE id = #{id}")
	String getNameById(String id);
	
	@Select("SELECT * FROM  member_memo WHERE id = #{id}")
	List<MemoVo> getMemoList(String id);
	
	@Select("SELECT * FROM member ORDER BY loan_count DESC LIMIT #{listCount}")
	List<MemberVo> getLankingList(int listCount);
	
	@Update("UPDATE member SET grade = #{grade} WHERE id = #{id}")
	void changeGrade(String id, String grade);
	
	@Delete("DELETE FROM member WHERE id = #{id}")
	void secession(String id);
	
	@Delete("DELETE FROM member_memo WHERE num = #{num}")
	void deleteMemo(int num);
	
	
}