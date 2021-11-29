package com.ja.webproject.lostdogboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.lostdogboard.service.LostdogBoardServiceImpl;
import com.ja.webproject.vo.HE_FinddogBoard_CommentVo;
import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_LostDogBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_LostdogBoard_CommentVo;
import com.ja.webproject.vo.HE_MemberVo;


@RestController
@RequestMapping("/lostdogboard/*")
public class LostdogRestBoardController {
	@Autowired
	public LostdogBoardServiceImpl lostdogBoardServiceImpl;

	
	//===============추천============================================================
	
		@RequestMapping("processRecommend.do")
		public void processRecommend(int lostdogboard_no, HttpSession session) {
			
			
			HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
			int member_no = sessionUser.getMember_no();
			
			lostdogBoardServiceImpl.processRecommend(lostdogboard_no, member_no);
			
			
			
		}
		
		@RequestMapping("getTotalRecommendCount.do")
		public HashMap<String, Object> getTotalRecommendCount(int lostdogboard_no){
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int totalRecommendCount = lostdogBoardServiceImpl.getTotalRecommendCount(lostdogboard_no);
			
			map.put("totalRecommendCount", totalRecommendCount);
			
			return map;
			
		}
		
		@RequestMapping("getMyRecommendCount.do")
		public HashMap<String, Object> getMyRecommendCount(int lostdogboard_no, HttpSession session){
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
			int member_no = sessionUser.getMember_no();
			
			int myRecommendCount = lostdogBoardServiceImpl.getMyRecommendCount(lostdogboard_no, member_no);
			
			map.put("myRecommendCount", myRecommendCount);
			
			return map;
			
			
		}
			
			
			
		//=============================================================================
		
		//==================권한 있는 자가 완료 버튼 눌렀을 떄, status='Y'나 'ING' 로 변경
		@RequestMapping("completeLostdog.do")
		public void completeLostdog(HE_LostDogBoardVo vo) {

			lostdogBoardServiceImpl.completeLostdog(vo);
			
		}
		
		
		//==================================댓글=================================================
		
		
			@RequestMapping("writeComment.do")
			public void writeComment(HE_LostdogBoard_CommentVo vo,HttpSession session) {
				
				
				HE_MemberVo memberVo = (HE_MemberVo) session.getAttribute("sessionUser");
				
				vo.setMember_no(memberVo.getMember_no());
				
				lostdogBoardServiceImpl.writeComment(vo);
				
			}
			
			@RequestMapping("getCommentList.do")
			public ArrayList<HashMap<String, Object>>getCommentList(int lostdogboard_no){
				
				
				ArrayList<HashMap<String, Object>> list = lostdogBoardServiceImpl.getCommentList(lostdogboard_no);
				
				return list;
				
				
			}
			
			@RequestMapping("deleteComment.do")
			public void deleteComment(int comment_no) {
				
				lostdogBoardServiceImpl.deleteComment(comment_no);
				
				
			}
			
			@RequestMapping("updateComment.do")
			public void updateComment(HE_LostdogBoard_CommentVo vo) {
				
				lostdogBoardServiceImpl.updateComment(vo);
				
				
			}
			
			
			//========================================================
		
		


}
