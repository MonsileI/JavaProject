package com.ja.webproject.store.mapper;

import java.util.ArrayList;

import com.ja.webproject.vo.StoreVo;

public interface StoreSQLMapper {
	
	//PK
	public int createStorePK();
	
	//상점 등록하기
	public void storeMake(StoreVo vo);
	
	//게시글 목록 
	public ArrayList<StoreVo> getStoreList(int member_no);

	//게시글 개수
	public int getStoreCount (int member_no);
	
	//상세 상점 보기
	public StoreVo getStoreByNo(int store_no);
	
	

}
