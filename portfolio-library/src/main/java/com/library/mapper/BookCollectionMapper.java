package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.library.vo.BookDto;
import com.library.vo.BookmarkVo;
import com.library.vo.LoanBookVo;
import com.library.vo.NoticeVo;
import com.library.vo.QaVo;
import com.library.vo.ReserveBookVo;

public interface BookCollectionMapper {
		
	@Insert("INSERT INTO book_loan(num,id,name,book_num,title,author,publisher,pubdate,isbn,loan_date,end_date)"
			+ "VALUES(#{num},#{id},#{name},#{bookNum},#{title},#{author},#{publisher},#{pubdate},#{isbn},#{loanDate},#{endDate})")
	void loanBook(LoanBookVo loanBookVo);
	
	@Insert("INSERT INTO book_reserve(num,id,name,book_num,title,isbn,reserve_date,turn)"
			+ "VALUES(#{num},#{id},#{name},#{bookNum},#{title},#{isbn},#{reserveDate},#{turn})")
	void reserveBook(ReserveBookVo reserveBookVo);
	
	@Insert("INSERT INTO book_stop(num,book_num,isbn)"
			+ "VALUES(#{num},#{bookNum},#{isbn})")
	void stopUsing(BookDto bookDto);
	
	@Insert("INSERT INTO bookmark(num,id,title,author,publisher,pubdate,isbn)"
			+ "VALUES(#{num},#{id},#{title},#{author},#{publisher},#{pubdate},#{isbn})")
	void insertBookmark(BookmarkVo bookmarkVo);
	
	@Insert("INSERT INTO loan_record(num,id,name,book_num,title,author,publisher,pubdate,isbn,loan_date,return_date,type)"
			+ "VALUES(#{loanBookVo.num},#{loanBookVo.id},#{loanBookVo.name},#{loanBookVo.bookNum},#{loanBookVo.title},#{loanBookVo.author},#{loanBookVo.publisher},#{loanBookVo.pubdate},#{loanBookVo.isbn},#{loanBookVo.loanDate},#{loanBookVo.endDate},#{type})")
	void recordLoanBook(@Param("loanBookVo")LoanBookVo loanBookVo, @Param("type") String type);
	
	@Insert("INSERT INTO book_record(title,author,publisher,pubdate,isbn,image)"
			+ "VALUES(#{loanBookVo.title},#{loanBookVo.author},#{loanBookVo.publisher},#{loanBookVo.pubdate},#{loanBookVo.isbn},#{image})")
	void recordBook(@Param("loanBookVo") LoanBookVo loanBookVo, @Param("image") String image);
	
	@Select("SELECT * FROM book_loan WHERE isbn = #{isbn}")
	public List<LoanBookVo> getLoanStatus(String isbn);
	
	@Select("SELECT * FROM book_reserve WHERE isbn = #{isbn}")
	public List<ReserveBookVo> getReserveStatus(String isbn);
	
	@Select("SELECT * FROM book_loan WHERE status = '대출중' OR status = '대기중' ORDER BY num DESC, loan_date DESC LIMIT 5")
	public List<LoanBookVo> getRecentLoanList();
	
	@Select("SELECT * FROM book_record ORDER BY loan_count DESC LIMIT #{listCount}")
	public List<BookDto> getPopularBookList(int listCount);
	
	public List<LoanBookVo> getLoanBookList(@Param("rowCount") int rowCount, 
											@Param("startRow") int startRow, 
											@Param("category") String category, 
											@Param("search") String search, 
											@Param("status") String status);
	
	public List<ReserveBookVo> getReservationList(@Param("rowCount") int rowCount,
												  @Param("startRow") int startRow,
												  @Param("category") String category, 
												  @Param("search") String search);
	
	@Select("SELECT ifnull(max(num), 0) + 1 as max_num FROM book_loan")
	public Integer getLoanNum();
	
	@Select("SELECT ifnull(max(num), 0) + 1 as max_num FROM loan_record")
	public Integer getLoanNumFromRecord();
	
	@Select("SELECT min(num + 1) FROM book_reserve WHERE num + 1  NOT IN (SELECT num FROM book_reserve)")
	public Integer getReserveNum();
	
	@Select("SELECT min(num + 1) FROM book_stop WHERE num + 1  NOT IN (SELECT num FROM book_stop)")
	public Integer getStopNum();
	
	@Select("SELECT min(num + 1) FROM bookmark WHERE num + 1  NOT IN (SELECT num FROM bookmark)")
	public Integer getBookmarkNum();
	
	@Select("SELECT id FROM book_reserve WHERE book_num = #{bookNum} AND turn = #{turn}")
	public String getReserver(String bookNum, int turn);
	
	@Select("SELECT count(*) FROM book_reserve WHERE book_num = #{bookNum}")
	public Integer getReservationCount(String bookNum);
	
	@Select("SELECT COUNT(*) FROM book_reserve")
	public int getReservationCnt();
	
	@Select("SELECT turn FROM book_reserve WHERE id = #{reserverId} AND book_num = #{bookNum}")
	public int getReservationTurn(String reserverId, String bookNum);
	
	public int getRsSearchCnt(@Param("category") String categroy, @Param("search") String search);
	
	@Select("SELECT COUNT(*) FROM book_loan")
	public int getLoanCount();
	
	@Select("SELECT COUNT(*) FROM book_loan WHERE loan_date = #{today} AND status = '대출중'")
	public int getTodayLoanCnt(String today);
	
	@Select("SELECT id FROM book_loan WHERE num = #{num}")
	public String getIdByNum(int num);
	
	@Select("SELECT book_num FROM book_loan WHERE num = #{num}")
	public String getBookNumByNum(int num);
	
	public int getLoanSearchCnt(@Param("category") String category, @Param("search") String search, @Param("status") String status);
	
	@Select("SELECT count(*) FROM book_reserve WHERE isbn = #{isbn} AND id = #{id}")
	public int rvDuplication(String isbn, String id);
	
	@Select("SELECT count(*) FROM book_loan WHERE isbn = #{isbn} AND id = #{id}")
	public int loanDuplication(String isbn, String id);
	
	@Select("SELECT count(*) FROM bookmark WHERE isbn = #{isbn} AND id = #{id}")
	public int bookmarkDup(String isbn, String id);
	
	@Select("SELECT count(*) FROM book_loan WHERE book_num = #{bookNum}")
	public int loanStatus(String bookNum);
	
	@Select("SELECT isbn FROM book_reserve WHERE book_num = #{bookNum}")
	public String getIsbnByBookNum(String bookNum);
	
	@Select("SELECT COUNT(*) FROM book_stop WHERE book_num = #{bookNum} AND isbn = #{isbn}")
	public int checkStop(String bookNum, String isbn);
	
	@Select("SELECT COUNT(*) FROM book_loan WHERE status = '연체중' AND id = #{id}")
	public int checkOverdue(String id);
	
	@Select("SELECT COUNT(*) FROM book_record WHERE isbn = #{isbn}")
	public int checkDupBook(String isbn);
	
	@Select("SELECT * FROM book_loan WHERE num = #{num}")
	public LoanBookVo getLoanBook(int num);
	
	@Select("SELECT * FROM book_loan WHERE book_num = #{bookNum}")
	public LoanBookVo getLoanBookByBookNum(String bookNum);
	
	@Update("UPDATE book_loan SET num = #{num}, id = #{id}, name = #{name}, loan_date = #{loanDate}, end_date = #{endDate}, status = #{status} WHERE book_num = #{bookNum}")
	public void updateLoan(LoanBookVo loanBookVo);
	
	@Update("UPDATE book_loan SET end_date = #{endDate}, extension = 1 WHERE book_num = #{bookNum}")
	public void updateLoanDate(LoanBookVo loanBookVo);
	 
	@Update("UPDATE book_reserve SET turn = turn -1 WHERE book_num = #{bookNum}")
	void updateReservation(String bookNum);
	
	@Update("UPDATE book_loan SET status = '대출중' WHERE num = #{num}")
	void approveLoan(int num);
	
	@Update("UPDATE book_record SET loan_count = loan_count + 1 WHERE isbn = #{isbn}")
	void updateLoanCnt(String isbn);
	
	@Update("UPDATE book_loan SET extension = #{extension} WHERE num = #{num}")
	void updateLoanExtension(int num, int extension);
			
	@Delete("DELETE FROM book_loan WHERE book_num = #{bookNum}")
	public void cancelLoan(String bookNum);
	
	@Delete("DELETE FROM book_reserve WHERE book_num = #{bookNum} OR isbn = #{isbn}")
	public void cancelReservations(String bookNum, String isbn);
	
	@Delete("DELETE FROM book_reserve WHERE book_num = #{bookNum} AND id = #{id}")
	public void cancelReservationById(String bookNum, String id);
	
	@Delete("DELETE FROM book_reserve WHERE book_num = #{bookNum} AND turn = #{turn}")
	public void cancelReservationByTurn(String bookNum, int turn);
	
	@Delete("DELETE FROM book_stop WHERE book_num = #{bookNum} AND isbn = #{isbn}")
	public void recoveryBook(String bookNum, String isbn);
	
	@Delete("DELETE FROM bookmark WHERE id = #{id} AND isbn = #{isbn}")
	public void deleteBookmark(String id, String isbn);
	
	@Delete("DELETE FROM book_loan WHERE num = #{num}")
	public void returnBook(int num);
	
	
	

	

	
}