package com.ja.webproject.product.mapper;

import java.util.ArrayList;

import com.ja.webproject.vo.BuyVo;
import com.ja.webproject.vo.ProductVo;
import com.ja.webproject.vo.StoreVo;

public interface ProductSQLMapper {
	
	//PK
	public int createProductPK();
	
	//물품 등록
	public void productWrite(ProductVo vo);
	
	//물품 목록 게시글
	public ArrayList<ProductVo> getProductList(int store_no);
	
	//물품 게시글 개수
	public int getProductCount(int store_no);
	
	//상세 물품 보기
	public ProductVo getProductByNo(int product_no);
	
	//Store에서 member_no가져오기
	public StoreVo getStore(int store_no);
	
	public void buy(BuyVo vo);
	
	public int remainAmount(int product_no);
	
}
