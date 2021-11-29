package com.ja.webproject.reviewboard.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.reviewboard.service.ReviewBoardServiceImpl;
import com.ja.webproject.vo.HE_MemberVo;

@RequestMapping("/reviewboard/*")
@RestController
public class ReviewRestBoardController {
	
	@Autowired
	public ReviewBoardServiceImpl reviewBoardServiceImpl;
	
	
	//===============추천============================================================
	
	@RequestMapping("processRecommend.do")
	public void processRecommend(int reviewboard_no, HttpSession session) {	
		System.out.println("controller:"+reviewboard_no);
		
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		reviewBoardServiceImpl.processRecommend(reviewboard_no, member_no);
		
		
	}
	
	@RequestMapping("getTotalRecommendCount.do")
	public HashMap<String, Object> getTotalRecommendCount(int reviewboard_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		//System.out.println(reviewboard_no);
		int totalRecommendCount = reviewBoardServiceImpl.getTotalRecommendCount(reviewboard_no);
		//System.out.println(reviewboard_no);
		map.put("totalRecommendCount", totalRecommendCount);
		//System.out.println(totalRecommendCount);
		
		return map;
		
	}
	
	@RequestMapping("getMyRecommendCount.do")
	public HashMap<String, Object> getMyRecommendCount(int reviewboard_no, HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		int myRecommendCount = reviewBoardServiceImpl.getMyRecommendCount(reviewboard_no, member_no);
		
		map.put("myRecommendCount", myRecommendCount);
		
		return map;
		
		
	}
		
		
		
	//=============================================================================

}
