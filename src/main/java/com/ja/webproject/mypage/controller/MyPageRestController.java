package com.ja.webproject.mypage.controller;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.commons.MessageDigestUtil;
import com.ja.webproject.main.service.MainServiceImpl;
import com.ja.webproject.member.service.MemberServiceImpl;
import com.ja.webproject.mypage.service.MyPageServiceImpl;
import com.ja.webproject.vo.HE_MailAuthVo;
import com.ja.webproject.vo.HE_MemberVo;

@RequestMapping("/mypage/*")
@RestController
public class MyPageRestController {
	
	@Autowired
	private MyPageServiceImpl myPageService;


	//회원 가입시 인증 메일 클래스
	@Autowired
	private JavaMailSender mailSender;
	
	
	//=====Id 수정시 
	@RequestMapping("editMyId.do")
	public void editMyId(String id, HttpSession session){
		
		//System.out.println("controller:"+id);
		
		HE_MemberVo vo = (HE_MemberVo)session.getAttribute("sessionUser");
		vo.setId(id);
		
		myPageService.editMyId(vo);
		
	}
	
	//=====NickName 수정시 
	@RequestMapping("editMyNick.do")
	public void editMyNick(String nick, HttpSession session){
		
		//System.out.println("controller:"+nick);
		
		HE_MemberVo vo = (HE_MemberVo)session.getAttribute("sessionUser");
		vo.setNick(nick);
		
		myPageService.editMyNick(vo);
		
	}	
	
	//=====birth 수정시 
	@RequestMapping("editMyBirth.do")
	public void editMyBirth(@DateTimeFormat(pattern = "yyyy-MM-dd") Date birth, HttpSession session){
		
		//System.out.println("controller:"+birth);

		HE_MemberVo vo = (HE_MemberVo)session.getAttribute("sessionUser");
		vo.setBirth(birth);
		
		myPageService.editMyBirth(vo);
		
	}
	
	//=====petName 수정시 
	@RequestMapping("editMyPetName.do")
	public void editMyBirth(String petName, HttpSession session){
		
		//System.out.println("controller:"+petName);

		HE_MemberVo vo = (HE_MemberVo)session.getAttribute("sessionUser");
		vo.setPetName(petName);
		
		myPageService.editMyPetName(vo);
		
	}	
	
	//=====address 수정시 
	@RequestMapping("editMyAddress.do")
	public void editMyAddress(String address, String postCode, HttpSession session){
		
		//System.out.println("controller:"+address+","+postCode);

		HE_MemberVo vo = (HE_MemberVo)session.getAttribute("sessionUser");
		vo.setAddress(address);
		vo.setPostCode(postCode);
		
		myPageService.editMyAddress(vo);
		
	}	
	
	
	//=====비밀번호 수정 전에 다시 입력 받기 
	@RequestMapping("checkBeforePw.do")
	public int checkBeforePw(String pw, HttpSession session){
		System.out.println("controller:"+pw);
		
		//입력받은 비번 해쉬코드로 변경 후 select Member
		String hashCode = MessageDigestUtil.getPasswordHashCode(pw);
		
		HE_MemberVo vo = (HE_MemberVo)session.getAttribute("sessionUser");
		vo.setPw(hashCode);
		
		int result = myPageService.checkBeforePw(vo);
		//틀리면 0, 맞으면 1 리턴
		System.out.println("controller:"+result);
		
		return result;
			
	}		

	//=====비밀번호 수정시 
	@RequestMapping("editMyPw.do")
	public void editMyPw(String pw, HttpSession session){
		
		System.out.println("controller:" + pw);

		//입력받은 비번 해쉬코드로 변경 후 select Member
		String hashCode = MessageDigestUtil.getPasswordHashCode(pw);
		
		HE_MemberVo vo = (HE_MemberVo)session.getAttribute("sessionUser");
		vo.setPw(hashCode);
		
		myPageService.editMyPw(vo);
		
	}	
	
	//=====email 수정 전에 => 인증 메일 확인
	@RequestMapping("certifyEditMail.do")
	public String certifyEditMail(String mail_key) {
		
		myPageService.certifyEditMail(mail_key); 

		return "mypage/certifyEditMailComplete";
	}
	
	//=====email 수정시 
	@RequestMapping("editMyEmail.do")
	
	public void editMyEmail(String email, HttpSession session){
		
		System.out.println("controller:" + email);

		HE_MemberVo vo = (HE_MemberVo)session.getAttribute("sessionUser");
		vo.setEmail(email);
		
		
		// ------메일 변경 시, 인증 메일 전송 서비스 설정
		// root-context.xml파일 - 메일 관련 인스턴스 추가(구글 api) && MailAutho class랑 db 만들기
		// 랜덤 키 생성
		// class MailSendThread
		String uuid = UUID.randomUUID().toString();

		HE_MailAuthVo mailAuthVo = new HE_MailAuthVo();
		mailAuthVo.setMail_key(uuid);

		// 메일 보내는 thread 생성 및 실행
		MailEditSendThread th = new MailEditSendThread(mailSender, email, uuid);
		th.start();

		// insert db 처리
		myPageService.editMyEmail(vo, mailAuthVo);
	
		
	}

		
}


//========================================================================================================================
//==============================회원 이메일 변경, 인증 메일 발송(thread로 처리)
//========================================================================================================================
class MailEditSendThread extends Thread {

	private JavaMailSender mailSender;
	private String mailAddress;
	private String key;

	public MailEditSendThread(JavaMailSender mailSender, String mailAddress, String key) {
		this.mailSender = mailSender;
		this.mailAddress = mailAddress;
		this.key = key;
	}

	public void run() {
		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

			mimeMessageHelper.setSubject("[인증 메일] 메일 주소 변경.");

			// 인증 메일 확인 시 보낼 페이지(파람에 키값 받아서 처리)
			String text = "";
			text += "<h1>메일 변경 완료</h1>";
			text += "다음 링크를 클릭하여 변경을 완료해 주세요.<br>";
			text += "<a href='http://localhost:8181/webproject/mypage/certifyEditMail.do?mail_key=" + key + "'>";
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