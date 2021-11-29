package com.ja.webproject.product.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.product.mapper.ProductSQLMapper;
import com.ja.webproject.vo.BuyVo;
import com.ja.webproject.vo.ProductVo;
import com.ja.webproject.vo.StoreVo;

@Service
public class ProductServiceImpl {

	@Autowired
	private ProductSQLMapper productSQLMapper;

	// 물품 등록
	public void productWrite(ProductVo vo) {

		int product_no = productSQLMapper.createProductPK();

		vo.setProduct_no(product_no);

		productSQLMapper.productWrite(vo);

	}

	// 물품 게시글 목록
	public ArrayList<HashMap<String, Object>> getProductList(int store_no) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		ArrayList<ProductVo> productList = productSQLMapper.getProductList(store_no);

		for (ProductVo productVo : productList) {

			int storeNo = productVo.getStore_no();
			
			StoreVo storeVo = productSQLMapper.getStore(storeNo);

			System.out.println(storeNo);

			HashMap<String, Object> map = new HashMap<String, Object>();

			map.put("storeVo", storeVo);
			map.put("productVo", productVo);

			list.add(map);
		}

		return list;
	}

	// 상세 물품 보기
	public HashMap<String, Object> getStoreContent(int product_no) {
		System.out.println("a");

		ProductVo productVo = productSQLMapper.getProductByNo(product_no);
		System.out.println("b");
		String content = productVo.getProduct_content();
		System.out.println("[변환전테스트]" + content);

		content = StringEscapeUtils.escapeHtml4(content);
		System.out.println("[변환후테스트]" + content);

		content = content.replaceAll("\n", "<br>");

		productVo.setProduct_content(content);

		int storeNo = productVo.getStore_no();

		StoreVo storeVo = productSQLMapper.getStore(storeNo);

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("storeVo", storeVo);
		map.put("productVo", productVo);

		return map;
	}

	public void buy(BuyVo vo) {
		productSQLMapper.buy(vo);
	}
	
	public boolean canBuy(BuyVo vo) {
		
		int remainAmount = productSQLMapper.remainAmount(vo.getProduct_no());
		
		if(remainAmount < vo.getBuy_amount()) {
			return false;
		}else {
			return true;
		}
	}
	
	public int getRemainAmount(int product_no) {
		int remainAmount = productSQLMapper.remainAmount(product_no);
		return remainAmount;
	}
	
	
}
