package com.ja.webproject.sitterboard.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.sitterboard.service.SitterBoardServiceImpl;
import com.ja.webproject.vo.HE_MemberVo;


@RestController
@RequestMapping("/sitterboard/*")
public class SitterRestBoardController {
	@Autowired
	public SitterBoardServiceImpl sitterBoardServiceImpl;
	
	//===============추천============================================================
	
		@RequestMapping("processRecommend.do")
		public void processRecommend(int sitterboard_no, HttpSession session) {
			
			
			HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
			int member_no = sessionUser.getMember_no();
			
			sitterBoardServiceImpl.processRecommend(sitterboard_no, member_no);
			
			
			
		}
		
		@RequestMapping("getTotalRecommendCount.do")
		public HashMap<String, Object> getTotalRecommendCount(int sitterboard_no){
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int totalRecommendCount = sitterBoardServiceImpl.getTotalRecommendCount(sitterboard_no);
			map.put("totalRecommendCount", totalRecommendCount);
			
			return map;
			
		}
		
		@RequestMapping("getMyRecommendCount.do")
		public HashMap<String, Object> getMyRecommendCount(int sitterboard_no, HttpSession session){
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
			int member_no = sessionUser.getMember_no();
			
			int myRecommendCount = sitterBoardServiceImpl.getMyRecommendCount(sitterboard_no, member_no);
			
			map.put("myRecommendCount", myRecommendCount);
			
			return map;
			
			
		}
			
			
			
		//=============================================================================


}
