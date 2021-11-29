package com.ja.webproject.lostdogboard.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.ja.webproject.lostdogboard.mapper.LostdogBoardSQLMapper;
import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_LostdogBoard_CommentVo;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_CommentVo;
import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_LostDogBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_LostdogBoard_LikeVo;


@Service
public class LostdogBoardServiceImpl {
	
	@Autowired
	public LostdogBoardSQLMapper boardSQLMapper;
	
	@Autowired
	public MainSQLMapper mainSQLMapper;
	
	@Autowired
	public MemberSQLMapper memberSQLMapper;
	
	
	public ArrayList<HashMap<String,Object>> getContents(String search_type, String search_word,int page_number) {
			
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			
			
			ArrayList<HE_LostDogBoardVo> boardList = boardSQLMapper.getContents(search_type, search_word, page_number);
			
			 
	
		
			
			
		
			
			for(HE_LostDogBoardVo boardVo : boardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
				
				
				HE_LostDogBoard_ImageBoardVo boardImageVoList = boardSQLMapper.getImageForList(boardVo.getLostdogboard_no());
				
				
				
				System.out.println("테스트1111" + boardVo.getLostdogboard_no());
				
	
			
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
		int count = boardSQLMapper.getContentCount(search_type, search_word, page_number);
		return count;
		
	}
	
	public void writeContent(HE_LostDogBoardVo vo, ArrayList<HE_LostDogBoard_ImageBoardVo> baordImageVoList) {
		
		
		int lostdogboard_no = boardSQLMapper.createBoardPK();
		
		//강아지 상태 처리
		vo.setStatus("n");
		
		vo.setLostdogboard_no(lostdogboard_no);
		boardSQLMapper.writeContent(vo);
		
		
		System.out.println(vo.getSpecies_no());
		System.out.println(vo.getStatus());
		
		for(HE_LostDogBoard_ImageBoardVo boardImageVo : baordImageVoList) {
			boardImageVo.setLostdogboard_no(lostdogboard_no);
			boardSQLMapper.registerImage(boardImageVo);
			
		}
	
	
}
	
	public void increaseReadCount(int lostdogboard_no) {
	
	boardSQLMapper.increaseReadCount(lostdogboard_no);
	
	
	
}


	
	public HashMap<String, Object> getContent(int lostdogboard_no) {
		
		// 조회수 증가
		// boardSQLMapper.increaseReadCount(board_no); 정확한 코드이지만, 역할구분을 위해(응집도를 위해 여기다가 만들지 않겠음)
		// 수정할때 getContent를 써야함 (재사용) 근데 조회수 증가를 여기다가 써버리면.. 재사용 몬하잖아 ㅠㅠ그래서 그냥 조회수 증가 뜯어내서 메소드로 따로 만들겨 ㅇㅋ?
		
		//...
		HE_LostDogBoardVo boardVo = boardSQLMapper.getContentByNo(lostdogboard_no); //누가 썼는지에 대한게 나옴
		

		
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
		
		
		ArrayList<HE_LostDogBoard_ImageBoardVo> boardImageVoList = 
				boardSQLMapper.getImageInfoByBoardNo(lostdogboard_no);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//여기서 댓글 평가 소수점 처리 
		//그리고 값이 0개가 아닐때만 불러주게 처리!(평가  입력된 값이 0개인데 화면에 출력하려고 하면 오류가 뜨겠지? double 타입 변환 불가 오류가 떠버리네..)	
		
		
		
		map.put("memberVo", memberVo);
		map.put("boardVo", boardVo);
		map.put("boardImageVoList", boardImageVoList);
		
		
		
		
		
		return map;
		//상세보기를 눌러봤자 회원 정보 한줄만 나오면 되니까 메인페이지와 다르게 hashmap 타입으로 리턴해
		
		
		
		
	}
	
	/*
	//==================================취소 버튼 기능 없애기로!!!=================================================
	//==================권한 있는 자가 취소 버튼 눌렀을 떄, status='N'로 변경 
	
	public void cancelLostdog(int lostdogboard_no) {
		
		boardSQLMapper.cancelLostdog(lostdogboard_no);
	}
	*/
	
	//==================권한 있는 자가 완료 버튼 눌렀을 떄, status='Y'로 변경
	public void completeLostdog(HE_LostDogBoardVo vo) {

		boardSQLMapper.completeLostdog(vo);
	}
	
	
	//댓글 보기
	public ArrayList<HashMap<String,Object>> readComment(int board_no) {
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_LostdogBoard_CommentVo> comment = boardSQLMapper.readComment(board_no);
				
		
		
		
		
		for(HE_LostdogBoard_CommentVo commentVo : comment) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
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
	
	//==============================댓글Ajax=====================================================



		public void writeComment(HE_LostdogBoard_CommentVo vo) {
		
			boardSQLMapper.writeComment(vo);
		
		}

		public ArrayList<HashMap<String, Object>> getCommentList (int board_no){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>> ();
		
		ArrayList<HE_LostdogBoard_CommentVo> commentList = boardSQLMapper.getCommentList(board_no);
		
		for(HE_LostdogBoard_CommentVo commentVo : commentList) {
			int member_no = commentVo.getMember_no();
			
			HE_MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			map.put("commentVo", commentVo);
			
			list.add(map);
			
			
		}
		
		return list;
		
		
		}

		public void deleteComment(int comment_no) {
		
			boardSQLMapper.deleteComment(comment_no);
		
		}

		public void updateComment(HE_LostdogBoard_CommentVo vo) {
		
			boardSQLMapper.updateComment(vo);
		
		}

	
//===============추천============================================================


	public void processRecommend(int lostdogboard_no, int member_no) {
		
	int myCount = boardSQLMapper.getMyRecommendCount(lostdogboard_no, member_no);
		
		
	if(myCount > 0 ) {
		boardSQLMapper.cancelRecommend(lostdogboard_no, member_no);		
	}else {
		
		boardSQLMapper.doRecommend(lostdogboard_no, member_no);
		
		}
	
	}

	public int getTotalRecommendCount(int lostdogboard_no) {
	
	return boardSQLMapper.getTotalRecommendCount(lostdogboard_no);
	
	
	}

	public int getMyRecommendCount(int lostdogboard_no, int member_no) {
	
	
	return boardSQLMapper.getMyRecommendCount(lostdogboard_no, member_no);
	
	}

	
	
	//=============================================================================
	

	
	public void updateContent(HE_LostDogBoardVo param) {
		boardSQLMapper.updateContent(param);
		
	}
	
	public void deleteContent(int lostdogboard_no) {
		boardSQLMapper.deleteContent(lostdogboard_no);
		
	}		

	//=========================================================================================
	//=========================LostdogBoard & LostdogBoard matching system
	

	
	//주인이 글 올렸을 때(LostdogBoard),
	//개 주운 사람(LostdogBoard)이 올린 글 검색 -> 
	//결과로 받은 리스트 루프 돌면서 -> 
	//쪽지 보내기 
	
	//아래 매칭결과 공지 프로세스 - 조건(견종과 날짜)으로 데이터 뽑기 -> 해당 대상에게 메세지 전송  
	//보드번호(lostdogboard_no) 링크 보내기(해당 글의 보드번호(lostdogboard_no)를 현재 글쓴이에게)
	
	public void getMatchingDog(HE_LostDogBoardVo lostdogVo, int member_no) {

		ArrayList<HE_FinddogBoardVo> voList = boardSQLMapper.getMatchingDog(lostdogVo);
		System.out.println("lostdog 글(개찾기)글의 serviceMatching");
		
		if(voList != null) {
		
			for(HE_FinddogBoardVo vo : voList) {
				System.out.println("matchingSize: "+ voList.size());
				
				//int member_no = vo.getMember_no();
				int admin_no = 1;
				//String message = "matching result";
				//내용은 finddogBoard_no 활용 쿼리
				String message = "http://localhost:8181/webproject/finddogboard/readHE_FinddogPage.do?finddogboard_no=" + vo.getFinddogboard_no();
				
				memberSQLMapper.sendMatchingNote(admin_no ,member_no, message);
				
			}
			
		}
	}
}
