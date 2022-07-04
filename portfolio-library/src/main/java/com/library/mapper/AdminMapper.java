package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.library.vo.ApplyBookVo;
import com.library.vo.InquiryVo;
import com.library.vo.LoanBookVo;
import com.library.vo.LoanRecordVo;
import com.library.vo.LossRecordVo;
import com.library.vo.OverdueVo;

public interface AdminMapper {
	
	@Insert("INSERT INTO member_notice(id,bookNum,title,loan_date,return_date,type,reg_date)"
			+ "VALUES(#{loanBookVo.id},#{loanBookVo.bookNum},#{loanBookVo.title},#{loanBookVo.loanDate},#{loanBookVo.endDate},#{type},#{loanBookVo.loanDate})")
	void sendingNotice(@Param("loanBookVo") LoanBookVo loanBookVo, @Param("type") int type);
	
	@Insert("INSERT INTO member_notice(id,bookNum,title,loan_date,return_date,overdue_date,type,reg_date)"
			+ "VALUES(#{id},#{bookNum},#{title},#{loanDate},#{endDate},#{overdueDate} + 1,2,#{loanDate})")
	void sendingNotice2(LoanBookVo loanBookVo);
	
	@Insert("INSERT INTO member_notice(id,content,type,reg_date)"
			+ "VALUES(#{id},#{content},6,#{regDate})")
	void sendingNotice6(@Param("id") String id, @Param("content") String content, @Param("regDate") String regDate);

	@Insert("INSERT INTO overdue_record(id,name,book_num,title,author,publisher,pubdate,isbn,return_date,overdue_date,latefee)"
			+ "VALUES(#{loanBookVo.id},#{loanBookVo.name},#{loanBookVo.bookNum},#{loanBookVo.title},#{loanBookVo.author},#{loanBookVo.publisher},#{loanBookVo.pubdate},#{loanBookVo.isbn},#{loanBookVo.endDate},#{loanBookVo.overdueDate},#{latefee})")
	void insertOverdueRecord(@Param("loanBookVo") LoanBookVo loanBookVo, @Param("latefee") int latefee);
	
	@Insert("INSERT INTO loss_record(id,name,book_num,title,author,publisher,pubdate,isbn,loss_date)"
			+ "VALUES(#{id},#{name},#{bookNum},#{title},#{author},#{publisher},#{pubdate},#{isbn},#{loanDate})")
	void insertLostRecord(LoanBookVo loanBookVo);
	
	@Select("SELECT COUNT(*) FROM loan_record")
	int getLoanRecordCnt();
	
	@Select("SELECT COUNT(*) FROM book_loan WHERE status = '연체중'")
	int getOverdueCnt();
	
	@Select("SELECT COUNT(*) FROM overdue_record WHERE id = #{id}")
	int getOverdueCntById(String id);
	
	@Select("SELECT COUNT(*) FROM book_loan WHERE overdue_date = 1 AND status = '연체중'")
	int getTodayOverdueCnt();

	@Select("SELECT COUNT(*) FROM overdue_record")
	int getOverdueRecordCnt();
	
	@Select("SELECT COUNT(*) FROM book_loan WHERE status = '분실중'")
	int getLossCnt();
	
	@Select("SELECT COUNT(*) FROM loss_record")
	int getLossRecordCnt();
	
	@Select("SELECT COUNT(*) FROM loss_record WHERE id = #{id}")
	int getLossCountById(String id);
	
	@Select("SELECT COUNT(*) FROM loss_record WHERE loss_date = #{today} AND status = 0")
	int getTodayLossCnt(String today);
	
	@Select("SELECT COUNT(*) FROM book_apply")
	int getHopeCount();
	
	@Select("SELECT loss_date FROM loss_record WHERE book_num = #{bookNum} AND status = 0")
	String getLossDateByBookNum(String bookNum);
	
	@Select("SELECT num FROM loss_record WHERE status = 0 AND id = #{id} AND book_num = #{bookNum}")
	int getLossRecordNum(@Param("id") String id, @Param("bookNum") String bookNum);
	
	@Select("SELECT SUM(overdue_date) FROM book_loan")
	int getTotalLatefee();
	
	@Update("UPDATE book_loan SET status = '분실중' WHERE num = #{num}")
	void registerForLoss(int num);
	
	@Update("UPDATE book_loan SET status = '연체중', overdue_date = overdue_date + 1 WHERE num = #{num}")
	void updateOverdue(int num);
	
	@Update("UPDATE book_apply SET status = #{status} WHERE num = #{num}")
	void changeStatus(int num, String status);
	
	@Update("UPDATE loss_record SET return_date = #{returnDate}, status = 1 WHERE num = #{num}")
	void updateLossRecord(@Param("returnDate") String returnDate, @Param("num") int num);
	
	int getLoanRecordSearchCnt(@Param("category") String category, @Param("search") String search, @Param("type") String type);
	
	int getOdSearchCnt(@Param("category") String category, @Param("search") String search);
	
	int getOdRecordSearchCnt(@Param("category") String category, @Param("search") String search);
	
	int getLossSearchCnt(@Param("category") String category, @Param("search") String search);
	
	int getLossRecordSearchCnt(@Param("category") String category, @Param("search") String search);
	
	int getHopeSearchCnt(@Param("category") String category, @Param("search") String search,  @Param("status") String status);
	
	int getInquirySearchCnt(@Param("category") String category, @Param("search") String search,  @Param("status") String status);
	
	@Select("SELECT * FROM book_loan")
	List<LoanBookVo> getLoanList();
	
	@Select("SELECT * FROM loss_record WHERE status = 0 ORDER BY num DESC, loss_date DESC LIMIT 4")
	List<LossRecordVo> getRecentLossList();
	
	List<LoanRecordVo> getLoanRecord(@Param("rowCount") int rowCount, @Param("startRow") int startRow, @Param("category") String category, @Param("search") String search, @Param("type") String type);	 
	
	List<LoanBookVo> getOverdueList(@Param("rowCount") int rowCount, @Param("startRow") int startRow, @Param("category") String category, @Param("search") String search);
	
	List<OverdueVo> getOverdueRecord(@Param("rowCount") int rowCount, @Param("startRow") int startRow, @Param("category") String category, @Param("search") String search);	 
	
	List<LoanBookVo> getLossList(@Param("rowCount") int rowCount, @Param("startRow") int startRow, @Param("category") String category, @Param("search") String search);
	
	List<LossRecordVo> getLossRecord(@Param("rowCount") int rowCount, @Param("startRow") int startRow, @Param("category") String category, @Param("search") String search);
	
	List<ApplyBookVo> getHopeList(@Param("rowCount") int rowCount, @Param("startRow") int startRow, @Param("category") String category, @Param("search") String search, @Param("status") String status);
	
	List<InquiryVo> getInquiryList(@Param("rowCount") int rowCount, @Param("startRow") int startRow, @Param("category") String category, @Param("search") String search, @Param("status") String status);
}	