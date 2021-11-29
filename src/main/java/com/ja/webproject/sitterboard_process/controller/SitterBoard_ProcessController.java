package com.ja.webproject.sitterboard_process.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.webproject.sitterboard_process.service.SitterBoard_ProcessServiceImpl;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_ProcessVo;

@Controller
@RequestMapping("/sitterboard_process/*")
public class SitterBoard_ProcessController {
	
	@Autowired
	private SitterBoard_ProcessServiceImpl sitterBoard_ProcessService;
	
	
	
	@RequestMapping("HE_SitterBoard_ProcessList.do")
	public String sitterBoard_ProcessList() {
		
		return "sitterboard_process/HE_SitterBoard_ProcessList";
	}
	
	@RequestMapping("sitterRequestComplete.do")
	public String sitterRequestComplete() {
		
		return "sitterboard_process/sitterRequestComplete";
	}
	
	@RequestMapping("sitterRequestFail.do")
	public String sitterRequestFail() {
		
		return "sitterboard_process/sitterRequestFail";
	}
	
	//=============================================================== 시터보드게시판의 시터 신청 버튼 클릭 시================================================================
	@RequestMapping("sitterRequest.do")
	public String sitterRequest(String finddogboard_no, String message, HE_SitterBoardVo sitterVo, HttpSession session) {//HE_SitterBoard_ProcessVo vo
		
		//System.out.println("request_0"+":"+sitterboard_no+":"+finddogboard_no+":"+message);
		HE_MemberVo memberVo = (HE_MemberVo) session.getAttribute("sessionUser");
		int memberNo = memberVo.getMember_no();
		int sitterMemberNo = sitterVo.getMember_no();
		
		//시터신청한 게 자신인 경우에는 신청 불가 
		if(memberNo == sitterMemberNo) {
			
			return "redirect:../sitterboard_process/sitterRequestFail.do";
			
		//그외 신청 가능 
		}else{
		
			int sitterboardNo = sitterVo.getSitterboard_no();
			int finddogboardNo = Integer.parseInt(finddogboard_no);
			
			HE_SitterBoard_ProcessVo vo = new HE_SitterBoard_ProcessVo();
			vo.setSitterboard_no(sitterboardNo);
			vo.setFinddogboard_no(finddogboardNo);
			vo.setMember_no(memberNo);
			vo.setMessage(message);
			
			//중복신청 여부 체크 
			int result = sitterBoard_ProcessService.checkSitterRequest(vo);
			
			//중복 아닐 경우에, 신청 가능 
			if(result == 0) {
				
				try{
					
					sitterBoard_ProcessService.sitterRequest(vo);
					System.out.println("request_1");
					
					return "redirect:../sitterboard_process/sitterRequestComplete.do";
				}
				catch (Exception e) {
					
					//System.out.println(e.getMessage());
					
					return "redirect:../sitterboard_process/sitterRequestFail.do";
				}
				
			//중복일 경우, 신청 불가 	
			}else {
				return "redirect:../sitterboard_process/sitterRequestFail.do";
			}
		}
		
	}

	//========================================================================마이페이지에서 시터게시판 볼때(신청)================================================================
	
	@RequestMapping("sitterRequestListPage.do")
	public String sitterRequestListPage(HttpSession session, Model model){
		
		HE_MemberVo memberVo = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = memberVo.getMember_no();
		
		
		ArrayList<HashMap<HE_FinddogBoardVo, HE_SitterBoard_ProcessVo>> sitterRequestList = sitterBoard_ProcessService.sitterRequestListPage(member_no);
		//System.out.println("sitter:" + sitterRequestList);
		
		
		model.addAttribute("sitterRequestList", sitterRequestList);
		
		return "sitterboard_process/sitterRequestListPage";
		
	}
	
	
	//======================================================================== 마이페이지에서 시터게시판 볼때(수락) ================================================================
	@RequestMapping("sitterAcceptListPage.do")
	public String sitterAcceptListPage(HttpSession session, Model model){
		
		HE_MemberVo vo = (HE_MemberVo) session.getAttribute("sessionUser");
		
			
		ArrayList<HashMap<HE_SitterBoardVo, ArrayList<HE_SitterBoard_ProcessVo>>> sitterAcceptList = sitterBoard_ProcessService.sitterAcceptListPage(vo);
		
		model.addAttribute("sitterAcceptList", sitterAcceptList);
		
		//System.out.println(sitterAcceptList.size());
		
		return "sitterboard_process/sitterAcceptListPage";
		
	}
	
	//======================================================================== 시터 요청한 사람이 취소 버튼 클릭 시 ========================================================================
	
	@RequestMapping("cancelSitterRequest.do")
	public String cancelSitterRequest(String sitterboard_process_no) {
		
		//System.out.println("cancle:"+sitterboard_process_no);
		
		int no = Integer.parseInt(sitterboard_process_no);
		sitterBoard_ProcessService.cancelSitterRequest(no);
	
		
		return "redirect:../sitterboard_process/sitterRequestListPage.do";
	}
	
	//======================================================================== 시터 요청받은 사람이 수락버튼 클릭 시, status 변경 ========================================================================

	@RequestMapping("sittetAccept.do")
	public String sittetAccept(HE_SitterBoard_ProcessVo sitterVo, HttpSession session) {
		
		HE_MemberVo memberVo = (HE_MemberVo)session.getAttribute("sessionUser");
		int member_no = memberVo.getMember_no();
		
		//System.out.println("acceptQuery:"+member_no);
		
		//=======================1. sitterboard에 글 올린 시터인 사람이 여러 사람으로부터 신청받은 경우, 해당 수락한 글 제외하고 거절상태로 변경
		sitterBoard_ProcessService.change_StatusNo_AcceptAll(memberVo, sitterVo);
		//=======================2. finddogBoard에 글 올린 사람이 여러 시터에게 신청한 경우, 해당 수락한 시터 제외하고 거절상태로 변경
		sitterBoard_ProcessService.change_Status(sitterVo);
		
		
		return "redirect:../sitterboard_process/sitterAcceptListPage.do";
	}
	

	//======================================================================== 시터 요청받은 사람이 수락 거절 버튼 클릭  ======================================================================================
	@RequestMapping("cancelSitterAccept.do")
	public String cancelSitterAccept(String sitterboard_process_no) {
		
		//System.out.println("cancle:"+sitterboard_process_no);
		
		int no = Integer.parseInt(sitterboard_process_no);
		sitterBoard_ProcessService.cancelSitterAccept(no);
	
		
		return "redirect:../sitterboard_process/sitterAcceptListPage.do";
	}
	
	
	
	
	
	
	
	
}
