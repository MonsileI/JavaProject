package com.ja.webproject.chattingboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.webproject.chattingboard.service.ChattingBoardServiceImpl;
import com.ja.webproject.vo.HE_ChattingBoardVo;
import com.ja.webproject.vo.HE_ChattingRoomBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_LikeVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_Species_CategoryVo;

@RequestMapping("/chattingboard/*")
@Controller
public class ChattingBoardController {
	
	@Autowired
	private ChattingBoardServiceImpl chattingBoardServiceImpl;
	
	
	
	@RequestMapping("HE_ChattingBoardList.do")
	public String HE_ChattingBoardList(
						Model model, 
						String search_type, 
						String search_word,
						@RequestParam(defaultValue = "1") int page_number)
		{
		
		
		
		ArrayList<HashMap<String, Object>> contentList = chattingBoardServiceImpl.getChattingContents(search_type, search_word,
				page_number);

		int count = chattingBoardServiceImpl.getChattingContentCount(search_type, search_word, page_number); // 전체
																											// searching한
																											// 보드 갯수값

		int totalPageCount = (int) Math.ceil(count / 10.0); // 반올림 함수. 1.1이면 2가 나오면 되니까~! 전체글이 55개면 토탈카운트페이지는 55/10의
															// 반올림값

		int currentPage = page_number; // 지금 들어가있는 페이지

		int beginPage = ((currentPage - 1) / 5) * 5 + 1; // int값이니까 1 (int값은 실수인 .이하의 소수값인 경우 0이 됨;; 이걸 이용하다니..
		int endPage = ((currentPage - 1) / 5 + 1) * (5); // int값이니까 5

		if (endPage > totalPageCount) {

			endPage = totalPageCount; // 끝페이지 맞추기 위해서!

		}

		// 페이지 링크 만들어주는 메소드(정상적 검색, null값이 아닌 경우에 추가하는 메소드)
		String addParam = "";

		if (search_type != null && search_word != null) {
			addParam += "&search_type=" + search_type; // 이거 ""안에 띄어쓰기하면 인식 안된다잉 ㅇㅋ?
			addParam += "&search_word=" + search_word;
		}
		model.addAttribute("addParam", addParam);

		model.addAttribute("currentPage", currentPage);
		model.addAttribute("beginPage", beginPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPageCount", totalPageCount);

		model.addAttribute("contentList", contentList); // request라고 생각하면 됨 (메인페이지로 포워딩)
		
		
		
		return "chattingboard/HE_ChattingBoardList";

	}
	
	@RequestMapping("HE_MakeChattingPage.do")
	public String HE_MakeChattingPage() {
		
		return "chattingboard/HE_MakeChattingPage";
		
	}
	//채팅방 만들기
	@RequestMapping("MakeChattingProcess.do")
	public String MakeChattingProcess(HE_ChattingBoardVo vo, HttpSession session) {
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");

		int member_no = sessionUser.getMember_no();// 그래서 세션을 불러온거임

		vo.setMember_no(member_no);
		
		chattingBoardServiceImpl.MakeChattingProcess(vo);
		
		//============바로 호스트가 접속하기 위한 메소드===================
		
		int my = chattingBoardServiceImpl.joinMyChattingRoom(member_no);
		
		return "redirect:./joinChattingRoomPage.do?chattingboard_no="+my;
		
	}

	
	//채팅방 들어가기
	@RequestMapping("joinChattingRoomPage.do")
	public String joinChattingRoomPage(int chattingboard_no , Model model, HttpSession session) {
		
		//채팅 입장할때 문구
		

		try {
			
			//조회...
			HashMap<String, Object> map = chattingBoardServiceImpl.joinChattingRoom(chattingboard_no);
			
			model.addAttribute("content", map);
			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			return "redirect:./HE_ChattingBoardList.do";
			
		}
		HE_MemberVo sessionUser = (HE_MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		HE_ChattingRoomBoardVo vo = new HE_ChattingRoomBoardVo();
		vo.setMember_no(member_no);
		vo.setChatting_content(sessionUser.getNick()+"님 [입장]");
		vo.setChattingboard_no(chattingboard_no);	
		
		chattingBoardServiceImpl.writeChattingProcess(vo);

		
	
		return "chattingboard/HE_ChattingRoom";
	}
	
	//채팅방 나가기
	@RequestMapping("exitChattingRoom.do")
	public String exitChattingRoom(HE_ChattingRoomBoardVo vo, HttpSession session) {
		
		//채팅 나갈때 문구
		
				HE_MemberVo sessionUser = (HE_MemberVo)session.getAttribute("sessionUser");
				int member_no = sessionUser.getMember_no();

				vo.setMember_no(member_no);
				vo.setChatting_content(sessionUser.getNick()+"님 [퇴장]");
				vo.setChattingboard_no(vo.getChattingboard_no());
				chattingBoardServiceImpl.writeChattingProcess(vo);
	
		
		vo.setMember_no(sessionUser.getMember_no());
		
		chattingBoardServiceImpl.exitChattingRoom(vo);
		
		
		
		return "redirect:./HE_ChattingBoardList.do";
	}
	

	
	
	

}
