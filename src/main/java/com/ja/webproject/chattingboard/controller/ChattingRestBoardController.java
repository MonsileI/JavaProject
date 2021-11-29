package com.ja.webproject.chattingboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.chattingboard.service.ChattingBoardServiceImpl;
import com.ja.webproject.vo.HE_ChattingRoomBoardVo;
import com.ja.webproject.vo.HE_MemberVo;

@RequestMapping("/chattingboard/*")
@RestController
public class ChattingRestBoardController {
	
	@Autowired
	public ChattingBoardServiceImpl chattingBoardServiceImpl;
	
	
	//채팅쓰기
	@RequestMapping("writeChattingProcess.do")
	public void writeChattingProcess(HE_ChattingRoomBoardVo vo, HttpSession session) {
		
		
		HE_MemberVo sessionUser = (HE_MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		

		vo.setMember_no(member_no);
		
		
		chattingBoardServiceImpl.writeChattingProcess(vo);
		
		
	}
	
	
	//채팅글 보기
	@RequestMapping("getChattingList.do")
	public ArrayList<HashMap<String, Object>>getChattingList(int chattingboard_no){
		
		
		ArrayList<HashMap<String, Object>> list = chattingBoardServiceImpl.getChattingList(chattingboard_no);
		
		return list;
		
		
	}

	
	@RequestMapping("deleteChatting.do")
	public void deleteChatting(int chattingroomboard_no) {
		
		
		chattingBoardServiceImpl.deleteChatting(chattingroomboard_no);
		
	}
	
}
