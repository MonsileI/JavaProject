package com.ja.webproject.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.member.service.MemberServiceImpl;
import com.ja.webproject.ownerboard.service.OwnerBoardServiceImpl;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_NoteBoxVo;
import com.ja.webproject.vo.HE_OwnerBoardVo;

@RequestMapping("/member/*")
@RestController
public class MemberRestController {
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@Autowired
	private OwnerBoardServiceImpl ownerBoardServiceImpl;
	
	
	
	
	//===========================================회원정보 관련=======================================================================
	@RequestMapping("getSessionInfo.do")
	public HashMap<String, Object> getSessionInfo(HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		
		int member_no = sessionUser.getMember_no();
		
		
		//ArrayList<HE_SitterBoardVo> sitterBoardList = sitterBoard_ProcessSsendNoteToOwner.ervice.checkMySitterBoardBtn();//sitterboard중에 신청 수락한 경우(btn상 disabled위해)
		//System.out.println("sitterBoardList_size:"+sitterBoardList.size());
		if(sessionUser != null) {
			
			map.put("isLogin", true);
			map.put("member_no", member_no);
			//map.put("sitterBoardList", sitterBoardList);
			
		}else{
			map.put("isLogin", false);
			
		}
		
		return map;
		
	}
	
	
	//============================쪽지 보내기 
		@RequestMapping("sendNoteToOwner.do")
		public void sendNote(HE_NoteBoxVo param, int finddogboard_no) {
			
			System.out.println("finddogboard_no=" + finddogboard_no);
			System.out.println("last_note_content"+param.getContent());
		

			memberService.sendNote(param);
			
			
			int member_no = param.getMember_no();
			
			
			HE_OwnerBoardVo ownerVo = new HE_OwnerBoardVo();
			ownerVo.setFinddogboard_no(finddogboard_no);
			ownerVo.setMember_no(member_no);
			
			ownerBoardServiceImpl.requestCheckMyDog(ownerVo);
			
			
		}

	
	
	//=========================================================================================
	//========================================시터 요청 수락 시, 권한 변경 체크=======================
	//========================check mydog Authority(finddogboard + sitter)=====================
	
	@RequestMapping("getFinddogAuthority.do")
	public ArrayList<HE_FinddogBoardVo> getFinddogAuthority(HttpSession session){
		
		//System.out.println("getFinddogAuthority0");
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		ArrayList<HE_FinddogBoardVo> myFinddogAuthority = memberService.getMyAuthority(member_no);
		//System.out.println("getFinddogAuthority1 : "+myFinddogAuthority .size());
		
		return myFinddogAuthority;
	}
	
	
	
	//===============중복 ID 검사 - Ajax
	@RequestMapping(value = "checkId.do", method = { RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody int checkId(HE_MemberVo vo, Model model) {
        return memberService.checkId(vo.getId());
    }
	
	//===============중복 ID 검사 - Ajax
	@RequestMapping(value = "checkNick.do", method = { RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody int checkNick(HE_MemberVo vo, Model model) {
        return memberService.checkNick(vo.getNick());
    }
	
	// ===============친구추가 시, ID 검사 - Ajax
	@RequestMapping(value = "checkFriendId.do", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody ArrayList<Integer> checkFriendId(HE_MemberVo vo, Model model, HttpSession session) {
		
		//System.out.println("checkFriendId:"+vo.getMember_no());
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int myMember_no = sessionUser.getMember_no();
		
	
		return memberService.checkMyfriendId(vo, myMember_no);
	}
	
	
	
	//===========================================쪽지함 관련=======================================================================	
	//============================쪽지 확인 여부 체크 
	@RequestMapping("checkNewNote.do")
	public int checkNewNote(HttpSession session) {
		//System.out.println("checkNote_controller");
		
		HE_MemberVo vo = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = vo.getMember_no();
	
		return memberService.checkNewNote(member_no);
	}
	
	
	//============================쪽지 읽기 : 확인여부 읽은 날짜로 변경 
	@RequestMapping("confirmNote.do")
	public String confirmNote(String notebox_no) {
		//System.out.println("confirm");
		memberService.confirmNote(Integer.parseInt(notebox_no));
		return "redirect:./notePage.do";
	}
	/*@RequestMapping(value = "confirmNote.do", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String confirmNote(@RequestParam(value = "notebox_no") String notebox_no) {
		System.out.println("confirm");
		memberService.confirmNote(Integer.parseInt(notebox_no));
		return "redirect:./notePage.do";
	}*/
	
	//============================쪽지 삭제 
	@RequestMapping("deleteCheckedNote.do")
	public String deleteCheckedNote(@RequestParam(value = "chbox[]") List<String> chbox) {
		//System.out.println(chbox);
		memberService.deleteCheckedNote(chbox);
		
		return "redirect:./notePage.do";
		
	}

	//============================그룹 추가 
	@RequestMapping("addGroupProcess.do")
	public void addGroupProcess(@RequestParam(value = "member_no") String member_no,
								@RequestParam(value = "group_name") String group_name) {
		int no = Integer.parseInt(member_no);
		memberService.addGroupProcess(no, group_name);
		//System.out.println(member_no + ":" + group_name);

		//return "redirect:../main/main.do";//"redirect:./notePage.do";
	}
	
	
	//============================Toast
	@RequestMapping("getNewToast.do")
	public HashMap<String, ArrayList<Object>> getNewToast(HttpSession session) {
		
		HashMap<String, ArrayList<Object>> map = new HashMap<String, ArrayList<Object>>();
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		
		int member_no = sessionUser.getMember_no();
		
		if(sessionUser != null) {
			ArrayList<Object> toastList = memberService.getNewToast(member_no);
			ArrayList<Object> senderList = memberService.getSenderList(toastList);
			map.put("toastList", toastList);
			map.put("senderList", senderList);
		}
		
		return map;
	}
	//=====================admin Toast
	@RequestMapping("checkAdminToast.do")
	public HashMap<String, HE_NoteBoxVo> checkAdminToast(HttpSession session) {
		
		HashMap<String, HE_NoteBoxVo> map = new HashMap<String,HE_NoteBoxVo>();
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		
		int member_no = sessionUser.getMember_no();
		
		if(sessionUser != null) {
			HE_NoteBoxVo adminVo = memberService.checkAdminToast(member_no);
			
			if(adminVo != null) {
				map.put("adminVo", adminVo);
			}
		}
		return map;
		
	}
	

}
