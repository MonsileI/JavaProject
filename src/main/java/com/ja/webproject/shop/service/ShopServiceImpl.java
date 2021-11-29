package com.ja.webproject.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.commons.MessageDigestUtil;
import com.ja.webproject.shop.mapper.ShopSQLMapper;
import com.ja.webproject.vo.HE_MailAuthVo;
import com.ja.webproject.vo.HE_MemberVo;
@Service
public class ShopServiceImpl {

	@Autowired // DI(setter 주입)
	private ShopSQLMapper shopSQLMapper;
	
	public HE_MemberVo login(HE_MemberVo param) {
		//입력받은 비번 해쉬코드로 변경 후 select Member
		String hashCode = MessageDigestUtil.getPasswordHashCode(param.getPw());
		param.setPw(hashCode);
		
		HE_MemberVo result = shopSQLMapper.getMemberByIdAndPw(param);
		
		System.out.println(param.getId());
		return result;
		
	}
	
	public void joinMember(HE_MemberVo vo, HE_MailAuthVo mailAuthVo) {

		int member_no = shopSQLMapper.createMemberPK(); //pk 값을 먼저 생성
		vo.setMember_no(member_no); //pk 값을 먼저 세팅

		//비밀번호 해쉬값 획득 및 변경
		String hashCode = MessageDigestUtil.getPasswordHashCode(vo.getPw());
		vo.setPw(hashCode);

		shopSQLMapper.joinMember(vo);

		mailAuthVo.setMember_no(member_no);
		shopSQLMapper.createMailAuthInfo(mailAuthVo);
	}
	
	public void certifyMail(String key) {
		shopSQLMapper.certifyMail(key);
	}

}