package com.ja.webproject.shop.mapper;

import com.ja.webproject.vo.HE_MailAuthVo;
import com.ja.webproject.vo.HE_MemberVo;

public interface ShopSQLMapper {
	
	//프라이머리키
	public int createMemberPK();
	
	//로그인
	public HE_MemberVo getMemberByIdAndPw(HE_MemberVo param);
	
	//회원가입
	public void joinMember(HE_MemberVo vo);
	
	//조인
	public HE_MemberVo getMemberByNo(int no);

	
	//===============MailAuth table(메일 인증 관련)
	
	//insert
	public void createMailAuthInfo(HE_MailAuthVo vo);
	
	//update
	public void certifyMail(String mail_key);
	
	public HE_MemberVo getMember(int member_no);
	
	

}
