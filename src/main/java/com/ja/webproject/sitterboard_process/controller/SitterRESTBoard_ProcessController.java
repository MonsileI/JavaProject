package com.ja.webproject.sitterboard_process.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.sitterboard_process.service.SitterBoard_ProcessServiceImpl;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_ProcessVo;

@RestController
@RequestMapping("/sitterboard_process/*")
public class SitterRESTBoard_ProcessController {

	@Autowired
	private SitterBoard_ProcessServiceImpl sitterBoard_ProcessService;

	
	
	
	
	// ===================================시터 신청 하기 전에 마감 시한 비교 위함 
	public int DateCompare(String endDate) {

		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		LocalDate now = LocalDate.now();

		String day1 = null;
		String day2 = null;
		int result = 0;

		try {

			day1 = dateFormat.format(endDate);
			day2 = dateFormat.format(now);
			
			System.out.println("day:_"+day1+":"+day2);

		} catch (Exception e) {
			e.printStackTrace();
		}

		int compare = day1.compareTo(day2);
		
		if (compare > 0) {
			System.out.println("day1 > day2");
			result = 1;
		}
		
		return result;
		
	}

	// =============================================================== 시터보드게시판의 시터
	// 신청 버튼 클릭, 신청 불가한 경우 체크
	// ================================================================
	@RequestMapping("checkSitterRequest.do")
	public HashMap<String, Integer> checkSitterRequestt(String sitterboard_no, String finddogboard_no, String sitterMember_no, HttpSession session){

		HashMap<String, Integer> map = new HashMap<String, Integer>();
		System.out.println("testests");

		/*System.out.println("request_0"+":"+sitterboard_no+":"+finddogboard_no);
		HE_MemberVo memberVo = (HE_MemberVo) session.getAttribute("sessionUser");
		int memberNo = memberVo.getMember_no();
		
		int finddogboardNo = Integer.parseInt(finddogboard_no);
		int sitterboardNo = Integer.parseInt(sitterboard_no);
		int sitterMemberNo = Integer.parseInt(sitterMember_no);

		HE_SitterBoard_ProcessVo vo = new HE_SitterBoard_ProcessVo();
		vo.setSitterboard_no(sitterboardNo);
		vo.setFinddogboard_no(finddogboardNo);
		vo.setMember_no(memberNo);
		

		DateCompare(endDate);

		// 중복신청 여부 & 기간 체크하기
		int result = sitterBoard_ProcessService.checkSitterRequest(vo);

		// 시터 신청한 게 자신인 경우에는 신청 불가
		if (memberNo == sitterMemberNo) {
			System.out.println("me");
			map.put("data", 0);

		//시터 신청한 게 중복인 경우 
		} else if (result != 0) {
			System.out.println("twice");
			map.put("data", 1);
			
		//마감기한 지난 경우 
		} else if (result == 0) {
			System.out.println("endDate");
			map.put("data", 2);

	
		}
		*/
		return map;

	}
	
	
	
}
