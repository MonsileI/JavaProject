package com.ja.webproject.noticeboard.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;


import com.ja.webproject.vo.HE_NoticeBoardVo;
import com.ja.webproject.vo.HE_NoticeBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_NoticeBoard_CommentVo;

public interface NoticeBoardSQLMapper {

	public int createBoardPK();

	public ArrayList<HE_NoticeBoardVo> getContents(

			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);

	public int getContentCount(
			
			@Param("search_type") String search_type, 
			@Param("search_word") String search_word,
			@Param("page_number") int page_number);
	
	
	//===============본인이 쓴 noticeBoard 게시글 리스트 가져오기
	public ArrayList<HE_NoticeBoardVo> getMyNoticeBoardNo(int member_no);
	

	public void writeContent(HE_NoticeBoardVo vo);

	public void registerImage(HE_NoticeBoard_ImageBoardVo vo);

	public void increaseReadCount(int noticeboard_no);

	public HE_NoticeBoardVo getContentByNo(int noticeboard_no);
	

	public ArrayList<HE_NoticeBoard_ImageBoardVo> getImageInfoByBoardNo(int noticeboard_no);

	public ArrayList<HE_NoticeBoard_CommentVo> readComment(int noticeboard_no);
	//===============추천============================================================
	
	public void doRecommend(@Param("noticeboard_no") int noticeboard_no,@Param("member_no") int member_no);//추천하기
	
	public void cancelRecommend(@Param("noticeboard_no") int board_no,@Param("member_no") int member_no);//추천해제
	
	public int getTotalRecommendCount(int noticeboard_no); //글 총 추천수
	
	public int getMyRecommendCount(@Param("noticeboard_no") int noticeboard_no,@Param("member_no") int member_no); //내가 추천 하였는가
	//=============================================================================
		
	public void writeComment(HE_NoticeBoard_CommentVo vo);
	
	public void updateContent(HE_NoticeBoardVo param);

	public void deleteContent(int noticeboard_no);

	public int CommentCount(int noticeboard_no);

	public void deleteComment(HE_NoticeBoard_CommentVo vo);
	
	public void updateComment(HE_NoticeBoard_CommentVo vo);
	
	public HE_NoticeBoard_ImageBoardVo getImageForList(int noticeboard_no);
	
	//=============================================================================
	//=========================LostdogBoard & NoticeBoard matching system


}
