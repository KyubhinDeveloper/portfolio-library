package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.library.vo.ApplyBookVo;
import com.library.vo.BookmarkVo;
import com.library.vo.LoanBookVo;
import com.library.vo.LoanRecordVo;
import com.library.vo.LossRecordVo;
import com.library.vo.OverdueVo;
import com.library.vo.PersonalNoticeVo;
import com.library.vo.ReserveBookVo;

public interface MyLibraryMapper {
	
	
	void applyBook(ApplyBookVo applyBookVo);

	@Update("UPDATE member_notice SET read_date = #{date} WHERE num = #{num}")
	void updateReadDate(int num, String date);
	
	@Delete("DELETE FROM book_apply WHERE num = #{num}")
	void cancelApplication(int num);
	
	@Select("SELECT sum(price) FROM book_apply WHERE id = #{id}")
	int getMyPriceById(String id);
	
	@Select("SELECT COUNT(*) FROM bookmark WHERE id = #{id}")
	int getBookmarkCnt(String id);
	
	@Select("SELECT COUNT(*) FROM book_loan WHERE id = #{id}")
	int getLoanCnt(String id);
	
	@Select("SELECT COUNT(*) FROM loan_record WHERE id = #{id}")
	int getLoanRecordCnt(String id);
	
	@Select("SELECT COUNT(*) FROM member_notice WHERE id = #{id} AND read_date is null")
	int getMyNoticeCnt(String id);
	
	@Select("SELECT COUNT(*) FROM book_reserve WHERE book_num = #{bookNum}")
	int getBookedCntByBookNum(String bookNum);
	
	@Select("SELECT COUNT(*) FROM book_reserve WHERE id = #{id}")
	int getBookedCntById(String id);
	
	@Select("SELECT COUNT(*) FROM book_loan WHERE id = #{id} AND status = '연체중'")
	int getOverdueCnt(String id);
	
	@Select("SELECT COUNT(*) FROM book_loan WHERE id = #{id} AND status = '분실중'")
	int getLossCnt(String id);
	
	@Select("SELECT COUNT(*) FROM overdue_record WHERE id = #{id}")
	int overdueRecordCnt(String id);
	
	@Select("SELECT COUNT(*) FROM book_apply WHERE id = #{id}")
	int getApplicationCnt(String id);
	
	@Select("SELECT COUNT(*) FROM book_apply WHERE apply_date = #{today}")
	int todayApplicationCnt(String today);
	
	@Select("SELECT COUNT(*) FROM book_apply")
	int totalApplicationCnt();
	
	@Select("SELECT COUNT(*) FROM loss_record WHERE id = #{id}")
	int getLossCount(String id);
	
	@Select("SELECT SUM(overdue_date) FROM book_loan WHERE id = #{id}")
	Integer getOverdueDay(String id);
	
	@Select("SELECT COUNT(*) FROM member_notice WHERE id = #{id}")
	Integer getNoticeCnt(String id);
	
	@Select("SELECT * FROM member_notice WHERE num = #{num}")
	PersonalNoticeVo getNoticeVo(int num);
	
	@Select("SELECT * FROM bookmark WHERE id = #{id}")
	List<BookmarkVo> getBookmarkList(String id);
	
	@Select("SELECT * FROM book_loan WHERE id = #{id} AND status != '대기중'")
	List<LoanBookVo> getLoanBookList(String id);
	
	@Select("SELECT * FROM loan_record WHERE id = #{id} ORDER BY num DESC LIMIT #{startRow}, #{rowCount}")
	List<LoanRecordVo> getLoanRecordList(@Param("id") String id, @Param("startRow") int startRow, @Param("rowCount") int rowCount);
	
	@Select("SELECT * FROM book_reserve WHERE id = #{id}")
	List<ReserveBookVo> getReserveList(String id);
	
	@Select("SELECT * FROM book_apply WHERE id = #{id}")
	List<ApplyBookVo> getApplicationList(String id);
	
	@Select("SELECT * FROM overdue_record WHERE id = #{id}")
	List<OverdueVo> getOdRecordList(String id); //od == overdue
	
	@Select("SELECT * FROM book_loan WHERE id = #{id} AND status = '연체중'")
	List<LoanBookVo> getOverdueList(String id, int status);
	
	@Select("SELECT * FROM loss_record WHERE id = #{id} AND status = 1")
	List<LossRecordVo> getLossRecordList(String id);
	
	@Select("SELECT * FROM member_notice WHERE id = #{id} ORDER BY num DESC LIMIT #{startRow}, #{rowCount}")
	List<PersonalNoticeVo> getNoticeList(@Param("id") String id, @Param("startRow") int starRow, @Param("rowCount") int rowCount);
}