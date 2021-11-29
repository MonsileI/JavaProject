package com.ja.webproject.main.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.webproject.finddogboard.mapper.FinddogBoardSQLMapper;
import com.ja.webproject.finddogboard.service.FinddogBoardServiceImpl;
import com.ja.webproject.lostdogboard.mapper.LostdogBoardSQLMapper;
import com.ja.webproject.lostdogboard.service.LostdogBoardServiceImpl;
import com.ja.webproject.main.service.MainServiceImpl;
import com.ja.webproject.member.service.MemberServiceImpl;
import com.ja.webproject.noticeboard.service.NoticeBoardServiceImpl;
import com.ja.webproject.sitterboard.service.SitterBoardServiceImpl;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_FinddogBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_LostDogBoardVo;
import com.ja.webproject.vo.HE_LostDogBoard_ImageBoardVo;
import com.ja.webproject.vo.HE_MailAuthVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_NoteBox_GroupListVo;
import com.ja.webproject.vo.HE_Species_CategoryVo;

@Controller
@RequestMapping("/main/*")
public class MainController {

	@Autowired
	private MainServiceImpl mainService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@Autowired
	private FinddogBoardServiceImpl finddogboardServiceImpl;

	@Autowired
	private  FinddogBoardSQLMapper finddogBoardSQLMapper;
	
	@Autowired
	private LostdogBoardSQLMapper lostdogBoardSQLMapper;
	
	@Autowired
	private NoticeBoardServiceImpl noticeBoardServiceImpl;
	
	@Autowired
	private SitterBoardServiceImpl sitterListServiceImpl;
	

	//회원 가입시 인증 메일 클래스
	@Autowired
	private JavaMailSender mailSender;

	
	
	/*public int getMemberById(String id){
		return mainService.getMemberById(id);
	}*/
	
	/* js class example
	@RequestMapping("main2.do")
		public String main2() {
			
			return "/main/main2";
	}*/
	
	@RequestMapping("main.do")
	public String main(Model model, HttpSession session) {
		
		
		
		//==============메인 팝업창 or 링크 - 회원 여부 상관없이, 메인에서 불러올 data(finddogboardList)
		ArrayList<HashMap<String,Object>> finddogTotalList = mainService.getMainFinddogBoard();
		model.addAttribute("finddogTotalList",finddogTotalList);
		
		
		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		
		
		//====================================================
		//=============메인페이지 로딩 시, finddogBoard 모든 글 가져오기(전체 영역에서 쓰려고
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<HE_FinddogBoardVo> finddogBoardList = finddogBoardSQLMapper.getContents(null,null,1);
		
		
		for(HE_FinddogBoardVo boardVo : finddogBoardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
			
			HE_FinddogBoard_ImageBoardVo boardImageVoList = finddogBoardSQLMapper.getImageForList(boardVo.getFinddogboard_no());
			
			
			HashMap<String, Object> map = new HashMap<String, Object>();//결합되어야 하는 정보가 멤버와 보드이기 때문에 object 타입
			//돌때마다 하나씩 해쉬맵 생성
			
			map.put("boardVo", boardVo);
			map.put("imageVo", boardImageVoList);
			//돌때마다 memberVo값과 boardVo값을 넣어줌.
			
			list.add(map);
			//같은 멤버넘버인 memberVo랑 boardVo랑 결합해서 넣어줌.
			
			//즉, member_no가 같은 memberVo와 BoardVo를 결합하는 로직이지!
		
		}
		
		model.addAttribute("finddogBoardList", list);
		
		
		//====================================================
	    //=============메인페이지 로딩 시, lostdogBoard 모든 글 가져오기(전체 영역에서 쓰려고
	      
	      ArrayList<HashMap<String, Object>> lostdoglist = new ArrayList<HashMap<String,Object>>();
	      
	      ArrayList<HE_LostDogBoardVo> lostdogBoardList = lostdogBoardSQLMapper.getContents(null,null,1);
	      
	      
	      for(HE_LostDogBoardVo boardVo : lostdogBoardList) { //보드 글 수만큼 돌거야 for문으로 ㅇㅋ?
	         
	         HE_LostDogBoard_ImageBoardVo boardImageVoList = lostdogBoardSQLMapper.getImageForList(boardVo.getLostdogboard_no());
	         
	         
	         HashMap<String, Object> map2 = new HashMap<String, Object>();//결합되어야 하는 정보가 멤버와 보드이기 때문에 object 타입
	         //돌때마다 하나씩 해쉬맵 생성
	         
	         map2.put("boardVo", boardVo);
	         map2.put("imageVo", boardImageVoList);
	         //돌때마다 memberVo값과 boardVo값을 넣어줌.
	         
	         lostdoglist.add(map2);
	         //같은 멤버넘버인 memberVo랑 boardVo랑 결합해서 넣어줌.
	         
	         //즉, member_no가 같은 memberVo와 BoardVo를 결합하는 로직이지!
	      
	      }
	      
	      //견종 선택 리스트(db에서 불러와서 목록에 뿌리기)
	      ArrayList<HE_Species_CategoryVo> petlist = finddogboardServiceImpl.getSpeciesCategoryList();
		  model.addAttribute("speciesCategoryList", petlist);
	      
	      model.addAttribute("lostdogBoardList", lostdoglist);
			
	      //공지사항============================================================
	         
	      ArrayList<HashMap<String, Object>> noticeList = noticeBoardServiceImpl.getContents(null, null,1);
	         
	      model.addAttribute("noticeList", noticeList);
	         
	         
	         
	      //시터보드===========================================================
	      ArrayList<HashMap<String, Object>> sitterList = sitterListServiceImpl.getContents(null, null,1);
	         
	      model.addAttribute("sitterList", sitterList);
	      
	         
	         
	         
		//==============회원일 경우, 메인에서 불러올 data(1.groupList, 2.내가 쓴 finddogBoard 글 중에 status='ING'인 글) -> 2번은 삭제 
		if (sessionUser != null) {
			
			//====================================================
			//=============메인페이지 로딩 시, 그룹 & 친구 테이블 정보 가져오기 (전체 영역에서 Address modal(popup) 쓰려고)
			int member_no = sessionUser.getMember_no();
			
			ArrayList<HashMap<HE_NoteBox_GroupListVo, ArrayList<HE_MemberVo>>> groupList = memberService.getGroupList(member_no);
			//System.out.println("groupINFO:"+groupList.size());
			session.setAttribute("groupList", groupList);
		

			return "/main/main";
		}
			

		return "/main/main";
	}

	@RequestMapping("loginPage.do")
	public String loginPage() {
		return "/main/loginPage";
	}

	// ==============================login 시도
	@RequestMapping("loginProcess.do")
	public String loginProcess(Model model, HttpSession session, HE_MemberVo param) {

		HE_MemberVo sessionUser = mainService.login(param);
		Set<Integer> visited = new HashSet<>();


		if (sessionUser != null) {

			session.setAttribute("sessionUser", sessionUser);
			session.setAttribute("visited", visited);
			
			/*
			//====================================================
			//=============로그인 시, 그룹 & 친구 테이블 정보 가져오기 (전체 영역에서 Address modal(popup) 쓰려고) -> 매안 접속 시로 바꿈 
			int member_no = sessionUser.getMember_no();
			
			ArrayList<HashMap<HE_NoteBox_GroupListVo, ArrayList<HE_MemberVo>>> groupList = memberService.getGroupList(member_no);
			//System.out.println("groupINFO:"+groupList.size());

			session.setAttribute("groupList", groupList);*/


			return "redirect:../main/main.do";
		}

		return "main/loginFailPage";
	}

	// ==============================logout 시도
	@RequestMapping("logoutProcess.do")
	public String logoutProcess(HttpSession session) {

		session.invalidate();

		return "redirect:../main/main.do";
	}
	
	
	// ==============================회원 가입 페이지

		@RequestMapping("joinMemberPage.do")
		public String joinMemberPage(Model model) {

			return "main/joinMemberPage";
		}

		// ==============================회원 가입 기입 후 sumbit
		@RequestMapping("joinMemberProcess.do")
		public String joinMemberProcess(HE_MemberVo param) {
			
			//System.out.println(param.getPetName() +":"+ param.getCoin());
			if(param.getPetName() == null) {
				//System.out.println("null");
				param.setPetName("N");
			}

			// ------회원 가입시, 인증 메일 전송 서비스 설정
			// root-context.xml파일 - 메일 관련 인스턴스 추가(구글 api) && MailAutho class랑 db 만들기
			// 랜덤 키 생성
			// class MailSendThread
			String uuid = UUID.randomUUID().toString();

			HE_MailAuthVo mailAuthVo = new HE_MailAuthVo();
			mailAuthVo.setMail_key(uuid);

			// 메일 보내는 thread 생성 및 실행
			MailSendThread th = new MailSendThread(mailSender, param.getEmail(), uuid);
			th.start();

			
			// insert db 처리
			mainService.joinMember(param, mailAuthVo);
		

			return "main/joinMemberComplete";
		}

		//==============================인증 메일 확인 시
		@RequestMapping("certifyMail.do")
		public String certifyMail(String mail_key) {

			mainService.certifyMail(mail_key);

			return "main/certifyMailComplete";
		}
}

//========================================================================================================================
//==============================회원 가입, 인증 메일 발송(thread로 처리)
//========================================================================================================================
class MailSendThread extends Thread {

	private JavaMailSender mailSender;
	private String mailAddress;
	private String key;

	public MailSendThread(JavaMailSender mailSender, String mailAddress, String key) {
		this.mailSender = mailSender;
		this.mailAddress = mailAddress;
		this.key = key;
	}

	public void run() {
		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

			mimeMessageHelper.setSubject("[인증 메일] 회원 가입을 축하드립니다.");

			// 인증 메일 확인 시 보낼 페이지(파람에 키값 받아서 처리)
			String text = "";
			text += "<h1>회원 가입 완료</h1>";
			text += "다음 링크를 클릭하여 인증을 완료해 주세요.<br>";
			text += "<a href='http://localhost:8181/webproject/main/certifyMail.do?mail_key=" + key + "'>";
			text += "인증하기";
			text += "</a>";

			mimeMessageHelper.setText("내용: " + text, true);// 순수문자(true) or html(false)

			try {
				mimeMessageHelper.setFrom("admin", "사이트 관리자");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

			mimeMessageHelper.setTo(mailAddress);
			mailSender.send(mimeMessage);

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

}