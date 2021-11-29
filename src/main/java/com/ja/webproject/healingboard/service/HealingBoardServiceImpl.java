package com.ja.webproject.healingboard.service;


import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.healingboard.mapper.HealingBoardSQLMapper;
import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.vo.HE_MemberVo;

import com.ja.webproject.vo.HE_HealingBoard_CommentVo;
import com.ja.webproject.vo.HE_HealingBoardVo;
import com.ja.webproject.vo.HE_HealingBoard_ImageBoardVo;


@Service
public class HealingBoardServiceImpl {
	
	@Autowired
	public HealingBoardSQLMapper healingboardSQLMapper;
	
	@Autowired
	public MainSQLMapper mainSQLMapper;
	
	@Autowired
	public MemberSQLMapper memberSQLMapper;
	
	
public ArrayList<HashMap<String,Object>> getContents(String search_type, String search_word,int page_number) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_HealingBoardVo> boardList = healingboardSQLMapper.getContents(search_type, search_word, page_number);
		
		
		for(HE_HealingBoardVo boardVo : boardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
			
			HE_HealingBoard_ImageBoardVo boardImageVoList = healingboardSQLMapper.getImageForList(boardVo.getHealingboard_no());
			
			
			System.out.println("테스트1111" + boardVo.getHealingboard_no());
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
	int count = healingboardSQLMapper.getContentCount(search_type, search_word, page_number);
	return count;
	
}

//===============본인이 쓴 HealingBoard 게시글 리스트 가져오기
public ArrayList<HE_HealingBoardVo> getMyHealingBoardNo(int member_no){
	
	ArrayList<HE_HealingBoardVo> healingBoardList = healingboardSQLMapper.getMyHealingBoardNo(member_no);
	
	return healingBoardList;
}

public void writeContent(HE_HealingBoardVo vo, ArrayList<HE_HealingBoard_ImageBoardVo> baordImageVoList) {
	
	
	int healingboard_no = healingboardSQLMapper.createBoardPK();
	

	vo.setHealingboard_no(healingboard_no);
	healingboardSQLMapper.writeContent(vo);
	
	
	for(HE_HealingBoard_ImageBoardVo boardImageVo : baordImageVoList) {
		boardImageVo.setHealingboard_no(healingboard_no);
		healingboardSQLMapper.registerImage(boardImageVo);
	}
	
	System.out.println("writeContent");
}
	
	public void increaseReadCount(int healingboard_no) {
	
	healingboardSQLMapper.increaseReadCount(healingboard_no);
	
}


	public HashMap<String, Object> getContent(int healingboard_no) {
		
		// 조회수 증가
		// boardSQLMapper.increaseReadCount(board_no); 정확한 코드이지만, 역할구분을 위해(응집도를 위해 여기다가 만들지 않겠음)
		// 수정할때 getContent를 써야함 (재사용) 근데 조회수 증가를 여기다가 써버리면.. 재사용 몬하잖아 ㅠㅠ그래서 그냥 조회수 증가 뜯어내서 메소드로 따로 만들겨 ㅇㅋ?
		
		//...
		HE_HealingBoardVo boardVo = healingboardSQLMapper.getContentByNo(healingboard_no); //누가 썼는지에 대한게 나옴
		

		
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
		
		
		ArrayList<HE_HealingBoard_ImageBoardVo> boardImageVoList = 
				healingboardSQLMapper.getImageInfoByBoardNo(healingboard_no);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		
		map.put("memberVo", memberVo);
		map.put("boardVo", boardVo);
		map.put("boardImageVoList", boardImageVoList);
		
		
		return map;
		//상세보기를 눌러봤자 회원 정보 한줄만 나오면 되니까 메인페이지와 다르게 hashmap 타입으로 리턴해
		
		
	}
	
	
	public ArrayList<HashMap<String,Object>> readComment(int healingboard_no) {
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_HealingBoard_CommentVo> comment = healingboardSQLMapper.readComment(healingboard_no);
				
		
		
		
		
		for(HE_HealingBoard_CommentVo commentVo : comment) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
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
	
	
	public void processRecommend(int healingboard_no, int member_no) {
		
		System.out.println("service:"+healingboard_no);
		
		int myCount = healingboardSQLMapper.getMyRecommendCount(healingboard_no, member_no);
		
		
		if(myCount > 0 ) {
			healingboardSQLMapper.cancelRecommend(healingboard_no, member_no);		
		}else {
			
			healingboardSQLMapper.doRecommend(healingboard_no, member_no);
			
		}
		
	}
	
	public int getTotalRecommendCount(int healingboard_no) {
		
		return healingboardSQLMapper.getTotalRecommendCount(healingboard_no);
		
		
	}
	
	public int getMyRecommendCount(int healingboard_no, int member_no) {
		
		
		return healingboardSQLMapper.getMyRecommendCount(healingboard_no, member_no);
		
	}
	
	
	
	//=============================================================================
	
	//댓글쓰기
	public void writeComment(HE_HealingBoard_CommentVo vo) {
		
		
			healingboardSQLMapper.writeComment(vo);
		
		
	}
	
	
	
	//댓글 삭제 귀찮다..
	public void deleteComment(HE_HealingBoard_CommentVo vo) {
		
		healingboardSQLMapper.deleteComment(vo);

	}
	
	//댓글 수정 
	public void updateComment(HE_HealingBoard_CommentVo vo) {
		
		healingboardSQLMapper.updateComment(vo);
		
	}
	
	
	//댓글 수
	public int CommentCount(int healingboard_no)  {
		
		return healingboardSQLMapper.CommentCount(healingboard_no);
	
	}
	
	
	
	
public void updateContent(HE_HealingBoardVo param) {
	healingboardSQLMapper.updateContent(param);
	
}

public void deleteContent(int healingboard_no) {
	healingboardSQLMapper.deleteContent(healingboard_no);
	
}		




}