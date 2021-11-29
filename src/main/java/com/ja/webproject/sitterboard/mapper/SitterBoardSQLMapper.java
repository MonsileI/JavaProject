package com.ja.webproject.sitterboard.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_CommentVo;
import com.ja.webproject.vo.HE_SitterBoard_ImageBoardVo;

public interface SitterBoardSQLMapper {

	public int createBoardPK();

	public ArrayList<HE_SitterBoardVo> getContents(

			@Param("search_type") String search_type, @Param("search_word") String search_word,
			@Param("page_number") int page_number);

	public int getContentCount(

			@Param("search_type") String search_type, @Param("search_word") String search_word,
			@Param("page_number") int page_number);

	public void writeContent(HE_SitterBoardVo vo);

	public void registerImage(HE_SitterBoard_ImageBoardVo vo);

	public void increaseReadCount(int sitterboard_no);

	public HE_SitterBoardVo getContentByNo(int sitterboard_no);

	public ArrayList<HE_SitterBoard_ImageBoardVo> getImageInfoByBoardNo(int sitterboard_no);

	public ArrayList<HE_SitterBoard_CommentVo> readComment(int sitterboard_no);

	public void writeComment(HE_SitterBoard_CommentVo vo);

	// ===============추천============================================================

	public void doRecommend(@Param("sitterboard_no") int sitterboard_no, @Param("member_no") int member_no);// 추천하기

	public void cancelRecommend(@Param("sitterboard_no") int board_no, @Param("member_no") int member_no);// 추천해제

	public int getTotalRecommendCount(int sitterboard_no); // 글 총 추천수

	public int getMyRecommendCount(@Param("sitterboard_no") int sitterboard_no, @Param("member_no") int member_no); // 내가
																													// 추천
																													// 하였는가

	// =============================================================================

	public void updateContent(HE_SitterBoardVo param);

	public void deleteContent(int sitterboard_no);

	public int CommentCount(int sitterboard_no);

	public void deleteComment(HE_SitterBoard_CommentVo vo);

	public void updateComment(HE_SitterBoard_CommentVo vo);

	public HE_SitterBoard_ImageBoardVo getImageForList(int sitterboard_no);

	// ==============================시터했던
	// 횟수============================================

	public ArrayList<Integer> sitterboardCount(int member_no);

	public int sitterCount(int sitterboard_no);

}