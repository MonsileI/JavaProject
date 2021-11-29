package com.ja.webproject.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.mypage.mapper.MyPageSQLMapper;
import com.ja.webproject.vo.HE_MailAuthVo;
import com.ja.webproject.vo.HE_MemberVo;

@Service
public class MyPageServiceImpl {
	
	@Autowired
	public MyPageSQLMapper myPageSQLMapper;
	
	//=====Id 수정시 
	public void editMyId(HE_MemberVo vo) {
		//System.out.println("service:"+vo.getId()+","+vo.getMember_no());
		myPageSQLMapper.editMyId(vo);
	}
	
	//=====NickName 수정시 
	public void editMyNick(HE_MemberVo vo) {
		//System.out.println("service:"+vo.getNick()+","+vo.getMember_no());
		myPageSQLMapper.editMyNick(vo);
	}
	
	//=====birth 수정시 
	public void editMyBirth(HE_MemberVo vo) {
		//System.out.println("service:"+vo.getBirth()+","+vo.getMember_no());
		myPageSQLMapper.editMyBirth(vo);
	}
	
	//=====petName 수정시 
	public void editMyPetName(HE_MemberVo vo) {
		//System.out.println("service:"+vo.getPetName()+","+vo.getMember_no());
		myPageSQLMapper.editMyPetName(vo);
	}
	
	//=====address 수정시 
	public void editMyAddress(HE_MemberVo vo) {
		
		myPageSQLMapper.editMyAddress(vo);
		
	}
	
	//=====비밀번호 수정 전에 다시 입력 받기 
	public int checkBeforePw(HE_MemberVo vo) {
		
		int result = myPageSQLMapper.checkBeforePw(vo);
		System.out.println("service:"+result);
		return result;
	}
	
	//=====비밀번호 수정시 
	public void editMyPw(HE_MemberVo vo) {
		//System.out.println("service:"+vo.getPw()+","+vo.getMember_no());
		myPageSQLMapper.editMyPw(vo);
	}
	
	//=====email 수정 전에 => 인증 메일 확인
	public void certifyEditMail(String mail_key) {
		
		myPageSQLMapper.certifyEditMail(mail_key);
	}
	
	//=====email 수정시 
	public void editMyEmail(HE_MemberVo vo, HE_MailAuthVo mailAuthVo) {
		

		int member_no = vo.getMember_no();
		mailAuthVo.setMember_no(member_no);
		
		myPageSQLMapper.editMyEmail(vo);
		myPageSQLMapper.changeMailAuthInfo(mailAuthVo);
	}
	

}
