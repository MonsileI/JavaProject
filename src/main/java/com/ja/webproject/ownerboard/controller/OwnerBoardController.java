package com.ja.webproject.ownerboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.webproject.finddogboard.mapper.FinddogBoardSQLMapper;
import com.ja.webproject.finddogboard.service.FinddogBoardServiceImpl;
import com.ja.webproject.ownerboard.service.OwnerBoardServiceImpl;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_OwnerBoardVo;

@Controller
@RequestMapping("/ownerboard/*")
public class OwnerBoardController {

	@Autowired
	private OwnerBoardServiceImpl ownerBoardServiceImpl;
	
	@Autowired 
	private FinddogBoardServiceImpl finddogBoardServiceImpl;
	
	@Autowired
	private FinddogBoardSQLMapper finddogBoardSQLMapper;
	
	@RequestMapping("finalStep.do")
	public String finalStep(HE_OwnerBoardVo vo, Model model) {
		
		ownerBoardServiceImpl.finalStep(vo);
		int finddogboard_no = vo.getFinddogboard_no();
		HE_FinddogBoardVo finddogVo = new HE_FinddogBoardVo();
		finddogVo = finddogBoardSQLMapper.getContentByNo(finddogboard_no);
		finddogVo.setStatus("Y");
		
		finddogBoardServiceImpl.completeFinddog(finddogVo);
		
		//model.addAttribute("owner", vo);
		
		
		return "redirect:../finddogboard/readHE_FinddogPage.do?finddogboard_no=" + vo.getFinddogboard_no();
	}
	
	
	
}


	