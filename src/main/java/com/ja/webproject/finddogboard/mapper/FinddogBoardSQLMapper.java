package com.ja.webproject.finddogboard.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_ProcessVo;
import com.ja.webproject.vo.HE_Species_CategoryVo;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_CommentVo;

public interface FinddogBoardSQLMapper {

	public int createBoardPK();

	public ArrayList<HE_FinddogBoardVo> getContents(

			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);

	public int getContentCount(
			
			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);
	
	public ArrayList<HE_Species_CategoryVo> getSpeciesCategoryList();
	
	//===============본인이 쓴 finddogBoard 게시글 리스트 가져오기
	public ArrayList<HE_FinddogBoardVo> getMyFinddogBoardNo(int member_no);
	
	//===============myPage에서 시터 신청 목록 보여줄 때,finddogBoard 글이 원래 내 글이었는 지 체크
	public int checkMyFinddogBoard(
			@Param("finddogboard_no") int finddogboard_no,
			@Param("member_no") int member_no);

	public void writeContent(HE_FinddogBoardVo vo);

	public void registerImage(HE_FinddogBoard_ImageBoardVo vo);

	public void increaseReadCount(int finddogboard_no);

	public HE_FinddogBoardVo getContentByNo(int finddogboard_no);
	
	//===============finddogBoard 버튼 권한
	public HE_SitterBoard_ProcessVo grantAuthority(int finddogboard_no);
	public HE_SitterBoardVo getMemberNo_havingAuthority(int sitterboard_no);
	
	/*
	//============================취소버튼 기능 없애기로!!!==========================================
	//==================권한 있는 자가 취소 버튼 눌렀을 때, status='N'로 변경 
	public void cancelFinddog(int finddogboard_no);
	*/
	
	//==================권한 있는 자가 완료 버튼 눌렀을 떄, status='Y'로 변경
	public void completeFinddog(HE_FinddogBoardVo vo);

	public ArrayList<HE_FinddogBoard_ImageBoardVo> getImageInfoByBoardNo(int finddogboard_no);
	
	public HE_FinddogBoard_ImageBoardVo getImageForList(int finddogboard_no);
	
	//===============추천============================================================
	
	public void doRecommend(@Param("finddogboard_no") int finddogboard_no,@Param("member_no") int member_no);//추천하기
	
	public void cancelRecommend(@Param("finddogboard_no") int board_no,@Param("member_no") int member_no);//추천해제
	
	public int getTotalRecommendCount(int finddogboard_no); //글 총 추천수
	
	public int getMyRecommendCount(@Param("finddogboard_no") int finddogboard_no,@Param("member_no") int member_no); //내가 추천 하였는가
	
	//=============================================================================
	
	public void updateContent(HE_FinddogBoardVo param);

	public void deleteContent(int finddogboard_no);
	
	//=======================댓글 Ajax===================================================
	
	public ArrayList<HE_FinddogBoard_CommentVo> readComment(int finddogboard_no);

	public void writeComment(HE_FinddogBoard_CommentVo vo);

	public ArrayList<HE_FinddogBoard_CommentVo> getCommentList(int board_no);

	public void deleteComment(int comment_no);

	public void updateComment(HE_FinddogBoard_CommentVo vo);

	//=============================================================================
	//=========================LostdogBoard & FinddogBoard matching system

	public ArrayList<HE_LostDogBoardVo> getMatchingDog(HE_FinddogBoardVo vo);	

}
