package com.ja.webproject.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.webproject.mypage.service.MyPageServiceImpl;

@Controller
@RequestMapping("/mypage/*")
public class MyPageController {
	
	
	@Autowired
	public MyPageServiceImpl myPageServiceImpl;

	
	//마이페이지 첫 화면 
	@RequestMapping("myPage.do")
	public String myPage() {
		
		return "mypage/myPage";
	}

	//기본 정보 수정 화면 
	@RequestMapping("editMyInfo.do")
	public String editMyInfo() {
		
		return "mypage/editMyInfo";
	}
	//연락처 정보 수정 화면
	@RequestMapping("editMyContactInfo.do")
	public String editMyContactInfo() {
		
		return "mypage/editMyContactInfo";
	}
	
	
	
	
	
}




