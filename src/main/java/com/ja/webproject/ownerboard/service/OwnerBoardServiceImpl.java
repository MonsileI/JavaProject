package com.ja.webproject.ownerboard.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.member.service.MemberServiceImpl;
import com.ja.webproject.ownerboard.mapper.OwnerBoardSQLMapper;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_NoteBoxVo;
import com.ja.webproject.vo.HE_OwnerBoardVo;
@Service
public class OwnerBoardServiceImpl {

	
		@Autowired // DI(setter 주입)
		private OwnerBoardSQLMapper ownerBoardSQLMapper;
		
		@Autowired 
		private MemberSQLMapper memberSQLMapper;
		
		@Autowired 
		private MemberServiceImpl memberServiceImpl;
		
	//==============
	public void requestCheckMyDog(HE_OwnerBoardVo ownerVo) {
		
		ownerBoardSQLMapper.requestCheckMyDog(ownerVo);
	}
	
	
	//================
	public ArrayList<HE_MemberVo> getNoteList(int finddogboard_no){
		
		ArrayList<HE_MemberVo> memberVoList = new ArrayList<HE_MemberVo>();
		
		ArrayList<Integer> memberNoList = ownerBoardSQLMapper.getNoteList(finddogboard_no);

		System.out.println(memberNoList.size());
		
		for(Integer memberNo : memberNoList) {
			System.out.println("memberNo:"+memberNo);
			 HE_MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
			 
			 memberVoList.add(memberVo);
		}
		
		
		return memberVoList;
	}
	
	//===========
	public void finalStep(HE_OwnerBoardVo vo) {
		//System.err.println("finalStep_service"+vo.getMember_no());
		
		if(vo.getMember_no() != 0){
			ownerBoardSQLMapper.finalStep(vo);
			
			int member_no = vo.getMember_no();
			int finddogboard_no = vo.getFinddogboard_no();
			String content =  "../finddogboard/readHE_FinddogPage.do?finddogboard_no=" + finddogboard_no;
			//"../reviewboard/"
			
			
			HE_NoteBoxVo noteVo = new HE_NoteBoxVo();
			noteVo.setFriend_no(member_no);
			noteVo.setMember_no(1);
			noteVo.setContent("후기는 큰 도움이 됩니다! 내 글 보기 : " + content);
			memberServiceImpl.sendNote(noteVo);
			
		}
		
		
	}
	
	 public void cancelFinalStep(HE_OwnerBoardVo vo) {
		 ownerBoardSQLMapper.cancelFinalStep(vo);
	 }
	

}