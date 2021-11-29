package com.ja.webproject.ownerboard.mapper;

import java.util.ArrayList;

import com.ja.webproject.vo.HE_OwnerBoardVo;

public interface OwnerBoardSQLMapper {
	
	public void requestCheckMyDog(HE_OwnerBoardVo ownerVo);
	
	public ArrayList<Integer> getNoteList(int finddogboard_no);
	
	public void finalStep(HE_OwnerBoardVo vo);
	
	public void cancelFinalStep(HE_OwnerBoardVo vo);
	
	public HE_OwnerBoardVo thereIsOwner(int finddotboard_no);
	
}
