package com.ja.webproject.store.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ja.webproject.store.service.StoreServiceImpl;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.StoreVo;


@Controller
@RequestMapping("/store/*")
public class StoreController {
	
	@Autowired
	private StoreServiceImpl storeService;
	
	
	//상점 쓰기 페이지로 이동
	@RequestMapping("storeMake.do")
	public String storeMake() {
		return "store/storeMake";
		
	}
	
	//상점 글쓰기 저장
	@RequestMapping("storeMakeProcess.do")
	public String storeMakeProcess(StoreVo param , MultipartFile abc , HttpSession session) {
		System.out.println("write");
		String rootFolderName = "/Users/soos/Desktop/uploadFolder/";

		String originalFilename = abc.getOriginalFilename();
		String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
		String uuidName = UUID.randomUUID().toString();
		long currentTimeMillis = System.currentTimeMillis();
		String randomFileName = uuidName + "_" + currentTimeMillis + ext;

		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String todayFolderName = sdf.format(today);
		String uploadFolderName = rootFolderName + todayFolderName;

		File uploadFolder = new File(uploadFolderName);

		if (!uploadFolder.exists()) {
			uploadFolder.mkdirs();
		}

		String saveFilePathName = uploadFolderName + "/" + randomFileName;

		try {
			abc.transferTo(new File(saveFilePathName));
		} catch (Exception e) {
			e.printStackTrace();
		}

		param.setLogo_link(todayFolderName + "/" + randomFileName);

		HE_MemberVo sessionUser = (HE_MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();

		param.setMember_no(member_no);

		storeService.storeMake(param);

		return "redirect:./storeList.do";
	}
	
	//게시판 리스트 페이지로 이동(리스트 불러오기)
		@RequestMapping("storeList.do")
		public String storeList(Model model, HttpSession session) {
			
			HE_MemberVo sessionUser = (HE_MemberVo)session.getAttribute("sessionUser");
			int member_no = sessionUser.getMember_no();
			
			ArrayList<HashMap<String, Object>> contentList = storeService.getStoreList(member_no);
						
			model.addAttribute("contentList",contentList);
			
			return "store/storeList";
		}
		
		//상세글 보기
		@RequestMapping("storeView.do")
		public String readContentPage(int store_no , Model model) {						
			//조회
			HashMap<String, Object> map = storeService.getStoreContent(store_no);
					
			model.addAttribute("content", map);	
			model.addAttribute("store_no",store_no);
			return "store/storeView";
		}
	
	
	
	

}
