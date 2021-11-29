package com.ja.webproject.mypage.mapper;

import com.ja.webproject.vo.HE_MailAuthVo;
import com.ja.webproject.vo.HE_MemberVo;

public interface MyPageSQLMapper {
	
	//=====Id 수정시 
	public void editMyId(HE_MemberVo vo);
	//=====NickName 수정시 
	public void editMyNick(HE_MemberVo vo);
	//=====birth 수정시 
	public void editMyBirth(HE_MemberVo vo);
	//=====petName 수정시 
	public void editMyPetName(HE_MemberVo vo);
	//=====address 수정시 
	public void editMyAddress(HE_MemberVo vo);
	
	//=====비밀번호 수정 전에 다시 입력 받기 
	public int checkBeforePw(HE_MemberVo vo);
	//=====비밀번호 수정시
	public void editMyPw(HE_MemberVo vo);
	
	//=====email 수정시
	//=====email 수정 전에 => 인증 메일 확인
	public void certifyEditMail(String mail_key);
	
	public void editMyEmail(HE_MemberVo vo);
	public void changeMailAuthInfo(HE_MailAuthVo mailAuthVo);
	

	

}
