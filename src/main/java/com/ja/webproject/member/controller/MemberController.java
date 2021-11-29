package com.ja.webproject.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.webproject.member.service.MemberServiceImpl;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_NoteBoxVo;
import com.ja.webproject.vo.HE_NoteBox_FriendListVo;
import com.ja.webproject.vo.HE_NoteBox_GroupListVo;
import com.ja.webproject.vo.HE_Species_CategoryVo;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberServiceImpl memberService;

	
	
	//============================나의 쪽지함 첫 화면
	@RequestMapping("notePage.do")
	public String notePage(HttpSession session, Model model, 
							String search_type_recv, String search_word_recv,
							String search_type_sent, String search_word_sent,
							@RequestParam(defaultValue = "1") int page_num, 
							@RequestParam(defaultValue = "1") int page_num_recv) {

		HE_MemberVo vo = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = vo.getMember_no();

		//====================================================
		//=============쪽지테이블 & 페이징
		ArrayList<ArrayList<HashMap<String, Object>>> list = memberService.getNoteContent(member_no, 
																						search_type_recv, search_word_recv,
																						search_type_sent, search_word_sent,
																						page_num, page_num_recv);

		
		//1. sendBox : member_no = member_no
		ArrayList<HashMap<String, Object>> sentList = list.get(0);
		// 전체 글 수
		ArrayList<Integer> count = memberService.getNoteCount(member_no,
															search_type_recv, search_word_recv,
															search_type_sent, search_word_sent,
															page_num, page_num_recv);
		
		// 전체 글 수
		int sentCount = count.get(0);
		//System.out.println("sent:"+sentCount);
		// 전체 페이지 수(각 페이지 10개 글)
		int sentTotalPageCount = (int) Math.ceil(sentCount / 10.0);
		// 현재 페이지 번호
		int sentCurrentPage = page_num;
		// 보여줄 시작 페이지번호
		int sentBeginPage = ((sentCurrentPage - 1) / 5) * 5 + 1;
		// 보여줄 끝 페이지번호
		int sentEndPage = ((sentCurrentPage - 1) / 5 + 1) * (5);

		if (sentEndPage > sentTotalPageCount) {
			sentEndPage = sentTotalPageCount;
		}

		String sentAddParam = "";

		if (search_type_sent != null && search_word_sent != null) {
			sentAddParam += "&search_type_sent=" + search_type_sent;
			sentAddParam += "&search_word_sent=" + search_word_sent;
		}
		
		model.addAttribute("sentAddParam", sentAddParam);

		model.addAttribute("sentCurrentPage", sentCurrentPage);
		model.addAttribute("sentBeginPage", sentBeginPage);
		model.addAttribute("sentEndPage", sentEndPage);
		model.addAttribute("sentTotalPageCount", sentTotalPageCount);

		model.addAttribute("sentList", sentList);
		model.addAttribute("sentCount", sentCount);
		
		//2. inBox : friend_no = member_no
		ArrayList<HashMap<String, Object>> recvList = list.get(1);
		// 전체 글 수
		int recvCount = count.get(1);
		System.out.println("recv:"+recvCount);
		// 전체 페이지 수(각 페이지 10개 글)
		int recvTotalPageCount = (int) Math.ceil(recvCount / 10.0);
		// 현재 페이지 번호
		int recvCurrentPage = page_num_recv;
		// 보여줄 시작 페이지번호
		int recvBeginPage = ((recvCurrentPage - 1) / 5) * 5 + 1;
		// 보여줄 끝 페이지번호
		int recvEndPage = ((recvCurrentPage - 1) / 5 + 1) * (5);

		if (recvEndPage > recvTotalPageCount) {
			recvEndPage = recvTotalPageCount;
		}

		String recvAddParam = "";

		if (search_type_recv != null && search_word_recv != null) {
			recvAddParam += "&search_type_recv=" + search_type_recv;
			recvAddParam += "&search_word_recv=" + search_word_recv;
		}
		model.addAttribute("recvAddParam", recvAddParam);

		model.addAttribute("recvCurrentPage", recvCurrentPage);
		model.addAttribute("recvBeginPage", recvBeginPage);
		model.addAttribute("recvEndPage", recvEndPage);
		model.addAttribute("recvTotalPageCount", recvTotalPageCount);

		model.addAttribute("recvList", recvList);
		model.addAttribute("recvCount", recvCount);
		
//		//====================================================
//		//=============그룹 & 친구 테이블   
//		===> 매인 접속 시, 로그인 체크 후, session에 저장하는 것으로 변경함(전체 영역에서 Address modal(popup) 쓰려고)
//		
//		ArrayList<HashMap<HE_NoteBox_GroupListVo, ArrayList<HE_MemberVo>>> groupList = memberService.getGroupList(member_no);
//
//		model.addAttribute("groupList", groupList);

		return "/member/notePage";
	}
	
	//============================쪽지 보내기 
	@RequestMapping("sendNoteProcess.do")
	public String sendNote(HE_NoteBoxVo param) {
		//System.out.println("send");
		memberService.sendNote(param);

		return "redirect:./notePage.do"; // "/member/notePage";//"redirect:../member/notePage.do";//
	}

	//============================그룹 삭제 : 해당 그룹에 속했던 친구들 기본 그룹으로 이동 -> 그룹 삭제 
	@RequestMapping("deleteGroupProcess.do")
	public String deleteGroupProcess(HttpSession session, int before_grouplist_no) {
		
		//System.out.println(before_grouplist_no);
		HE_MemberVo vo = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = vo.getMember_no();
		
		memberService.deleteGroupProcess(member_no, before_grouplist_no);

		return "redirect:../main/main.do";//"redirect:./notePage.do";
	}
	//============================그룹명 변경 
	@RequestMapping("updateGroupProcess.do")
	public String updateGroupProcess(HE_NoteBox_GroupListVo groupVo) {
		memberService.updateGroupProcess(groupVo);
		return "redirect:../main/main.do";//"redirect:./notePage.do";
	}
	
	//============================친구 추가 
	@RequestMapping("addFriendProcess.do")
	public String addFriendProcess(String grouplist_no, String id) {
		//System.out.println(grouplist_no+":"+ id);
		
		memberService.addFriendProcess(Integer.parseInt(grouplist_no), id);
		return "redirect:../main/main.do";//"redirect:./notePage.do";
	}
	//============================친구 삭제 
	@RequestMapping("deleteFriendProcess.do")
	public String deleteFriendProcess(HE_NoteBox_FriendListVo vo) {
	
		memberService.deleteFriendProcess(vo);
		
		return "redirect:../main/main.do";//"redirect:./notePage.do";
	}
	//============================친구의 그룹 변경 
	@RequestMapping("updateFriendGroupProcess.do")
	public String updateFriendGroupProcess(String before_grouplist_no, HE_NoteBox_FriendListVo vo) {

		int grouplist_no = vo.getGrouplist_no();
		int friend_no = vo.getFriend_no();
		
		//System.out.println(before_grouplist_no+":"+grouplist_no+":"+friend_no);
				
		memberService.updateFriendGroupProcess(Integer.parseInt(before_grouplist_no), grouplist_no, friend_no);
		
		return "redirect:../main/main.do";//"redirect:./notePage.do";
		
	}
	
	//============================ mypage - 나의 견추적
	@RequestMapping("myDogHistoryPage.do")
	public String getMyDogHistory(Model model, HttpSession session, @RequestParam(defaultValue = "1") int page_number) {		

		HE_MemberVo vo = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = vo.getMember_no();
		
		ArrayList<HashMap<HE_FinddogBoardVo, ArrayList<HashMap<String,Object>>>>  contentList = memberService.getMyDogHistory(member_no, page_number);

		model.addAttribute("myDogHistory",  contentList);
		
/*
		int count = memberService.getMyDogHistoryCount(member_no, page_number); // 전체
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

		model.addAttribute("addParam", addParam);

		model.addAttribute("currentPage", currentPage);
		model.addAttribute("beginPage", beginPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPageCount", totalPageCount);

		model.addAttribute("contentList", contentList); // request라고 생각하면 됨 (메인페이지로 포워딩)
		
		*/
		
		
		return "./sitterboard_process/myDogHistoryPage";
		
	}
	
	

	

}
