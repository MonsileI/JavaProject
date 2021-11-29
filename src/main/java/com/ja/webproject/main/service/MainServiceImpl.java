package com.ja.webproject.main.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.commons.MessageDigestUtil;
import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MailAuthVo;
import com.ja.webproject.vo.HE_MemberVo;

@Service
public class MainServiceImpl {

	@Autowired // DI(setter 주입)
	private MainSQLMapper mainSQLMapper;

	
	// ==============메인에서 불러올 data(finddogboardList)
	public ArrayList<HashMap<String, Object>> getMainFinddogBoard() {

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		ArrayList<HE_FinddogBoardVo> boardList = mainSQLMapper.getMainFinddogBoard();

		for (HE_FinddogBoardVo boardVo : boardList) { // 보드 글 수만큼 돌거야 for문으로 ㅇㅋ?

			int memberNo = boardVo.getMember_no(); // 멤버 테이블 기준 프라이머리 키(보드 기준 foreign key)로 뽑아줌
			HE_MemberVo memberVo = mainSQLMapper.getMemberByNo(memberNo); // 멤버 넘버는 같기 때문에 조인이 되버림(나올때마다)
			// 지금 여긴 memberNo에 해당하는 회원 정보가 담겨있음

			HashMap<String, Object> map = new HashMap<String, Object>();// 결합되어야 하는 정보가 멤버와 보드이기 때문에 object 타입
			// 돌때마다 하나씩 해쉬맵 생성

			map.put("memberVo", memberVo);
			map.put("boardVo", boardVo);
			// 돌때마다 memberVo값과 boardVo값을 넣어줌.

			list.add(map);
			// 같은 멤버넘버인 memberVo랑 boardVo랑 결합해서 넣어줌.

			// 즉, member_no가 같은 memberVo와 BoardVo를 결합하는 로직이지!

		}

		return list;

	}

	// ===============HE_Member_seq
	public int createMemberPK() {
		int member_no = mainSQLMapper.createMemberPK();

		return member_no;
	}

	/*
	 * public int getMemberById(String id){ return mainSQLMapper.getMemberById(id);
	 * }
	 */

	//
	public HE_MemberVo login(HE_MemberVo param) {
		// 입력받은 비번 해쉬코드로 변경 후 select Member
		String hashCode = MessageDigestUtil.getPasswordHashCode(param.getPw());
		param.setPw(hashCode);

		HE_MemberVo result = mainSQLMapper.getMemberByIdAndPw(param);

		System.out.println(param.getId());
		return result;

	}

	public void joinMember(HE_MemberVo vo, HE_MailAuthVo mailAuthVo) {

		int member_no = mainSQLMapper.createMemberPK(); // pk 값을 먼저 생성
		vo.setMember_no(member_no); // pk 값을 먼저 세팅

		// 비밀번호 해쉬값 획득 및 변경
		String hashCode = MessageDigestUtil.getPasswordHashCode(vo.getPw());
		vo.setPw(hashCode);

		mainSQLMapper.joinMember(vo);

		mailAuthVo.setMember_no(member_no);
		mainSQLMapper.createMailAuthInfo(mailAuthVo);

		// 회원 가입 시, 주소록 기본그룹 추가
		String group_name = "기본";
		mainSQLMapper.addInitGroup(member_no, group_name);

	}

	public void certifyMail(String key) {
		mainSQLMapper.certifyMail(key);
	}

}