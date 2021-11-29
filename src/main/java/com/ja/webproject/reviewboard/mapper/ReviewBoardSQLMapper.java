package com.ja.webproject.reviewboard.mapper;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_Species_CategoryVo;
import com.ja.webproject.vo.HE_ReviewBoardVo;
import com.ja.webproject.vo.HE_ReviewBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_ReviewBoard_CommentVo;

public interface ReviewBoardSQLMapper {

	public int createBoardPK();

	public ArrayList<HE_ReviewBoardVo> getContents(

			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);

	public int getContentCount(
			
			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);
	
	
	//===============본인이 쓴 reviewBoard 게시글 리스트 가져오기
	public ArrayList<HE_ReviewBoardVo> getMyReviewBoardNo(int member_no);
	

	public void writeContent(HE_ReviewBoardVo vo);

	public void registerImage(HE_ReviewBoard_ImageBoardVo vo);

	public void increaseReadCount(int reviewboard_no);

	public HE_ReviewBoardVo getContentByNo(int reviewboard_no);
	

	public ArrayList<HE_ReviewBoard_ImageBoardVo> getImageInfoByBoardNo(int reviewboard_no);

	public ArrayList<HE_ReviewBoard_CommentVo> readComment(int reviewboard_no);
	//===============추천============================================================
	
	public void doRecommend(@Param("reviewboard_no") int reviewboard_no,@Param("member_no") int member_no);//추천하기
	
	public void cancelRecommend(@Param("reviewboard_no") int board_no,@Param("member_no") int member_no);//추천해제
	
	public int getTotalRecommendCount(int reviewboard_no); //글 총 추천수
	
	public int getMyRecommendCount(@Param("reviewboard_no") int reviewboard_no,@Param("member_no") int member_no); //내가 추천 하였는가
	//=============================================================================
		
	public void writeComment(HE_ReviewBoard_CommentVo vo);
	
	public void updateContent(HE_ReviewBoardVo param);

	public void deleteContent(int reviewboard_no);

	public int CommentCount(int reviewboard_no);

	public void deleteComment(HE_ReviewBoard_CommentVo vo);
	
	public void updateComment(HE_ReviewBoard_CommentVo vo);
	
	public HE_ReviewBoard_ImageBoardVo getImageForList(int reviewboard_no);
	
	//=============================================================================
	//=========================LostdogBoard & ReviewBoard matching system


}
