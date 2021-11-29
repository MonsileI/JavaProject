package com.ja.webproject.finddogboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.finddogboard.service.FinddogBoardServiceImpl;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_CommentVo;
import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_MemberVo;

@RequestMapping("/finddogboard/*")
@RestController
public class FinddogRestBoardController {
	
	@Autowired
	public FinddogBoardServiceImpl finddogBoardServiceImpl;
	
	
	//===============추천============================================================
	
	@RequestMapping("processRecommend.do")
	public void processRecommend(int finddogboard_no, HttpSession session) {	
		System.out.println("controller:"+finddogboard_no);
		
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		finddogBoardServiceImpl.processRecommend(finddogboard_no, member_no);
		
		
	}
	
	@RequestMapping("getTotalRecommendCount.do")
	public HashMap<String, Object> getTotalRecommendCount(int finddogboard_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		//System.out.println(finddogboard_no);
		int totalRecommendCount = finddogBoardServiceImpl.getTotalRecommendCount(finddogboard_no);
		//System.out.println(finddogboard_no);
		map.put("totalRecommendCount", totalRecommendCount);
		//System.out.println(totalRecommendCount);
		
		return map;
		
	}
	
	@RequestMapping("getMyRecommendCount.do")
	public HashMap<String, Object> getMyRecommendCount(int finddogboard_no, HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		int myRecommendCount = finddogBoardServiceImpl.getMyRecommendCount(finddogboard_no, member_no);
		
		map.put("myRecommendCount", myRecommendCount);
		
		return map;
		
		
	}
	
	
	//==================================댓글=================================================


			@RequestMapping("writeComment.do")
			public void writeComment(HE_FinddogBoard_CommentVo vo,HttpSession session) {


				HE_MemberVo memberVo = (HE_MemberVo) session.getAttribute("sessionUser");

				vo.setMember_no(memberVo.getMember_no());

				finddogBoardServiceImpl.writeComment(vo);

			}

			@RequestMapping("getCommentList.do")
			public ArrayList<HashMap<String, Object>>getCommentList(int finddogboard_no){


				ArrayList<HashMap<String, Object>> list = finddogBoardServiceImpl.getCommentList(finddogboard_no);

				return list;


			}

			@RequestMapping("deleteComment.do")
			public void deleteComment(int comment_no) {

				finddogBoardServiceImpl.deleteComment(comment_no);


			}

			@RequestMapping("updateComment.do")
			public void updateComment(HE_FinddogBoard_CommentVo vo) {

				finddogBoardServiceImpl.updateComment(vo);


			}


			//========================================================


}
