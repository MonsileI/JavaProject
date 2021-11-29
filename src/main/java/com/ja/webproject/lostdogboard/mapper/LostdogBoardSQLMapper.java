package com.ja.webproject.lostdogboard.mapper;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.ja.webproject.vo.HE_LostdogBoard_CommentVo;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_CommentVo;
import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_LostDogBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_LostdogBoard_LikeVo;

public interface LostdogBoardSQLMapper {

	
	public int createBoardPK();
	
public ArrayList<HE_LostDogBoardVo>getContents(
			
			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,  
			@Param("page_number") int page_number);  

public int getContentCount(
		@Param("search_type") String search_type, 
		@Param("search_word") String search_word, 
		@Param("page_number") int page_number);


public void writeContent(HE_LostDogBoardVo vo);

public void registerImage(HE_LostDogBoard_ImageBoardVo vo);

public void increaseReadCount(int lostdogboard_no);

public HE_LostDogBoardVo getContentByNo(int lostdogboard_no);

public ArrayList<HE_LostDogBoard_ImageBoardVo> getImageInfoByBoardNo(int lostdogboard_no);


public HE_LostDogBoard_ImageBoardVo getImageForList(int lostdogboard_no);

/*
///==================================취소 버튼 기능 없애기로!!!=================================================
//==================권한 있는 자가 취소 버튼 눌렀을 때, status='N'로 변경 
public void cancelLostdog(int lostdogboard_no);
*/

//==================권한 있는 자가 완료 버튼 눌렀을 떄, status='Y'로 변경
public void completeLostdog(HE_LostDogBoardVo vo);

//===============추천============================================================

public void doRecommend(@Param("lostdogboard_no") int lostdogboard_no,@Param("member_no") int member_no);//추천하기

public void cancelRecommend(@Param("lostdogboard_no") int lostdogboard_no,@Param("member_no") int member_no);//추천해제

public int getTotalRecommendCount(int lostdogboard_no); //글 총 추천수

public int getMyRecommendCount(@Param("lostdogboard_no") int lostdogboard_no,@Param("member_no") int member_no); //내가 추천 하였는가

//=============================================================================

public void updateContent(HE_LostDogBoardVo param);

public void deleteContent(int lostdogboard_no);

//=======================댓글 Ajax===================================================	

	public void writeComment(HE_LostdogBoard_CommentVo vo);
	
	public ArrayList<HE_LostdogBoard_CommentVo> getCommentList(int board_no);
	
	public void deleteComment(int comment_no);
	
	public void updateComment(HE_LostdogBoard_CommentVo vo);
	
	public ArrayList<HE_LostdogBoard_CommentVo> readComment(int board_no);
	


//=============================================================================
//=========================LostdogBoard & FinddogBoard matching system

/*public HE_FinddogBoardVo getMatchingDog(
		@Param("species_no") int species_no,
		@Param("lostDate") Date lostDate);
		*/

public ArrayList<HE_FinddogBoardVo> getMatchingDog(HE_LostDogBoardVo vo);	


}

