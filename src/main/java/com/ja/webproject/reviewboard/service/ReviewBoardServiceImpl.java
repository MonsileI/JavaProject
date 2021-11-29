package com.ja.webproject.reviewboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.reviewboard.mapper.ReviewBoardSQLMapper;
import com.ja.webproject.vo.HE_MemberVo;

import com.ja.webproject.vo.HE_ReviewBoard_CommentVo;
import com.ja.webproject.vo.HE_ReviewBoardVo;
import com.ja.webproject.vo.HE_ReviewBoard_ImageBoardVo;


@Service
public class ReviewBoardServiceImpl {
	
	@Autowired
	public ReviewBoardSQLMapper reviewboardSQLMapper;
	
	@Autowired
	public MainSQLMapper mainSQLMapper;
	
	@Autowired
	public MemberSQLMapper memberSQLMapper;
	
	
public ArrayList<HashMap<String,Object>> getContents(String search_type, String search_word,int page_number) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_ReviewBoardVo> boardList = reviewboardSQLMapper.getContents(search_type, search_word, page_number);
		
		
		for(HE_ReviewBoardVo boardVo : boardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
			
			HE_ReviewBoard_ImageBoardVo boardImageVoList = reviewboardSQLMapper.getImageForList(boardVo.getReviewboard_no());
			
			
			System.out.println("테스트1111" + boardVo.getReviewboard_no());
			System.out.println("이미지" + boardImageVoList);
				
			
			int memberNo = boardVo.getMember_no(); //멤버 테이블 기준 프라이머리 키(보드 기준 foreign key)로 뽑아줌
			HE_MemberVo memberVo =  mainSQLMapper.getMemberByNo(memberNo); //멤버 넘버는 같기 때문에 조인이 되버림(나올때마다)
					//지금 여긴 memberNo에 해당하는 회원 정보가 담겨있음
			
			HashMap<String, Object> map = new HashMap<String, Object>();//결합되어야 하는 정보가 멤버와 보드이기 때문에 object 타입
			//돌때마다 하나씩 해쉬맵 생성
			
			map.put("memberVo", memberVo);
			map.put("boardVo", boardVo);
			map.put("imageVo", boardImageVoList);
			//돌때마다 memberVo값과 boardVo값을 넣어줌.
			
			list.add(map);
			//같은 멤버넘버인 memberVo랑 boardVo랑 결합해서 넣어줌.
			
			//즉, member_no가 같은 memberVo와 BoardVo를 결합하는 로직이지!
		
		}
		
		return list;

	}

public int getContentCount(String search_type, String search_word, int page_number){
	int count = reviewboardSQLMapper.getContentCount(search_type, search_word, page_number);
	return count;
	
}

//===============본인이 쓴 reviewBoard 게시글 리스트 가져오기
public ArrayList<HE_ReviewBoardVo> getMyReviewBoardNo(int member_no){
	
	ArrayList<HE_ReviewBoardVo> reviewBoardList = reviewboardSQLMapper.getMyReviewBoardNo(member_no);
	
	return reviewBoardList;
}

public void writeContent(HE_ReviewBoardVo vo, ArrayList<HE_ReviewBoard_ImageBoardVo> baordImageVoList) {
	
	
	int reviewboard_no = reviewboardSQLMapper.createBoardPK();
	

	vo.setReviewboard_no(reviewboard_no);
	reviewboardSQLMapper.writeContent(vo);
	
	
	for(HE_ReviewBoard_ImageBoardVo boardImageVo : baordImageVoList) {
		boardImageVo.setReviewboard_no(reviewboard_no);
		reviewboardSQLMapper.registerImage(boardImageVo);
	}
	
	System.out.println("writeContent");
}
	
	public void increaseReadCount(int reviewboard_no) {
	
	reviewboardSQLMapper.increaseReadCount(reviewboard_no);
	
}


	public HashMap<String, Object> getContent(int reviewboard_no) {
		
		// 조회수 증가
		// boardSQLMapper.increaseReadCount(board_no); 정확한 코드이지만, 역할구분을 위해(응집도를 위해 여기다가 만들지 않겠음)
		// 수정할때 getContent를 써야함 (재사용) 근데 조회수 증가를 여기다가 써버리면.. 재사용 몬하잖아 ㅠㅠ그래서 그냥 조회수 증가 뜯어내서 메소드로 따로 만들겨 ㅇㅋ?
		
		//...
		HE_ReviewBoardVo boardVo = reviewboardSQLMapper.getContentByNo(reviewboard_no); //누가 썼는지에 대한게 나옴
		

		
		//html escape 
		
		//특수문자 나오게 하기
		String content = boardVo.getContent();
		
//		System.out.println("전 " + content);
		
		content = StringEscapeUtils.escapeHtml4(content);
		
		//엔터 나오게 하기
		content = content.replaceAll("\n", "<br>"); //\n 요거는 엔터라는 의미!
		boardVo.setContent(content);
		
//		System.out.println("후 " + content);
		
	
		
		
		///////////////////////////////////////////////////////////////////////////////////////////
		int member_no = boardVo.getMember_no(); //그 사람의 회원번호가 나옴
		HE_MemberVo memberVo = mainSQLMapper.getMemberByNo(member_no); //그 사람의 회원 번호에 따른 회원 정보가 담겨있음
		
		
		ArrayList<HE_ReviewBoard_ImageBoardVo> boardImageVoList = 
				reviewboardSQLMapper.getImageInfoByBoardNo(reviewboard_no);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		
		map.put("memberVo", memberVo);
		map.put("boardVo", boardVo);
		map.put("boardImageVoList", boardImageVoList);
		
		
		return map;
		//상세보기를 눌러봤자 회원 정보 한줄만 나오면 되니까 메인페이지와 다르게 hashmap 타입으로 리턴해
		
		
	}
	
	
	public ArrayList<HashMap<String,Object>> readComment(int reviewboard_no) {
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_ReviewBoard_CommentVo> comment = reviewboardSQLMapper.readComment(reviewboard_no);
				
		
		
		
		
		for(HE_ReviewBoard_CommentVo commentVo : comment) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
			int memberNo = commentVo.getMember_no(); //멤버 테이블 기준 프라이머리 키(보드 기준 foreign key)로 뽑아줌
			HE_MemberVo memberVo =  mainSQLMapper.getMemberByNo(memberNo); //멤버 넘버는 같기 때문에 조인이 되버림(나올때마다)
					//지금 여긴 memberNo에 해당하는 회원 정보가 담겨있음
			HashMap<String, Object> map = new HashMap<String, Object>();//결합되어야 하는 정보가 멤버와 보드이기 때문에 object 타입
			//돌때마다 하나씩 해쉬맵 생성
			
			map.put("memberVo", memberVo);
			map.put("commentVo", commentVo);
			//돌때마다 memberVo값과 boardVo값을 넣어줌.
			
			commentList.add(map);
			//같은 멤버넘버인 memberVo랑 boardVo랑 결합해서 넣어줌.
			
			//즉, member_no가 같은 memberVo와 BoardVo를 결합하는 로직이지!
			
		}
		
		
		return commentList;
		
		
		
		
	}
	
	/*
	//============================취소버튼 기능 없애기로!!!==========================================
	//==================권한 있는 자가 취소 버튼 눌렀을 떄, status='N'로 변경 
	
	public void cancelReview(int finddogboard_no) {
		
		reviewboardSQLMapper.cancelReview(reviewboard_no);
	}
	*/
	
	
	//===============추천============================================================
	
	
	public void processRecommend(int reviewboard_no, int member_no) {
		
		System.out.println("service:"+reviewboard_no);
		
		int myCount = reviewboardSQLMapper.getMyRecommendCount(reviewboard_no, member_no);
		
		
		if(myCount > 0 ) {
			reviewboardSQLMapper.cancelRecommend(reviewboard_no, member_no);		
		}else {
			
			reviewboardSQLMapper.doRecommend(reviewboard_no, member_no);
			
		}
		
	}
	
	public int getTotalRecommendCount(int reviewboard_no) {
		
		return reviewboardSQLMapper.getTotalRecommendCount(reviewboard_no);
		
		
	}
	
	public int getMyRecommendCount(int reviewboard_no, int member_no) {
		
		
		return reviewboardSQLMapper.getMyRecommendCount(reviewboard_no, member_no);
		
	}
	
	
	
	//=============================================================================
	
	//댓글쓰기
	public void writeComment(HE_ReviewBoard_CommentVo vo) {
		
		
			reviewboardSQLMapper.writeComment(vo);
		
		
	}
	
	
	
	//댓글 삭제 귀찮다..
	public void deleteComment(HE_ReviewBoard_CommentVo vo) {
		
		reviewboardSQLMapper.deleteComment(vo);

	}
	
	//댓글 수정 
	public void updateComment(HE_ReviewBoard_CommentVo vo) {
		
		reviewboardSQLMapper.updateComment(vo);
		
	}
	
	
	//댓글 수
	public int CommentCount(int reviewboard_no)  {
		
		return reviewboardSQLMapper.CommentCount(reviewboard_no);
	
	}
	
	
	
	
public void updateContent(HE_ReviewBoardVo param) {
	reviewboardSQLMapper.updateContent(param);
	
}

public void deleteContent(int reviewboard_no) {
	reviewboardSQLMapper.deleteContent(reviewboard_no);
	
}		




}