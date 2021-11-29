package com.ja.webproject.articleboard.service;


import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.articleboard.mapper.ArticleBoardSQLMapper;
import com.ja.webproject.main.mapper.MainSQLMapper;

import com.ja.webproject.vo.HE_ArticleBoardVo;
import com.ja.webproject.vo.HE_ArticleBoard_CommentVo;
import com.ja.webproject.vo.HE_ArticleBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_MemberVo;



@Service
public class ArticleBoardServiceImpl {
	
	@Autowired
	public ArticleBoardSQLMapper articleboardSQLMapper;
	
	@Autowired
	public MainSQLMapper mainSQLMapper;

	
public ArrayList<HashMap<String,Object>> getContents(String search_type, String search_word,int page_number) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_ArticleBoardVo> boardList = articleboardSQLMapper.getContents(search_type, search_word, page_number);
		
		
		for(HE_ArticleBoardVo boardVo : boardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
			
			HE_ArticleBoard_ImageBoardVo boardImageVoList = articleboardSQLMapper.getImageForList(boardVo.getArticleboard_no());
			
			
			System.out.println("테스트1111" + boardVo.getArticleboard_no());
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
	int count = articleboardSQLMapper.getContentCount(search_type, search_word, page_number);
	return count;
	
}

//===============본인이 쓴 articleBoard 게시글 리스트 가져오기
public ArrayList<HE_ArticleBoardVo> getMyArticleBoardNo(int member_no){
	
	ArrayList<HE_ArticleBoardVo> articleBoardList = articleboardSQLMapper.getMyArticleBoardNo(member_no);
	
	return articleBoardList;
}

public void writeContent(HE_ArticleBoardVo vo, ArrayList<HE_ArticleBoard_ImageBoardVo> baordImageVoList) {
	
	
	int articleboard_no = articleboardSQLMapper.createBoardPK();
	

	vo.setArticleboard_no(articleboard_no);
	articleboardSQLMapper.writeContent(vo);
	
	
	for(HE_ArticleBoard_ImageBoardVo boardImageVo : baordImageVoList) {
		boardImageVo.setImageboard_no(articleboard_no);
		articleboardSQLMapper.registerImage(boardImageVo);
	}
	
	System.out.println("writeContent");
}
	
	public void increaseReadCount(int articleboard_no) {
	
	articleboardSQLMapper.increaseReadCount(articleboard_no);
	
}


	public HashMap<String, Object> getContent(int articleboard_no) {
		
		// 조회수 증가
		// boardSQLMapper.increaseReadCount(board_no); 정확한 코드이지만, 역할구분을 위해(응집도를 위해 여기다가 만들지 않겠음)
		// 수정할때 getContent를 써야함 (재사용) 근데 조회수 증가를 여기다가 써버리면.. 재사용 몬하잖아 ㅠㅠ그래서 그냥 조회수 증가 뜯어내서 메소드로 따로 만들겨 ㅇㅋ?
		
		//...
		HE_ArticleBoardVo boardVo = articleboardSQLMapper.getContentByNo(articleboard_no); //누가 썼는지에 대한게 나옴
		

		
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
		
		
		ArrayList<HE_ArticleBoard_ImageBoardVo> boardImageVoList = 
				articleboardSQLMapper.getImageInfoByBoardNo(articleboard_no);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		
		map.put("memberVo", memberVo);
		map.put("boardVo", boardVo);
		map.put("boardImageVoList", boardImageVoList);
		
		
		return map;
		//상세보기를 눌러봤자 회원 정보 한줄만 나오면 되니까 메인페이지와 다르게 hashmap 타입으로 리턴해
		
		
	}
	
	
	public ArrayList<HashMap<String,Object>> readComment(int articleboard_no) {
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		
		
		ArrayList<HE_ArticleBoard_CommentVo> comment = articleboardSQLMapper.readComment(articleboard_no);
				
		
		
		
		
		for(HE_ArticleBoard_CommentVo commentVo : comment) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
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
	
	
	public void processRecommend(int articleboard_no, int member_no) {
		
		System.out.println("service:"+articleboard_no);
		
		int myCount = articleboardSQLMapper.getMyRecommendCount(articleboard_no, member_no);
		
		
		if(myCount > 0 ) {
			articleboardSQLMapper.cancelRecommend(articleboard_no, member_no);		
		}else {
			
			articleboardSQLMapper.doRecommend(articleboard_no, member_no);
			
		}
		
	}
	
	public int getTotalRecommendCount(int articleboard_no) {
		
		return articleboardSQLMapper.getTotalRecommendCount(articleboard_no);
		
		
	}
	
	public int getMyRecommendCount(int articleboard_no, int member_no) {
		
		
		return articleboardSQLMapper.getMyRecommendCount(articleboard_no, member_no);
		
	}
	
	
	
	//=============================================================================
	
	//댓글쓰기
	public void writeComment(HE_ArticleBoard_CommentVo vo) {
		
		
			articleboardSQLMapper.writeComment(vo);
		
		
	}
	
	
	
	//댓글 삭제 귀찮다..
	public void deleteComment(HE_ArticleBoard_CommentVo vo) {
		
		articleboardSQLMapper.deleteComment(vo);

	}
	
	//댓글 수정 
	public void updateComment(HE_ArticleBoard_CommentVo vo) {
		
		articleboardSQLMapper.updateComment(vo);
		
	}
	
	
	//댓글 수
	public int CommentCount(int articleboard_no)  {
		
		return articleboardSQLMapper.CommentCount(articleboard_no);
	
	}
	
	
	
	
public void updateContent(HE_ArticleBoardVo param) {
	articleboardSQLMapper.updateContent(param);
	
}

public void deleteContent(int articleboard_no) {
	articleboardSQLMapper.deleteContent(articleboard_no);
	
}		




}