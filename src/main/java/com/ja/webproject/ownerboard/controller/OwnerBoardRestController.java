package com.ja.webproject.ownerboard.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.webproject.finddogboard.service.FinddogBoardServiceImpl;
import com.ja.webproject.ownerboard.service.OwnerBoardServiceImpl;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_OwnerBoardVo;



@RequestMapping("/ownerboard/*")
@RestController
public class OwnerBoardRestController {


	@Autowired
	private OwnerBoardServiceImpl ownerBoardServiceImpl;
	
	@Autowired
	private FinddogBoardServiceImpl finddogBoardServiceImpl;
	
	@RequestMapping("getNoteList.do")
	public ArrayList<HE_MemberVo> getNoteList(int finddogboard_no){
		
		return ownerBoardServiceImpl.getNoteList(finddogboard_no);
		
	
	}
	
	@RequestMapping("completeFinddog.do")
	public void completeFinddog(HE_FinddogBoardVo finddogVo) {
		
		finddogBoardServiceImpl.completeFinddog(finddogVo);
		
		HE_OwnerBoardVo ownerVo = new HE_OwnerBoardVo();
		ownerVo.setFinddogboard_no(finddogVo.getFinddogboard_no());
		ownerVo.setStatus(finddogVo.getStatus());
		
		ownerBoardServiceImpl.finalStep(ownerVo);
		
	}
	
}
