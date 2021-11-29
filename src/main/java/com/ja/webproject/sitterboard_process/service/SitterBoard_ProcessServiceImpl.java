package com.ja.webproject.sitterboard_process.service;


import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.webproject.finddogboard.mapper.FinddogBoardSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.sitterboard_process.mapper.SitterBoard_ProcessSQLMapper;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_ProcessVo;

@Service
public class SitterBoard_ProcessServiceImpl {
	@Autowired
	private FinddogBoardSQLMapper finddogBoardSQLMapper;
	
	
	@Autowired
	private SitterBoard_ProcessSQLMapper sitterBoard_ProcessSQLMapper;
	
	//==========================================================================================시터보드게시판의 신청글 클릭시==================================================
	public int checkSitterRequest(HE_SitterBoard_ProcessVo vo) {
		int result = sitterBoard_ProcessSQLMapper.checkSitterRequest(vo);
		return result;
		
	}
	
	public void sitterRequest(HE_SitterBoard_ProcessVo vo){
		
		sitterBoard_ProcessSQLMapper.sitterRequest(vo);
		
	}
	
	
	
	//======================================================================== 마이페이지에서 시터게시판 볼때(신청)================================================================
	
	public ArrayList<HashMap<HE_FinddogBoardVo, HE_SitterBoard_ProcessVo>> sitterRequestListPage(int member_no){
		
		
		ArrayList<HashMap<HE_FinddogBoardVo, HE_SitterBoard_ProcessVo>> topList = new ArrayList<HashMap<HE_FinddogBoardVo, HE_SitterBoard_ProcessVo>>();
		
		ArrayList<HE_SitterBoard_ProcessVo> requestList= new ArrayList<HE_SitterBoard_ProcessVo>();//시터 신청한 경우에 값 저장할 리스트 
		//시터 요청,수락한 내역이 있는 리스트 loop 
		
		ArrayList<HE_SitterBoard_ProcessVo> list = sitterBoard_ProcessSQLMapper.sitterRequestListPage(member_no);//내가 시터 요청한 목록 
		
		
		for(int i = 0; list.size() > i; i++) {

			requestList.add(list.get(i));
			System.out.println("requestList: "+list.get(i));

		}
		
		for(int i = 0; requestList.size() > i; i++) {
			
			int finddogboard_no = requestList.get(i).getFinddogboard_no();
			HE_FinddogBoardVo finddogVo =  finddogBoardSQLMapper.getContentByNo(finddogboard_no);
			
			HashMap<HE_FinddogBoardVo, HE_SitterBoard_ProcessVo> map = new HashMap<HE_FinddogBoardVo, HE_SitterBoard_ProcessVo>();
			
			map.put(finddogVo, requestList.get(i));
			topList.add(map);
			
		}
		
		return topList;

	
		/*
		ArrayList<HashMap<HE_FinddogBoardVo, ArrayList<HE_SitterBoard_ProcessVo>>> topList = new ArrayList<HashMap<HE_FinddogBoardVo,ArrayList<HE_SitterBoard_ProcessVo>>>();
		
		
		//===================1. 권한이었던 모든 글 가져오기(원래 + 중간에)
	
		//-------------------1_1. 원래 내가 쓴 글 가져오기 
		ArrayList<HE_FinddogBoardVo> initialFinddogList = memberSQLMapper.loseAuthority_fromFinddogBoard(member_no); //finddog에도 있는 method
		System.out.println("1. 원래 내 글 아닌 경우 목록 개수 :"+initialFinddogList.size());
				
		
		
		//-------------------1_2. 중간에 내가 권한 부여받은 글 가져오기
		
		//1_1. sitterboard로부터 내가 쓴 글 가져오기
		ArrayList<Integer> getSitterNoList = memberSQLMapper.getAuthority_fromSitterBoard(member_no);
		//System.out.println("1_1."+getSitterNoList.size());
		
		//1_2. SitterBoard_Process로부터 내가 시터신청 수락한 글 가져오기 
		ArrayList<Integer> getFinddogNoList = new ArrayList<Integer>();
		
		for(int sitterNo : getSitterNoList) {
			
			//try catch 쓰는 거 맞는지 체크 
			try {
				//System.out.println("1_2."+"sitterNO:"+sitterNo);
				ArrayList<Integer> finddogBoardNo = memberSQLMapper.getAuthority_fromSitterBoard_Process(sitterNo);
				
				for(Integer no : finddogBoardNo) {

					getFinddogNoList.add(no);
				}
	
			}catch(Exception e) {
				//System.out.println("1_2."+"sitterNO_nothing");
				//System.out.println(e.getMessage());
			}
		}
		
		//1_3. 수락하여 얻은 FinddogBoard 글의 권한 가져오기 
		ArrayList<HE_FinddogBoardVo> getFinddogList = new ArrayList<HE_FinddogBoardVo>();
		
		for(int finddogNo : getFinddogNoList) {
			
			//try catch 쓰는 거 맞는지 체크 
			try {
				
				//원래 내글 목록과 비교 후, 원래 내 글 아닌 경우만 저장 
				for(int i = 0 ; initialFinddogList.size() > i; i++) {
					
					if(finddogNo == initialFinddogList.get(i).getFinddogboard_no()) {
						System.out.println("원래 내글이기에 추가 안함 : finddogboard_no: " + finddogNo);
						break;
						
					}else if(initialFinddogList.size()-1 == i && finddogNo != initialFinddogList.get(i).getFinddogboard_no()) {
						HE_FinddogBoardVo finddogVo = memberSQLMapper.getAuthority_fromFinddogBoard(finddogNo);
						System.out.println("원래 내 글 아니기에 추가 : " + " finddogboard_no : "+finddogNo+", finddogVo : "+finddogVo);
						getFinddogList.add(finddogVo);
					}
					
				}
				
				
			}catch(Exception e) {
				System.out.println("1_3."+"finddogNo_nothing");
				System.out.println("finddogVo == null"+ e.getMessage());
				
			}
		}
		
		System.out.println("2. 원래 내 글 아닌 경우 목록 개수 : "+getFinddogList.size());
		
		
		
		
		
		//===================2. 각각의 finddogBoardList loop돌면서, 신청 요청했던 목록 저장하기 
		
		
		//-------------------2.1 내 글이었던 경우 ->initialFinddogList
		
		for(HE_FinddogBoardVo vo :  initialFinddogList) {
			
			
			try {
				
				ArrayList<HE_SitterBoard_ProcessVo> list= sitterBoard_ProcessSQLMapper.sitterRequestListPage(vo);//내가 시터 요청한 목록 
				
				//1.
				//case 1. 지금까지 시터 요청,수락한 경우가 없을 때 
				if(list.size() == 0) {
					continue;
					
				//case 2. 지금까지 시터 요청,수락한 경우가 있고, 여러번 권한 변경이 있을 경우 
				}else if(list.size() > 0){
					
					System.out.println("requestList.size() > 1");
					
					ArrayList<HE_SitterBoard_ProcessVo> requestList= new ArrayList<HE_SitterBoard_ProcessVo>();//시터 신청한 경우에 값 저장할 리스트 
					//시터 요청,수락한 내역이 있는 리스트 loop 
					for(int i = 0; list.size() > i; i++) {

						requestList.add(list.get(i));
						System.out.println("mine_requestList: "+list.get(i));
	
					}
					
					//3. 시터 신청 내역이 없을 경우, 저장하지 말기 
					if(requestList.size() == 0) {
						continue;
					//3. 시터 신청 내역이 있을 경우, 저장하기  
					}else {
						HashMap<HE_FinddogBoardVo,ArrayList<HE_SitterBoard_ProcessVo>> map = new HashMap<HE_FinddogBoardVo,ArrayList<HE_SitterBoard_ProcessVo>>();
						map.put(vo, requestList);
						topList.add(map);
					}
					
				}
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			
			
		}
		
		
		//1.2 내 글이 아니었던 경우 -> getFinddogList
		for(HE_FinddogBoardVo vo : getFinddogList) {
			
			
			try {
				
				ArrayList<HE_SitterBoard_ProcessVo> list= sitterBoard_ProcessSQLMapper.sitterRequestListPage(vo);//내가 시터 요청한 목록 
				
				//1.
				//case 1. 지금까지 시터 요청,수락한 경우가 없을 때 
				if(list.size() == 0) {
					continue;
					
				//case 2. 지금까지 시터 요청,수락한 경우가 있고, 여러번 권한 변경이 있을 경우 
				}else if(list.size() > 0){
					
					System.out.println("requestList.size() > 1");
					
					ArrayList<HE_SitterBoard_ProcessVo> requestList= new ArrayList<HE_SitterBoard_ProcessVo>();//시터 신청한 경우에 값 저장할 리스트 
					//시터 요청,수락한 내역이 있는 리스트 loop 
					for(int i = 0; list.size() > i; i++) {
						
//						//index가 홀수인 경우가 시터 신청한 경우 
//						if(i % 2 == 1) {
//							requestList.add(list.get(i));
//							System.out.println("not mine_requestList: "+list.get(i));
//							//continue;
//						}
						
						
					}
					
					//3. 시터 신청 내역이 없을 경우, 저장하지 말기 
					if(requestList.size() == 0) {
						continue;
					//3. 시터 신청 내역이 있을 경우, 저장하기  
					}else {
						HashMap<HE_FinddogBoardVo,ArrayList<HE_SitterBoard_ProcessVo>> map = new HashMap<HE_FinddogBoardVo,ArrayList<HE_SitterBoard_ProcessVo>>();
						map.put(vo, requestList);
						topList.add(map);
					}
					
				}
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			
		}
		*/
		
	}
	
	
	
	//=======================신청 취소
	public  void cancelSitterRequest(int no) {
		
		sitterBoard_ProcessSQLMapper.cancelSitterRequest(no);
	}
	
	
	
	//========================================================================마이페이지에서 시터게시판 볼때(수락)================================================================
	
	public  ArrayList<HashMap<HE_SitterBoardVo, ArrayList<HE_SitterBoard_ProcessVo>>> sitterAcceptListPage(HE_MemberVo vo){
		
		
		ArrayList<HashMap<HE_SitterBoardVo, ArrayList<HE_SitterBoard_ProcessVo>>> topList = new ArrayList<HashMap<HE_SitterBoardVo, ArrayList<HE_SitterBoard_ProcessVo>>>();
		
		
		ArrayList<HE_SitterBoardVo> mySitterList = sitterBoard_ProcessSQLMapper.getMySitterBoardList(vo);
		
		
		for(HE_SitterBoardVo sitterVo : mySitterList) {
			
			try {
				
				ArrayList<HE_SitterBoard_ProcessVo> mySitterAcceptList = sitterBoard_ProcessSQLMapper.sitterAcceptListPage(sitterVo);
				
				if(mySitterAcceptList.size() == 0) {
					continue;
					
				}else {
					HashMap<HE_SitterBoardVo,ArrayList<HE_SitterBoard_ProcessVo>> map = new HashMap<HE_SitterBoardVo, ArrayList<HE_SitterBoard_ProcessVo>>();
					
					map.put(sitterVo, mySitterAcceptList);
					topList.add(map);
				}
				
			} catch (Exception e) {
				
				System.out.println(e.getMessage());
				
			}
			
			
		}
		//topList.add(map);
		
		return topList;
	}
	
	
	//=======================수락 거절
	public  void cancelSitterAccept(int no) {
		
		sitterBoard_ProcessSQLMapper.cancelSitterAccept(no);
	}
	
	
	//======================================================================== 수락 버튼 클릭 시, status 변경 ========================================================================
	
	//=======================1. sitterboard에 글 올린 시터인 사람이 여러 사람으로부터 신청받은 경우, 해당 수락한 글 제외하고 거절상태로 변경
	
	public void change_StatusNo_AcceptAll(HE_MemberVo memberVo, HE_SitterBoard_ProcessVo sitterProcessVo) {
		
		System.out.println("상태변경1-내가받은 모든 요청에 대하여 거절");
		//본인이 시터 요청 받은 모든 글 
		ArrayList<HE_SitterBoardVo> sitterList = sitterBoard_ProcessSQLMapper.getMySitterBoardList(memberVo);
		
		//시터 요청을 수락한 글의 sitterboard_no  
		int thisSitterboard_no = sitterProcessVo.getSitterboard_no();
		
		//루프 돌면서, 
		for(HE_SitterBoardVo vo : sitterList) {
			
			int sitterboard_no = vo.getSitterboard_no();
			
			System.out.println("loop: " + sitterboard_no );
			
			//자신이 요청 받은 글의 sitterboard_no != 방금 수락한 글 sitterboard_no, status = 'N'으로 바꿔주기
			if(sitterboard_no != thisSitterboard_no) {
				
				System.out.println("수락한 글이 아님: " + sitterboard_no + ":" + thisSitterboard_no);
				sitterBoard_ProcessSQLMapper.change_StatusNo_AcceptAll(sitterboard_no);
			}
			
			
		}
		
	}
	
	//=======================2. finddogBoard에 글 올린 사람이 여러 시터에게 신청한 경우, 해당 수락한 시터 제외하고 거절상태로 변경
	
	public void change_Status(HE_SitterBoard_ProcessVo vo) {
		
		System.out.println("상태변경2-나의 수락과 동시에 상대방이 신청했던 모든 요청에 대하여 거절");
		
		//내 수락으로 인해, 해당 글의 status = 'Y'로 변경 
		sitterBoard_ProcessSQLMapper.change_StatusYes_Accept(vo);
		//내 수락으로 인해, 상대방이 요청했던 타 시터들에 대한 요청 자동 거절 status='N'으로 변경 
		sitterBoard_ProcessSQLMapper.change_StatusNo_RequestAll(vo);
	}

/*	
	//==============3.sitterboard 신청버튼 disable -> 
	//내가 작성한 sitterboard 글로인해 받은 요청을 수락한 경우, 해당 글에서는 신청 받지 않기로!(버튼 작동 멈추게하려고)
	public ArrayList<HE_SitterBoardVo> checkMySitterBoardBtn(){
		
		return sitterBoard_ProcessSQLMapper.checkMySitterBoardBtn();
		
	};
	
*/
}
