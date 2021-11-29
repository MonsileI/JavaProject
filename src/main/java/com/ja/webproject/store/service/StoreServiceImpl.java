package com.ja.webproject.store.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.product.mapper.ProductSQLMapper;
import com.ja.webproject.shop.mapper.ShopSQLMapper;
import com.ja.webproject.store.mapper.StoreSQLMapper;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.ProductVo;
import com.ja.webproject.vo.StoreVo;

@Service
public class StoreServiceImpl {
	
	@Autowired
	private StoreSQLMapper storeSQLMapper;
	
	@Autowired
	private ShopSQLMapper mainSQLMapper;
	
	@Autowired
	private ProductSQLMapper productSQLMapper;
	
	//글쓰기
	public void storeMake(StoreVo vo) {
		
		int store_no = storeSQLMapper.createStorePK();
		
		vo.setStore_no(store_no);
		storeSQLMapper.storeMake(vo);
					
	}
	
	//게시판 목록 
	public ArrayList<HashMap<String, Object>> getStoreList(int sessionMemberNo) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<StoreVo> storeList = storeSQLMapper.getStoreList(sessionMemberNo);
		
		for(StoreVo storeVo : storeList) {
			
			 int memberNo = storeVo.getMember_no();
			 			 
			 HE_MemberVo memberVo = mainSQLMapper.getMemberByNo(memberNo);
			 
			 HashMap<String, Object> map = new HashMap<String, Object>();
			 
			 map.put("memberVo", memberVo);
			 map.put("storeVo", storeVo);
			 
			 list.add(map);
		}
		
		return list;
	}

	//게시글 개수
	public int getStoreCount(int sessionMemberNo ) {
		
		int count = storeSQLMapper.getStoreCount(sessionMemberNo);
		
		return count;
	}
	
	//상세글 보기
	public HashMap<String, Object> getStoreContent(int store_no) {
		
		StoreVo storeVo = storeSQLMapper.getStoreByNo(store_no);

		String content =  storeVo.getStore_content();
		
		content = StringEscapeUtils.escapeHtml4(content);
		content = content.replaceAll("\n", "<br>");
		
		storeVo.setStore_content(content);
		
		int memberNo = storeVo.getMember_no();
		
		HE_MemberVo memberVo = mainSQLMapper.getMemberByNo(memberNo);
				
		HashMap<String, Object> map = new HashMap<String, Object>();
				
		ArrayList<ProductVo> abc =  productSQLMapper.getProductList(store_no);
		
		map.put("memberVo", memberVo);
		map.put("storeVo", storeVo);
		map.put("abc", abc);
	
		return map;
	}

}
