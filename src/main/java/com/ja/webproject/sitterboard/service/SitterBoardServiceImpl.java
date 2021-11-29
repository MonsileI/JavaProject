package com.ja.webproject.sitterboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.sitterboard.mapper.SitterBoardSQLMapper;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_CommentVo;
import com.ja.webproject.vo.HE_SitterBoard_ImageBoardVo;

@Service
public class SitterBoardServiceImpl {
	
	@Autowired
	public SitterBoardSQLMapper sitterboardSQLMapper;
	@Autowired
	public MainSQLMapper mainSQLMapper;
	
	@Autowired
	public MemberSQLMapper memberSQLMapper;
	
	
public ArrayList<HashMap<String,Object>> getContents(String search_type, String search_word,int page_number) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_SitterBoardVo> boardList = sitterboardSQLMapper.getContents(search_type, search_word, page_number);
		
		
		for(HE_SitterBoardVo boardVo : boardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
			
			HE_SitterBoard_ImageBoardVo boardImageVoList = sitterboardSQLMapper.getImageForList(boardVo.getSitterboard_no());
			
			
			//System.out.println("테스트1111" + boardVo.getSitterboard_no());
			//System.out.println("이미지" + boardImageVoList);
				
			
			int memberNo = boardVo.getMember_no(); //멤버 테이블 기준 프라이머리 키(보드 기준 foreign key)로 뽑아줌
			HE_MemberVo memberVo =  mainSQLMapper.getMemberByNo(memberNo); //멤버 넘버는 같기 때문에 조인이 되버림(나올때마다)
					//지금 여긴 memberNo에 해당하는 회원 정보가 담겨있음
			
			HashMap<String, Object> map = new HashMap<String, Object>();//결합되어야 하는 정보가 멤버와 보드이기 때문에 object 타입
			//돌때마다 하나씩 해쉬맵 생성
			
			
			//=========================시터 경험했던 수================================================
	         
	         
	         int member_no = boardVo.getMember_no();
	         
	         ArrayList<Integer> mySitterboard_no = sitterboardSQLMapper.sitterboardCount(member_no);
	         int myAllsitter = 0;
	            for(Integer firstSitter : mySitterboard_no) {
	               
	               myAllsitter += sitterboardSQLMapper.sitterCount(firstSitter);
	               
	            }
			
			
			
			map.put("memberVo", memberVo);
			map.put("boardVo", boardVo);
			map.put("imageVo", boardImageVoList);
			map.put("sitterCount", myAllsitter); 
			//돌때마다 memberVo값과 boardVo값을 넣어줌.
			
			list.add(map);
			//같은 멤버넘버인 memberVo랑 boardVo랑 결합해서 넣어줌.
			
			//즉, member_no가 같은 memberVo와 BoardVo를 결합하는 로직이지!
		
		}
		
		return list;

	}

public int getContentCount(String search_type, String search_word, int page_number){
	int count = sitterboardSQLMapper.getContentCount(search_type, search_word, page_number);
	return count;
	
}

public void writeContent(HE_SitterBoardVo vo, ArrayList<HE_SitterBoard_ImageBoardVo> baordImageVoList) {
	
	
	int sitterboard_no = sitterboardSQLMapper.createBoardPK();
	

	vo.setSitterboard_no(sitterboard_no);
	sitterboardSQLMapper.writeContent(vo);
	
	
	for(HE_SitterBoard_ImageBoardVo boardImageVo : baordImageVoList) {
		boardImageVo.setSitterboard_no(sitterboard_no);
		sitterboardSQLMapper.registerImage(boardImageVo);
	}
	
	System.out.println("writeContent");
}
	
	public void increaseReadCount(int sitterboard_no) {
	
	sitterboardSQLMapper.increaseReadCount(sitterboard_no);
	
	
	
}


	
	public HashMap<String, Object> getContent(int sitterboard_no) {
		
		// 조회수 증가
		// boardSQLMapper.increaseReadCount(board_no); 정확한 코드이지만, 역할구분을 위해(응집도를 위해 여기다가 만들지 않겠음)
		// 수정할때 getContent를 써야함 (재사용) 근데 조회수 증가를 여기다가 써버리면.. 재사용 몬하잖아 ㅠㅠ그래서 그냥 조회수 증가 뜯어내서 메소드로 따로 만들겨 ㅇㅋ?
		
		//...
		HE_SitterBoardVo boardVo = sitterboardSQLMapper.getContentByNo(sitterboard_no); //누가 썼는지에 대한게 나옴
		

		
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
		
		
		ArrayList<HE_SitterBoard_ImageBoardVo> boardImageVoList = 
				sitterboardSQLMapper.getImageInfoByBoardNo(sitterboard_no);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		
		
		//시터 티어 불러오기(시터횟수)===========================================================================================
        
	      HE_SitterBoardVo sitterboard_info = sitterboardSQLMapper.getContentByNo(sitterboard_no);
	      
	      
	      int memberNo = sitterboard_info.getMember_no();
	      
	      ArrayList<Integer> mySitterboard_no = sitterboardSQLMapper.sitterboardCount(memberNo);
	      int myAllsitter = 0;
	         for(Integer firstSitter : mySitterboard_no) {
	            
	            myAllsitter += sitterboardSQLMapper.sitterCount(firstSitter);

	         }
	
		
		map.put("memberVo", memberVo);
		map.put("boardVo", boardVo);
		map.put("boardImageVoList", boardImageVoList);
		map.put("sitterCount", myAllsitter);
		
		return map;
		//상세보기를 눌러봤자 회원 정보 한줄만 나오면 되니까 메인페이지와 다르게 hashmap 타입으로 리턴해
		
		
	}

	public ArrayList<HashMap<String,Object>> readComment(int sitterboard_no) {
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_SitterBoard_CommentVo> comment = sitterboardSQLMapper.readComment(sitterboard_no);
				
		
		
		
		
		for(HE_SitterBoard_CommentVo commentVo : comment) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
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
	
	//===============추천============================================================


		public void processRecommend(int sitterboard_no, int member_no) {
			
		int myCount = sitterboardSQLMapper.getMyRecommendCount(sitterboard_no, member_no);
			
			
		if(myCount > 0 ) {
			sitterboardSQLMapper.cancelRecommend(sitterboard_no, member_no);		
		}else {
			
			sitterboardSQLMapper.doRecommend(sitterboard_no, member_no);
			
			}
		
		}

		public int getTotalRecommendCount(int sitterboard_no) {
		
		return sitterboardSQLMapper.getTotalRecommendCount(sitterboard_no);
		
		
		}

		public int getMyRecommendCount(int sitterboard_no, int member_no) {
		
		
		return sitterboardSQLMapper.getMyRecommendCount(sitterboard_no, member_no);
		
		}

		
		
		//=============================================================================
	
	//댓글쓰기
	public void writeComment(HE_SitterBoard_CommentVo vo) {
			//System.out.println("write:"+vo.getSitterboard_no());
		
			sitterboardSQLMapper.writeComment(vo);
		
		
	}
	
	//댓글 삭제 귀찮다..
	public void deleteComment(HE_SitterBoard_CommentVo vo) {
		
		sitterboardSQLMapper.deleteComment(vo);

	}
	
	//댓글 수정 
	public void updateComment(HE_SitterBoard_CommentVo vo) {
		
		sitterboardSQLMapper.updateComment(vo);
		
	}
	
	public int CommentCount(int sitterboard_no)  {
		
		return sitterboardSQLMapper.CommentCount(sitterboard_no);
	
	}
	
	public void updateContent(HE_SitterBoardVo param) {
		sitterboardSQLMapper.updateContent(param);
		
	}

	public void deleteContent(int sitterboard_no) {
		sitterboardSQLMapper.deleteContent(sitterboard_no);
		
	}	
	



}
