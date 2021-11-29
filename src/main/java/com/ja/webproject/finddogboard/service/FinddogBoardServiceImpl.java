package com.ja.webproject.finddogboard.service;


import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.finddogboard.mapper.FinddogBoardSQLMapper;
import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.ownerboard.mapper.OwnerBoardSQLMapper;
import com.ja.webproject.sitterboard.mapper.SitterBoardSQLMapper;
import com.ja.webproject.sitterboard_process.mapper.SitterBoard_ProcessSQLMapper;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_OwnerBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_ProcessVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_Species_CategoryVo;
import com.ja.webproject.vo.HE_FinddogBoard_CommentVo;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_LostDogBoardVo;

@Service
public class FinddogBoardServiceImpl {
	
	@Autowired
	public FinddogBoardSQLMapper finddogboardSQLMapper;
	
	@Autowired
	public SitterBoard_ProcessSQLMapper sitterBoard_ProcessSQLMapper;
	
	@Autowired
	public SitterBoardSQLMapper sitterBoardSQLMapper;
	
	@Autowired
	public MainSQLMapper mainSQLMapper;
	
	@Autowired
	public MemberSQLMapper memberSQLMapper;
	
	
	@Autowired
	public OwnerBoardSQLMapper ownerBoardSQLMapper;
	
	
public ArrayList<HashMap<String,Object>> getContents(String search_type, String search_word,int page_number) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_FinddogBoardVo> boardList = finddogboardSQLMapper.getContents(search_type, search_word, page_number);
		
		
		for(HE_FinddogBoardVo boardVo : boardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
			
			HE_FinddogBoard_ImageBoardVo boardImageVoList = finddogboardSQLMapper.getImageForList(boardVo.getFinddogboard_no());
			
			
			System.out.println("테스트1111" + boardVo.getFinddogboard_no());
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
	int count = finddogboardSQLMapper.getContentCount(search_type, search_word, page_number);
	return count;
	
}
public ArrayList<HE_Species_CategoryVo> getSpeciesCategoryList() {
	
	return finddogboardSQLMapper.getSpeciesCategoryList();
}

//===============본인이 쓴 finddogBoard 게시글 리스트 가져오기
public ArrayList<HE_FinddogBoardVo> getMyFinddogBoardNo(int member_no){
	
	ArrayList<HE_FinddogBoardVo> finddogBoardList = finddogboardSQLMapper.getMyFinddogBoardNo(member_no);
	
	return finddogBoardList;
}

public void writeContent(HE_FinddogBoardVo vo, ArrayList<HE_FinddogBoard_ImageBoardVo> baordImageVoList) {
	
	
	int finddogboard_no = finddogboardSQLMapper.createBoardPK();
	

	vo.setFinddogboard_no(finddogboard_no);
	finddogboardSQLMapper.writeContent(vo);
	
	
	for(HE_FinddogBoard_ImageBoardVo boardImageVo : baordImageVoList) {
		boardImageVo.setFinddogboard_no(finddogboard_no);
		finddogboardSQLMapper.registerImage(boardImageVo);
	}
	
	System.out.println("writeContent");
}
	
	public void increaseReadCount(int finddogboard_no) {
	
	finddogboardSQLMapper.increaseReadCount(finddogboard_no);
	
}


	public HashMap<String, Object> getContent(int finddogboard_no) {
		
		// 조회수 증가
		// boardSQLMapper.increaseReadCount(board_no); 정확한 코드이지만, 역할구분을 위해(응집도를 위해 여기다가 만들지 않겠음)
		// 수정할때 getContent를 써야함 (재사용) 근데 조회수 증가를 여기다가 써버리면.. 재사용 몬하잖아 ㅠㅠ그래서 그냥 조회수 증가 뜯어내서 메소드로 따로 만들겨 ㅇㅋ?
		
		//...
		HE_FinddogBoardVo boardVo = finddogboardSQLMapper.getContentByNo(finddogboard_no); //누가 썼는지에 대한게 나옴
		

		
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
		
		
		ArrayList<HE_FinddogBoard_ImageBoardVo> boardImageVoList = 
				finddogboardSQLMapper.getImageInfoByBoardNo(finddogboard_no);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		HE_OwnerBoardVo realOwner = ownerBoardSQLMapper.thereIsOwner(finddogboard_no);
	      
	      if(realOwner != null) {
	         
	         HE_MemberVo owner = memberSQLMapper.getMemberByNo(realOwner.getMember_no());
	         
	         map.put("owner", owner);
	         
	      }
		
		
		
		map.put("memberVo", memberVo);
		map.put("boardVo", boardVo);
		map.put("boardImageVoList", boardImageVoList);
		
		
		return map;
		//상세보기를 눌러봤자 회원 정보 한줄만 나오면 되니까 메인페이지와 다르게 hashmap 타입으로 리턴해
		
		
	}
	
	//===============finddogBoard 버튼 권한
	public HE_SitterBoardVo grantAuthority(int finddogboard_no) {
		
		HE_SitterBoard_ProcessVo sitterProcessVo = finddogboardSQLMapper.grantAuthority(finddogboard_no);
		int sitterboard_no = sitterProcessVo.getSitterboard_no();
		
		HE_SitterBoardVo sitterVo = finddogboardSQLMapper.getMemberNo_havingAuthority(sitterboard_no);
		
		return sitterVo;
	}
	
	public ArrayList<HashMap<String,Object>> readComment(int finddogboard_no) {
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_FinddogBoard_CommentVo> comment = finddogboardSQLMapper.readComment(finddogboard_no);
				
		
		
		
		
		for(HE_FinddogBoard_CommentVo commentVo : comment) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
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
	
	//============================ 견추적
	public ArrayList<HashMap<String, Object>> getFinddogHistory(int finddogboard_no){
		
		ArrayList<HashMap<String, Object>>  topList = new ArrayList<HashMap<String,Object>>();
	
		
		ArrayList<HE_SitterBoard_ProcessVo> list = sitterBoard_ProcessSQLMapper.getFinddogHistory(finddogboard_no);
		
		for(HE_SitterBoard_ProcessVo vo : list) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int sitterboard_no = vo.getSitterboard_no();
			
			
			HE_SitterBoardVo sitterVo = sitterBoardSQLMapper.getContentByNo(sitterboard_no);
			int member_no =sitterVo.getMember_no();
			HE_MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
		
	
			map.put("sitterVo", vo);
			map.put("memberVo", memberVo);
		
			
			topList.add(map);
		}
		
		
		return  topList;
	}
	
	
	/*
	//============================취소버튼 기능 없애기로!!!==========================================
	//==================권한 있는 자가 취소 버튼 눌렀을 떄, status='N'로 변경 
	
	public void cancelFinddog(int finddogboard_no) {
		
		finddogboardSQLMapper.cancelFinddog(finddogboard_no);
	}
	*/
	
	//==================권한 있는 자가 완료 버튼 눌렀을 떄, status='Y'로 변경
		public void completeFinddog(HE_FinddogBoardVo vo) {

			finddogboardSQLMapper.completeFinddog(vo);
		}
	
	
	//===============추천============================================================
	
	
	public void processRecommend(int finddogboard_no, int member_no) {
		
		System.out.println("service:"+finddogboard_no);
		
		int myCount = finddogboardSQLMapper.getMyRecommendCount(finddogboard_no, member_no);
		
		
		if(myCount > 0 ) {
			finddogboardSQLMapper.cancelRecommend(finddogboard_no, member_no);		
		}else {
			
			finddogboardSQLMapper.doRecommend(finddogboard_no, member_no);
			
		}
		
	}
	
	public int getTotalRecommendCount(int finddogboard_no) {
		
		return finddogboardSQLMapper.getTotalRecommendCount(finddogboard_no);
		
		
	}
	
	public int getMyRecommendCount(int finddogboard_no, int member_no) {
		
		
		return finddogboardSQLMapper.getMyRecommendCount(finddogboard_no, member_no);
		
	}
	
	
	//============================게시물 수정 삭제===========================================


		public void updateContent(HE_FinddogBoardVo param) {
		finddogboardSQLMapper.updateContent(param);

		}

		public void deleteContent(int finddogboard_no) {
		finddogboardSQLMapper.deleteContent(finddogboard_no);

		}

		//==============================댓글Ajax=====================================================



		public void writeComment(HE_FinddogBoard_CommentVo vo) {

			finddogboardSQLMapper.writeComment(vo);

		}

		public ArrayList<HashMap<String, Object>> getCommentList (int board_no){

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>> ();

		ArrayList<HE_FinddogBoard_CommentVo> commentList = finddogboardSQLMapper.getCommentList(board_no);

		for(HE_FinddogBoard_CommentVo commentVo : commentList) {
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

			finddogboardSQLMapper.deleteComment(comment_no);

		}

		public void updateComment(HE_FinddogBoard_CommentVo vo) {

		finddogboardSQLMapper.updateComment(vo);
		}

//=========================================================================================
//=========================LostdogBoard & FinddogBoard matching system

//개주운사람이 글 올릴 때(FinddogBoard), 
//주인이 올린글 검색(LostdogBoard) -> 
//결과로 받은 리스트 루프 돌기 -> 
//해당 글 작성자에게 쪽지 보내기

//아래 매칭결과 공지 프로세스 - 조건(견종과 날짜)으로 데이터 뽑기 -> 해당 대상에게 메세지 전송  
//보드번호(lostdogboard_no) 링크 보내기(결과로 나온 LostdogBoard 보드번호 작성자에게)

public void getMatchingDog(HE_FinddogBoardVo finddogVo) {

	ArrayList<HE_LostDogBoardVo> voList = finddogboardSQLMapper.getMatchingDog(finddogVo);
	System.out.println("finddog 글(주인찾기)글의 serviceMatching");
	
	if(voList != null) {
	
		for(HE_LostDogBoardVo vo : voList) {
			System.out.println("marchingSize: "+ voList.size());
			
			int member_no = vo.getMember_no();
			int admin_no = 1;
			//String message = "matching result";
			//내용은 lostdogBoard_no 활용 쿼리
			String message = "회원님이 찾는 강아지와 매칭되는 유기견 : 주인 찾기 게시글 No. "+finddogVo.getFinddogboard_no(); //http:localhost:8181/webproject/finddogboard/readHE_FindDogPage.do?finddogboard_no=" + finddogVo.getFinddogboard_no();
			
			memberSQLMapper.sendMatchingNote(admin_no ,member_no, message);
			
		}
		
	}
}


}