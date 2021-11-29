package com.ja.webproject.articleboard.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;


import com.ja.webproject.vo.HE_ArticleBoardVo;
import com.ja.webproject.vo.HE_ArticleBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_ArticleBoard_CommentVo;

public interface ArticleBoardSQLMapper {

	public int createBoardPK();

	public ArrayList<HE_ArticleBoardVo> getContents(

			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);

	public int getContentCount(
			
			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);
	
	
	//===============본인이 쓴 articleBoard 게시글 리스트 가져오기
	public ArrayList<HE_ArticleBoardVo> getMyArticleBoardNo(int member_no);
	

	public void writeContent(HE_ArticleBoardVo vo);

	public void registerImage(HE_ArticleBoard_ImageBoardVo vo);

	public void increaseReadCount(int articleboard_no);

	public HE_ArticleBoardVo getContentByNo(int articleboard_no);
	

	public ArrayList<HE_ArticleBoard_ImageBoardVo> getImageInfoByBoardNo(int articleboard_no);

	public ArrayList<HE_ArticleBoard_CommentVo> readComment(int articleboard_no);
	//===============추천============================================================
	
	public void doRecommend(@Param("articleboard_no") int articleboard_no,@Param("member_no") int member_no);//추천하기
	
	public void cancelRecommend(@Param("articleboard_no") int board_no,@Param("member_no") int member_no);//추천해제
	
	public int getTotalRecommendCount(int articleboard_no); //글 총 추천수
	
	public int getMyRecommendCount(@Param("articleboard_no") int articleboard_no,@Param("member_no") int member_no); //내가 추천 하였는가
	//=============================================================================
		
	public void writeComment(HE_ArticleBoard_CommentVo vo);
	
	public void updateContent(HE_ArticleBoardVo param);

	public void deleteContent(int articleboard_no);

	public int CommentCount(int articleboard_no);

	public void deleteComment(HE_ArticleBoard_CommentVo vo);
	
	public void updateComment(HE_ArticleBoard_CommentVo vo);
	
	public HE_ArticleBoard_ImageBoardVo getImageForList(int articleboard_no);
	
	//=============================================================================
	//=========================LostdogBoard & ArticleBoard matching system


}
