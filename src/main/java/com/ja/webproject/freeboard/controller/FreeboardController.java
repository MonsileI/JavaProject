package com.ja.webproject.freeboard.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.webproject.freeboard.service.FreeboardServiceImpl;
import com.ja.webproject.vo.FreeBoardVo;

@Controller
@RequestMapping("/freeboard/*")
public class FreeboardController {

	@Autowired
	//private FreeboardServiceImpl freeboardService;

	@RequestMapping("freeTest.do")
	public String freeboardTest() {
		
		return "/freeboard/freeTest";
	}
	
	@RequestMapping("freeTestProcess.do")
	public String freeboardTest(
				FreeBoardVo vo, 
				String likeCheck,
				Model model) { 
		
		System.out.println("freeTest controller" + likeCheck);
		
		int num = 100;
		num+=Integer.parseInt(likeCheck);
		System.out.println("recommendCount:"+num);
		model.addAttribute("freeboardVo",num);
		
//		if(likeCookie.equals("yes")){
//			System.out.println("getcookie:" + likeCookie);
//			Cookie cookie = new Cookie("like", "no");
//			response.addCookie(cookie);
//			System.out.println("setting no");
//
//		}else{
//			Cookie cookie = new Cookie("like", "yes");
//			cookie.setMaxAge(60*60*24);
//			response.addCookie(cookie);
//			System.out.println("setting yes");
//		}

		return "/freeboard/freeTestResult";
	}
}


//, 
//@CookieValue(value="like", required=false) String likeCookie,
//HttpServletResponse response