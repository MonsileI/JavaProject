package com.ja.webproject.chattingboard.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ja.webproject.vo.HE_ChattingBoardVo;
import com.ja.webproject.vo.HE_ChattingRoomBoardVo;


public interface ChattingBoardSQLMapper {
	
	public ArrayList<HE_ChattingBoardVo> getChattingContents(
			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);

	
		public int getChattingContentCount(
			
			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);

		//===================채팅방 개설=====================
		public void MakeChattingProcess(HE_ChattingBoardVo vo);
		
		//===================채팅방 자동 접속==================
		
		public int joinMyChattingRoom(int member_no);
		
		//===================채팅 입력=======================
		public void writeChattingProcess(HE_ChattingRoomBoardVo vo);
		
		//==================채팅방 참가======================
		public HE_ChattingBoardVo joinChattingRoom(int chattingboard_no);
		
		//===================채팅글 보기=====================
		public ArrayList<HE_ChattingRoomBoardVo> getChattingList(int chattingboard_no);
		
		//===================글 지우기======================
		public void deleteChatting(int chattingroomboard_no);
		
		//==================채팅방 나가기====================
		public void exitChattingRoom(HE_ChattingRoomBoardVo vo);
		
		//==================채팅방 확인=====================
		public int checkChattingRoomStatus(int chattingboard_no);
		
		//===================채팅방 삭제====================
		public void deleteChattingRoom(int chattingboard_no);
		
		//===================채팅방 comment 삭제====================
		public void deleteChattingComment(int chattingboard_no);

}
