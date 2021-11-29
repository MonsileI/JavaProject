package com.ja.webproject.articleboard.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.noticeboard.service.NoticeBoardServiceImpl;
import com.ja.webproject.vo.HE_MemberVo;

@RequestMapping("/articleboard/*")
@RestController
public class ArticleRestBoardController {
	
	@Autowired
	public NoticeBoardServiceImpl noticeBoardServiceImpl;
	
	
	//===============추천============================================================
	
	@RequestMapping("processRecommend.do")
	public void processRecommend(int noticeboard_no, HttpSession session) {	
		System.out.println("controller:"+noticeboard_no);
		
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		noticeBoardServiceImpl.processRecommend(noticeboard_no, member_no);
		
		
	}
	
	@RequestMapping("getTotalRecommendCount.do")
	public HashMap<String, Object> getTotalRecommendCount(int noticeboard_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		//System.out.println(noticeboard_no);
		int totalRecommendCount = noticeBoardServiceImpl.getTotalRecommendCount(noticeboard_no);
		//System.out.println(noticeboard_no);
		map.put("totalRecommendCount", totalRecommendCount);
		//System.out.println(totalRecommendCount);
		
		return map;
		
	}
	
	@RequestMapping("getMyRecommendCount.do")
	public HashMap<String, Object> getMyRecommendCount(int noticeboard_no, HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		int myRecommendCount = noticeBoardServiceImpl.getMyRecommendCount(noticeboard_no, member_no);
		
		map.put("myRecommendCount", myRecommendCount);
		
		return map;
		
		
	}
		
		
		
	//=============================================================================

}
