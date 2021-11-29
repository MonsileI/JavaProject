package com.ja.webproject.healingboard.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;


import com.ja.webproject.vo.HE_HealingBoardVo;
import com.ja.webproject.vo.HE_HealingBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_HealingBoard_CommentVo;

public interface HealingBoardSQLMapper {

	public int createBoardPK();

	public ArrayList<HE_HealingBoardVo> getContents(

			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);

	public int getContentCount(
			
			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);
	
	
	//===============본인이 쓴 HealingBoard 게시글 리스트 가져오기
	public ArrayList<HE_HealingBoardVo> getMyHealingBoardNo(int member_no);
	

	public void writeContent(HE_HealingBoardVo vo);

	public void registerImage(HE_HealingBoard_ImageBoardVo vo);

	public void increaseReadCount(int healingboard_no);

	public HE_HealingBoardVo getContentByNo(int healingboard_no);
	

	public ArrayList<HE_HealingBoard_ImageBoardVo> getImageInfoByBoardNo(int healingboard_no);

	public ArrayList<HE_HealingBoard_CommentVo> readComment(int healingboard_no);
	//===============추천============================================================
	
	public void doRecommend(@Param("healingboard_no") int healingboard_no,@Param("member_no") int member_no);//추천하기
	
	public void cancelRecommend(@Param("healingboard_no") int board_no,@Param("member_no") int member_no);//추천해제
	
	public int getTotalRecommendCount(int healingboard_no); //글 총 추천수
	
	public int getMyRecommendCount(@Param("healingboard_no") int healingboard_no,@Param("member_no") int member_no); //내가 추천 하였는가
	//=============================================================================
		
	public void writeComment(HE_HealingBoard_CommentVo vo);
	
	public void updateContent(HE_HealingBoardVo param);

	public void deleteContent(int healingboard_no);

	public int CommentCount(int healingboard_no);

	public void deleteComment(HE_HealingBoard_CommentVo vo);
	
	public void updateComment(HE_HealingBoard_CommentVo vo);
	
	public HE_HealingBoard_ImageBoardVo getImageForList(int healingboard_no);
	
	//=============================================================================
	//=========================LostdogBoard & HealingBoard matching system


}
