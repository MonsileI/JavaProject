package com.ja.webproject.chattingboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.chattingboard.mapper.ChattingBoardSQLMapper;
import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.vo.HE_ChattingBoardVo;
import com.ja.webproject.vo.HE_ChattingRoomBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_CommentVo;
import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_LostDogBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_MemberVo;

@Service
public class ChattingBoardServiceImpl {

	@Autowired
	public ChattingBoardSQLMapper chattingBoardSQLMapper;
	
	@Autowired
	public MainSQLMapper mainSQLMapper;
	
	
	
	public ArrayList<HashMap<String,Object>> getChattingContents(String search_type, String search_word,int page_number) {
			
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			
			
			ArrayList<HE_ChattingBoardVo> boardList = chattingBoardSQLMapper.getChattingContents(search_type, search_word, page_number);
			
			 
			for(HE_ChattingBoardVo boardVo : boardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
				
				
			
				int memberNo = boardVo.getMember_no(); //멤버 테이블 기준 프라이머리 키(보드 기준 foreign key)로 뽑아줌
				HE_MemberVo memberVo =  mainSQLMapper.getMemberByNo(memberNo); //멤버 넘버는 같기 때문에 조인이 되버림(나올때마다)
						//지금 여긴 memberNo에 해당하는 회원 정보가 담겨있음
				
				HashMap<String, Object> map = new HashMap<String, Object>();//결합되어야 하는 정보가 멤버와 보드이기 때문에 object 타입
				//돌때마다 하나씩 해쉬맵 생성
				
				map.put("memberVo", memberVo);
				map.put("boardVo", boardVo);
				
				
			
			
				
				list.add(map);
			
			
			}
			
			return list;
			
			
		}
	
	
	public int getChattingContentCount(String search_type, String search_word, int page_number){
		int count = chattingBoardSQLMapper.getChattingContentCount(search_type, search_word, page_number);
		return count;
		
	}
	
	
	
	//=========================채팅방 개설===============================
	
	public void MakeChattingProcess(HE_ChattingBoardVo vo) {
		
		
		chattingBoardSQLMapper.MakeChattingProcess(vo);
		
		
	}
	
	//====================채팅방 자동 입장=================================
	
	public int joinMyChattingRoom(int member_no) {
		
		return chattingBoardSQLMapper.joinMyChattingRoom(member_no);
		
		
	}
	
	//=====================채팅 입력==================================
	
	
	public void writeChattingProcess(HE_ChattingRoomBoardVo vo) {
		
		chattingBoardSQLMapper.writeChattingProcess(vo);
		
	}
	
	
	//=====================채팅방 참여하기===============================
	
	
	public HashMap<String, Object> joinChattingRoom(int chattingboard_no) {
		
		HE_ChattingBoardVo boardVo = chattingBoardSQLMapper.joinChattingRoom(chattingboard_no);
		
		
		int member_no = boardVo.getMember_no();
		HE_MemberVo memberVo = mainSQLMapper.getMemberByNo(member_no);
		
		
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		map.put("memberVo", memberVo);
		map.put("boardVo", boardVo);
		
		
		
		return map;
	}


	public void deleteChatting(int chattingroomboard_no) {
	chattingBoardSQLMapper.deleteChatting(chattingroomboard_no);
	
	}

		//=====================채팅글 불러오기==================
	
	public ArrayList<HashMap<String, Object>> getChattingList (int chattingboard_no){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>> ();
		
		ArrayList<HE_ChattingRoomBoardVo> commentList = chattingBoardSQLMapper.getChattingList(chattingboard_no);
		
		for(HE_ChattingRoomBoardVo commentVo : commentList) {
			int member_no = commentVo.getMember_no();
			
			HE_MemberVo memberVo = mainSQLMapper.getMemberByNo(member_no);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			map.put("commentVo", commentVo);
			
			list.add(map);
			
			
		}
		
		return list;
		
		
	}

		//=========================채팅방 나가기============================

	public void exitChattingRoom(HE_ChattingRoomBoardVo vo) {
		
			chattingBoardSQLMapper.exitChattingRoom(vo);
			
			//==========채팅방 나갔을 때, 누군가 있는지 없는지 확인=======
			
			int chatting_no = vo.getChattingboard_no();
			int check = chattingBoardSQLMapper.checkChattingRoomStatus(chatting_no);
			
			//==========아무도 없으면 채팅방 삭제==============
			if(check == 0) {
				
				chattingBoardSQLMapper.deleteChattingRoom(chatting_no);
				
				//===================채팅방 comment 삭제====================
				chattingBoardSQLMapper.deleteChattingComment(chatting_no);
				
			}
			
			
	};


	
}
