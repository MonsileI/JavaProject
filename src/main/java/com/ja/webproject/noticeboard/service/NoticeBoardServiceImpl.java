package com.ja.webproject.noticeboard.service;


import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.noticeboard.mapper.NoticeBoardSQLMapper;
import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.vo.HE_MemberVo;

import com.ja.webproject.vo.HE_NoticeBoard_CommentVo;
import com.ja.webproject.vo.HE_NoticeBoardVo;
import com.ja.webproject.vo.HE_NoticeBoard_ImageBoardVo;


@Service
public class NoticeBoardServiceImpl {
	
	@Autowired
	public NoticeBoardSQLMapper noticeboardSQLMapper;
	
	@Autowired
	public MainSQLMapper mainSQLMapper;
	
	@Autowired
	public MemberSQLMapper memberSQLMapper;
	
	
public ArrayList<HashMap<String,Object>> getContents(String search_type, String search_word,int page_number) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_NoticeBoardVo> boardList = noticeboardSQLMapper.getContents(search_type, search_word, page_number);
		
		
		for(HE_NoticeBoardVo boardVo : boardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
			
			HE_NoticeBoard_ImageBoardVo boardImageVoList = noticeboardSQLMapper.getImageForList(boardVo.getNoticeboard_no());
			
			
			System.out.println("테스트1111" + boardVo.getNoticeboard_no());
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
	int count = noticeboardSQLMapper.getContentCount(search_type, search_word, page_number);
	return count;
	
}

//===============본인이 쓴 noticeBoard 게시글 리스트 가져오기
public ArrayList<HE_NoticeBoardVo> getMyNoticeBoardNo(int member_no){
	
	ArrayList<HE_NoticeBoardVo> noticeBoardList = noticeboardSQLMapper.getMyNoticeBoardNo(member_no);
	
	return noticeBoardList;
}

public void writeContent(HE_NoticeBoardVo vo, ArrayList<HE_NoticeBoard_ImageBoardVo> baordImageVoList) {
	
	
	int noticeboard_no = noticeboardSQLMapper.createBoardPK();
	

	vo.setNoticeboard_no(noticeboard_no);
	noticeboardSQLMapper.writeContent(vo);
	
	
	for(HE_NoticeBoard_ImageBoardVo boardImageVo : baordImageVoList) {
		boardImageVo.setNoticeboard_no(noticeboard_no);
		noticeboardSQLMapper.registerImage(boardImageVo);
	}
	
	System.out.println("writeContent");
}
	
	public void increaseReadCount(int noticeboard_no) {
	
	noticeboardSQLMapper.increaseReadCount(noticeboard_no);
	
}


	public HashMap<String, Object> getContent(int noticeboard_no) {
		
		// 조회수 증가
		// boardSQLMapper.increaseReadCount(board_no); 정확한 코드이지만, 역할구분을 위해(응집도를 위해 여기다가 만들지 않겠음)
		// 수정할때 getContent를 써야함 (재사용) 근데 조회수 증가를 여기다가 써버리면.. 재사용 몬하잖아 ㅠㅠ그래서 그냥 조회수 증가 뜯어내서 메소드로 따로 만들겨 ㅇㅋ?
		
		//...
		HE_NoticeBoardVo boardVo = noticeboardSQLMapper.getContentByNo(noticeboard_no); //누가 썼는지에 대한게 나옴
		

		
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
		
		
		ArrayList<HE_NoticeBoard_ImageBoardVo> boardImageVoList = 
				noticeboardSQLMapper.getImageInfoByBoardNo(noticeboard_no);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		
		map.put("memberVo", memberVo);
		map.put("boardVo", boardVo);
		map.put("boardImageVoList", boardImageVoList);
		
		
		return map;
		//상세보기를 눌러봤자 회원 정보 한줄만 나오면 되니까 메인페이지와 다르게 hashmap 타입으로 리턴해
		
		
	}
	
	
	public ArrayList<HashMap<String,Object>> readComment(int noticeboard_no) {
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_NoticeBoard_CommentVo> comment = noticeboardSQLMapper.readComment(noticeboard_no);
				
		
		
		
		
		for(HE_NoticeBoard_CommentVo commentVo : comment) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
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
	
	
	public void processRecommend(int noticeboard_no, int member_no) {
		
		System.out.println("service:"+noticeboard_no);
		
		int myCount = noticeboardSQLMapper.getMyRecommendCount(noticeboard_no, member_no);
		
		
		if(myCount > 0 ) {
			noticeboardSQLMapper.cancelRecommend(noticeboard_no, member_no);		
		}else {
			
			noticeboardSQLMapper.doRecommend(noticeboard_no, member_no);
			
		}
		
	}
	
	public int getTotalRecommendCount(int noticeboard_no) {
		
		return noticeboardSQLMapper.getTotalRecommendCount(noticeboard_no);
		
		
	}
	
	public int getMyRecommendCount(int noticeboard_no, int member_no) {
		
		
		return noticeboardSQLMapper.getMyRecommendCount(noticeboard_no, member_no);
		
	}
	
	
	
	//=============================================================================
	
	//댓글쓰기
	public void writeComment(HE_NoticeBoard_CommentVo vo) {
		
		
			noticeboardSQLMapper.writeComment(vo);
		
		
	}
	
	
	
	//댓글 삭제 귀찮다..
	public void deleteComment(HE_NoticeBoard_CommentVo vo) {
		
		noticeboardSQLMapper.deleteComment(vo);

	}
	
	//댓글 수정 
	public void updateComment(HE_NoticeBoard_CommentVo vo) {
		
		noticeboardSQLMapper.updateComment(vo);
		
	}
	
	
	//댓글 수
	public int CommentCount(int noticeboard_no)  {
		
		return noticeboardSQLMapper.CommentCount(noticeboard_no);
	
	}
	
	
	
	
public void updateContent(HE_NoticeBoardVo param) {
	noticeboardSQLMapper.updateContent(param);
	
}

public void deleteContent(int noticeboard_no) {
	noticeboardSQLMapper.deleteContent(noticeboard_no);
	
}		




}