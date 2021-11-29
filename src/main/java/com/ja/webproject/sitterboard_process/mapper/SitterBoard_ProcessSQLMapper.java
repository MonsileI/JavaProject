package com.ja.webproject.sitterboard_process.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_ProcessVo;


public interface SitterBoard_ProcessSQLMapper {
	
	//==========================================================================================시터보드게시판의 신청글 클릭시==================================================
	public int checkSitterRequest(HE_SitterBoard_ProcessVo vo);
	public void sitterRequest(HE_SitterBoard_ProcessVo vo);
	
	
	//========================================================================마이페이지에서 시터게시판 볼때(신청)================================================================
	public ArrayList<HE_SitterBoard_ProcessVo> sitterRequestListPage(int member_no);
	//=======================신청 취소
	public void cancelSitterRequest(int no);
	
	
	//========================================================================마이페이지에서 시터게시판 볼때(수락)================================================================
	public ArrayList<HE_SitterBoardVo> getMySitterBoardList(HE_MemberVo vo);
	public ArrayList<HE_SitterBoard_ProcessVo> sitterAcceptListPage(HE_SitterBoardVo vo);
	
	//=======================수락 거절
	public void cancelSitterAccept(int no);
	
	
	//========================================================================수락버튼 클릭 시, status 변경 ========================================================================
	
	//=======================1. sitterboard에 글 올린 시터인 사람이 여러 사람으로부터 신청받은 경우, 해당 수락한 글 제외하고 거절상태로 변경
	public void change_StatusNo_AcceptAll(int sitterboard_no);

	
	//=======================2. finddogBoard에 글 올린 사람이 여러 시터에게 신청한 경우, 해당 수락한 시터 제외하고 거절상태로 변경
	public void change_StatusYes_Accept(HE_SitterBoard_ProcessVo vo);

	public void change_StatusNo_RequestAll(HE_SitterBoard_ProcessVo vo);
	
	//============================ 견추적
	public ArrayList<HE_SitterBoard_ProcessVo> getFinddogHistory(int finddogboard_no);
	
	//============================ mypage - 견추적
	public ArrayList<HE_SitterBoard_ProcessVo> getMyDogHistory(
					@Param("member_no") int member_no,
					@Param("page_number") int page_number);
	
	
	public int getMyDogHistoryCount(
			@Param("member_no") int member_no, 
			@Param("page_number") int page_number);
	
	//==============3.sitterboard 신청버튼 disable -> 
	//내가 작성한 sitterboard 글로인해 받은 요청을 수락한 경우, 해당 글에서는 신청 받지 않기로!(버튼 작동 멈추게하려고)
	//public ArrayList<HE_SitterBoardVo> checkMySitterBoardBtn();


}
