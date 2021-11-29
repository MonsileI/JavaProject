package com.ja.webproject.main.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MailAuthVo;
import com.ja.webproject.vo.HE_MemberVo;

public interface MainSQLMapper {
	
	//==============메인에서 불러올 data(finddogboardList)
	public ArrayList<HE_FinddogBoardVo> getMainFinddogBoard();
	
	//===============로그인
	public HE_MemberVo getMemberByIdAndPw(HE_MemberVo param);
	
	
	//===============회원가입 
	public int createMemberPK();
	
	//insert
	public void joinMember(HE_MemberVo vo);

	
	//===============MailAuth table(메일 인증 관련)
	
	//insert
	public void createMailAuthInfo(HE_MailAuthVo vo);
	
	//update
	public void certifyMail(String mail_key);
	
	public void addInitGroup(
			@Param("member_no") int member_no, 
			@Param("group_name") String group_name);
	
	
	//================************
	//================finddogBoard에서 불러옴 
	//HE_BOard멤버값 받기
	public HE_MemberVo getMemberByNo(int member_no);
	

}
