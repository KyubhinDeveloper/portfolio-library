package com.library.service;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.MemberMapper;
import com.library.vo.MemberVo;
import com.library.vo.MemoVo;

import lombok.extern.java.Log;


@Log
@Service
@Transactional
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	private JavaMailSender javaMailSender;
	
    public MemberService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }
    
	public void sendEmail(String toEmail, String subject, String message) throws MessagingException {
		
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "utf-8");
		
		helper.setFrom("규빈개발자 도서관 <lve2514@gmail.com>");
		helper.setTo(toEmail);
		helper.setSubject(subject);
		helper.setText(message, true);
		
		javaMailSender.send(mimeMessage);
	
	} //sendEmail()
	
	public void join(MemberVo memberVo) {
		memberMapper.join(memberVo);
	} //join()
	
	public void updateInfo(MemberVo memberVo) {
		memberMapper.updateInfo(memberVo);
	} //updateInfo()
	
	public void updatePwd(String id, String password) {
		memberMapper.updatePwd(id, password);
	} //updatePwd()
	
	public void updateLoanCnt(String id) {
		memberMapper.updateLoanCnt(id);
	} //updateLoanCnt()
    
	public boolean idDupCheck(String id) {
		
		boolean checkResult;
		
		int count = memberMapper.countCheckById(id);
		
		if(count == 1) {
			
			checkResult = true;
		} else {
			checkResult = false;
		}
		
		return checkResult;
	} //idDupCheck()
	
	public boolean emailDupCheck(String email) {
		
		boolean checkResult;
		
		int count = memberMapper.countCheckByEmail(email);
		
		if(count == 1) {
			
			checkResult = true;
		} else {
			checkResult = false;
		}
		
		return checkResult;
	} //emailDupCheck()
	
	public int getSearchCount(String category, String search, String grade) {
		
		int searchCount = memberMapper.getSearchCount(category, search, grade);
		
		return searchCount;
	} //getSearchCount()
	
	public int getTotalCount() {
		int totalCount = memberMapper.getTotalCount();
		
		return totalCount;
	} //getTotalCount()
	
	public int getTodayJointCnt(String today) { //cnt == count
		int todayMemeberCnt = memberMapper.getTodayJointCnt(today);
		return todayMemeberCnt;
	} //getTodayMemberCnt()
	
	public List<MemberVo> getMemberList(int startRow, int rowCount, String category, String search, String grade) {
		
		List<MemberVo> memberList = memberMapper.getMemberList(startRow, rowCount, category, search, grade);
				
		return memberList;
		
	} //getMeberList()
	
	public MemberVo getInfoById(String id) {
		
		MemberVo memberVo = memberMapper.getInfoById(id);
		
		return memberVo;	
	} //getInfoById()
	
	public String getPasswordById(String id) {
		
		String dbPwd = memberMapper.getPasswordById(id);
		
		return dbPwd;
	} //getPasswordById()
	
	public String getGradeById(String id) {
		
		String grade = memberMapper.getGradeById(id);
		
		return grade;
	} //getGradeById()
	
	public String getNameById(String id) {
		
		String name = memberMapper.getNameById(id);
		
		return name;
	} //getNameById()
	
	public List<MemoVo> getMemoList(String id) {
		
		List<MemoVo> memo = memberMapper.getMemoList(id);
		
		return memo;
	} //getMemoList()
	
	public List<MemberVo> getLankingList(int listCount) {
		
		List<MemberVo> lankingList = memberMapper.getLankingList(listCount);
		
		return lankingList;
	} //getLankingList()
	
	public void changeGrade(String id, String grade) {
		
		if(grade.equals("normal")) {
			
			memberMapper.changeGrade(id,"vip");
			
		} else if(grade.equals("vip")) {
			
			memberMapper.changeGrade(id,"normal");
		} 
	}//chageGrade()
	
	public Integer loginCheck(String id, String password){
		
		// -1: 아이디 없음, 0: 비밀번호 틀림, 1: 아이디 비밀번호 일치
		Integer check;	
		String dbPwd = memberMapper.getPasswordById(id);
		
		log.info(password);
		log.info(dbPwd);
		
		if(dbPwd != null) {
			if(password.equals(dbPwd)) {
				check = 1;
			} else {
				check = 0;
			}
		} else {
			check = -1;
		}
		
		return check;
	} //loginCheck()
	
	public Boolean pwdCheckById(String id, String nowPwd) {
		
		Boolean result;
		String pwd = memberMapper.getPasswordById(id);
		
		if(nowPwd.equals(pwd)) {
			result = true;
		} else {
			result = false;
		}
		
		return result;
	} //pwdCheck()
	
	public void secession(String id){
		
		memberMapper.secession(id);
	} //secession()
	
	public void registMemo(MemoVo memoVo){
	
		memberMapper.registMemo(memoVo);
	} //registMemo()
	
	public void deleteMemo(int num){
		
		memberMapper.deleteMemo(num);
	} //deleteMemo()
}