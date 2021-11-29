package com.ja.webproject.product.controller;

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

import com.ja.webproject.product.service.ProductServiceImpl;
import com.ja.webproject.vo.BuyVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.ProductVo;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	private ProductServiceImpl productService;
	
	//물품등록 페이지로 이동
	@RequestMapping("productWrite.do")
	public String productWrite(int store_no , Model model) {
				
		model.addAttribute("store_no", store_no);
		
		return "product/productWrite";
		
	}
	
	@RequestMapping("test.do")
	public String test() {
		
		return "product/test";
	}
	
	//물품등록 저장
	@RequestMapping("productWriteProcess.do")
	public String productWriteProcess(ProductVo param, MultipartFile abc) {
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

		param.setProduct_image(todayFolderName + "/" + randomFileName);
		
		productService.productWrite(param);
		
		return "redirect:../store/storeView.do?store_no=" + param.getStore_no();
	}
	
	//물품 리스트 페이지로 이동(리스트 불러오기)
	@RequestMapping("productList.do")
	public String productList(Model model, int store_no) {
		
		ArrayList<HashMap<String, Object>> contentList = productService.getProductList(store_no);
			
		model.addAttribute("contentList", contentList);
		model.addAttribute("store_no", store_no);
		
		return "product/productList";
	}
	
	//상세 물품 보기
	@RequestMapping("productView.do")
	public String readContentPage(int product_no , Model model) {						
		//조회
		HashMap<String, Object> map = productService.getStoreContent(product_no);
		
		int xxxx = productService.getRemainAmount(product_no);
		
		model.addAttribute("remainAmount", xxxx);			
		
		model.addAttribute("content", map);			
		model.addAttribute("product_no", product_no);			
		return "product/productView";
	}
	
	@RequestMapping("buyProduct.do")
	public String buyProduct(BuyVo vo , HttpSession  session , Model model) {
		
		HE_MemberVo sessionUser =  (HE_MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		vo.setMember_no(member_no);
		
		boolean canBuy = productService.canBuy(vo);
		if(canBuy == false) {
			model.addAttribute("product_no", vo.getProduct_no());	
			return "product/buyFail";
		}
		
		productService.buy(vo);
		
		return "product/buySuccess";
	}

}
