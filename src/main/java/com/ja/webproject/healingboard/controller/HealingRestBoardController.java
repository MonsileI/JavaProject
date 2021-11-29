package com.ja.webproject.healingboard.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.healingboard.service.HealingBoardServiceImpl;
import com.ja.webproject.vo.HE_MemberVo;

@RequestMapping("/healingboard/*")
@RestController
public class HealingRestBoardController {
	
	@Autowired
	public HealingBoardServiceImpl healingBoardServiceImpl;
	
	
	//===============추천============================================================
	
	@RequestMapping("processRecommend.do")
	public void processRecommend(int healingboard_no, HttpSession session) {	
		System.out.println("controller:"+healingboard_no);
		
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		healingBoardServiceImpl.processRecommend(healingboard_no, member_no);
		
		
	}
	
	@RequestMapping("getTotalRecommendCount.do")
	public HashMap<String, Object> getTotalRecommendCount(int healingboard_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		//System.out.println(healingboard_no);
		int totalRecommendCount = healingBoardServiceImpl.getTotalRecommendCount(healingboard_no);
		//System.out.println(healingboard_no);
		map.put("totalRecommendCount", totalRecommendCount);
		//System.out.println(totalRecommendCount);
		
		return map;
		
	}
	
	@RequestMapping("getMyRecommendCount.do")
	public HashMap<String, Object> getMyRecommendCount(int healingboard_no, HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		int myRecommendCount = healingBoardServiceImpl.getMyRecommendCount(healingboard_no, member_no);
		
		map.put("myRecommendCount", myRecommendCount);
		
		return map;
		
		
	}
		
		
		
	//=============================================================================

}
