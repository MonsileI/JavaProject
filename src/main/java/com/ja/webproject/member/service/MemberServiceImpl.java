package com.ja.webproject.member.service;

import org.apache.commons.text.StringEscapeUtils;
import org.apache.ibatis.javassist.expr.NewArray;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.webproject.finddogboard.mapper.FinddogBoardSQLMapper;
import com.ja.webproject.finddogboard.service.FinddogBoardServiceImpl;
import com.ja.webproject.main.mapper.MainSQLMapper;
import com.ja.webproject.member.mapper.MemberSQLMapper;
import com.ja.webproject.sitterboard.mapper.SitterBoardSQLMapper;
import com.ja.webproject.sitterboard_process.mapper.SitterBoard_ProcessSQLMapper;
import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_NoteBoxVo;
import com.ja.webproject.vo.HE_NoteBox_FriendListVo;
import com.ja.webproject.vo.HE_NoteBox_GroupListVo;
import com.ja.webproject.vo.HE_SitterBoardVo;
import com.ja.webproject.vo.HE_SitterBoard_ProcessVo;


@Service
public class MemberServiceImpl {

	@Autowired // DI(setter 주입)
	private MemberSQLMapper memberSQLMapper;
	
	@Autowired 
	private SitterBoard_ProcessSQLMapper sitterBoard_ProcessSQLMapper;
	
	@Autowired
	private SitterBoardSQLMapper sitterBoardSQLMapper;
	
	@Autowired
	private FinddogBoardServiceImpl finddogBoardServiceImpl;
	
	@Autowired
	private FinddogBoardSQLMapper finddogBoardSQLMapper;
	
	//==========================================회원 관련===========================================================
	//===============중복 ID 검사 - Ajax
	public int checkId(String inputedId) {
		int result = memberSQLMapper.checkId(inputedId);
		
		return result;
	}
	
	//===============중복 Nick 검사 - Ajax
	public int checkNick(String inputedNick) {
		int result = memberSQLMapper.checkNick(inputedNick);
		
		return result;
	}
	
	
	//===============친구추가 시, ID 검사 - Ajax
	public ArrayList<Integer> checkMyfriendId(HE_MemberVo vo, int myMember_no) {

		//System.out.println(vo.getMember_no());
		ArrayList<Integer> list = new ArrayList<>();
		
		try {
			
			HE_MemberVo memberVo = memberSQLMapper.getFriendById(vo.getId());
			int friend_no  = memberVo.getMember_no();
			
			list.add(friend_no);
			
			int member_no = memberVo.getMember_no();
			ArrayList<HE_NoteBox_GroupListVo> groupList = memberSQLMapper.getGroupList(myMember_no);
				
			for(HE_NoteBox_GroupListVo groupVo : groupList) {
				int grouplist_no = groupVo.getGrouplist_no();
				int count = memberSQLMapper.checkMyFriend(grouplist_no, member_no);
					
				if(count == 1) {//이미 내 친구일 때 
					//System.out.println("myfriend");
						
					//추가 불가 but 메시지 전송 가능할 시, 2
					list.add(2);
					return list;
				}
			}
	
			//추가 가능할 때 1
			list.add(1);
			return list;
			
			
		} catch (Exception e) {
			//System.out.println("null");
	
			//추가 불가 시, 0
			list.add(0);
			return list;
		}
	}

	
	//==========================================쪽지함 관련===========================================================
	
	//======================= 미확인 쪽지 개수 확인
	public int checkNewNote(int member_no) {
		return memberSQLMapper.checkNewNote(member_no);	
	}
	
	//=======================쪽지함 컨텐츠 받기 - receive, sent 따로 받기 -> 나중에 수정 고려 한번에 받고 자바에서 나누기로 
	public ArrayList<ArrayList<HashMap<String, Object>>> getNoteContent(int member_no, 
																		String search_type_recv, String search_word_recv,
																		String search_type_sent, String search_word_sent,
																		int page_num, int page_num_recv) {

		
		ArrayList<ArrayList<HashMap<String, Object>>> list = new ArrayList<>();
		ArrayList<HashMap<String, Object>> list1 = new ArrayList<HashMap<String, Object>>();
		ArrayList<HashMap<String, Object>> list2 = new ArrayList<HashMap<String, Object>>();

		// table로부터 값 빼기
		ArrayList<HE_NoteBoxVo> sentList = memberSQLMapper.getSentContent(member_no,
																		search_type_sent, search_word_sent,
																		page_num);

		for (HE_NoteBoxVo sentNoteBoxVo: sentList) {
			int friend_no = sentNoteBoxVo.getFriend_no(); //수신인(친구)정보
			
			HE_MemberVo sentMemberVo = memberSQLMapper.getMemberByNo(friend_no);

			// HashMap<String, Objec>에 두 vo(memberVo+boardVo) 합치기
			HashMap<String, Object> sentMap = new HashMap<String, Object>();

			sentMap.put("sentMemberVo", sentMemberVo);
			sentMap.put("sentNoteBoxVo", sentNoteBoxVo);

			// 최종 ArrayList에 차례로 <HashMap<String, Object> 정보(vo(memberVo+boardVo) 넣기
			list1.add(sentMap);
		}
		
		ArrayList<HE_NoteBoxVo> recvList = memberSQLMapper.getRecvContent(member_no,
																		search_type_recv, search_word_recv,
																		page_num);
			
		for(HE_NoteBoxVo recvNoteBoxVo : recvList) {
			int friend_no = recvNoteBoxVo.getMember_no(); //수신인(친구)정보
			// Member table로부터 member_no 값으로 데이터 빼기
			HE_MemberVo recvMemberVo = memberSQLMapper.getMemberByNo(friend_no);

			HashMap<String, Object> recvMap = new HashMap<String, Object>();

			recvMap.put("recvMemberVo", recvMemberVo);
			recvMap.put("recvNoteBoxVo", recvNoteBoxVo);

			// 최종 ArrayList에 차례로 <HashMap<String, Object> 정보(vo(memberVo+boardVo) 넣기
			list2.add(recvMap);
		
		}
		list.add(list1);
		list.add(list2);
		
		return list;
	}
	
	//======================= 쪽지함 총 컨텐츠 개수 받기
	public ArrayList<Integer> getNoteCount(int member_no, 
											String search_type_recv, String search_word_recv,
											String search_type_sent, String search_word_sent, 
											int page_num, int page_num_recv) {

		int sentCount = memberSQLMapper.getSentCount(member_no,
													search_type_sent, search_word_sent,
													page_num);

		// System.out.println("count: "+count);
		int recvCount = memberSQLMapper.getRecvCount(member_no,
													search_type_recv, search_word_recv,
													page_num);

		ArrayList<Integer> countList = new ArrayList<>();
		countList.add(sentCount);
		countList.add(recvCount);
		
		return countList;
	}
		
	//======================= 쪽지함 세부 컨텐츠 받기
	public HashMap<String, Object> getContent(int notebox_no) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		HE_NoteBoxVo noteBoxVo = memberSQLMapper.getContentByNo(notebox_no);

		// html escape API
		String content = noteBoxVo.getContent();
		System.out.println("[변환 전 테스트] " + content);

		content = StringEscapeUtils.escapeHtml4(content);
		System.out.println("[변환 후 테스트] " + content);

		content = content.replaceAll("\n", "<br>");
		noteBoxVo.setContent(content);

		int member_no = noteBoxVo.getMember_no();
		HE_MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);

		map.put("memberVo", memberVo);
		map.put("noteBoxVo", noteBoxVo);


		return map;
		
	}
	
	//======================= 쪽지 보내기(쓰기)
	public void sendNote(HE_NoteBoxVo noteVo) {
		
		memberSQLMapper.sendNote(noteVo);
		
	}
	
	
	//======================= 받은 쪽지 확인
	public void confirmNote(int notebox_no) {
		memberSQLMapper.confirmNote(notebox_no);
	}
	
	
	//======================= 선택된 쪽지 지우기
	public void deleteCheckedNote(List<String> chbox){
		for(String str : chbox) {
			int no = Integer.parseInt(str);
			memberSQLMapper.deleteCheckedNote(no);
			//System.out.println("service:"+no);
		}
	}
	
	//======================= 그룹 & 친구 목록 가져오기
	public ArrayList<HashMap<HE_NoteBox_GroupListVo, ArrayList<HE_MemberVo>>> getGroupList(int member_no){
		

		ArrayList<HashMap<HE_NoteBox_GroupListVo, ArrayList<HE_MemberVo>>> topList = new ArrayList<>();
		
		
		ArrayList<HE_NoteBox_GroupListVo> groupList = memberSQLMapper.getGroupList(member_no);
		
		ArrayList<Integer> friendList = new ArrayList<>();
		
		
		for(HE_NoteBox_GroupListVo groupVo: groupList) {
			
			HashMap<HE_NoteBox_GroupListVo, ArrayList<HE_MemberVo>> map = new HashMap<>();
			
			ArrayList<HE_MemberVo> memberList = new ArrayList<HE_MemberVo>();
			
			//String groupName = groupVo.getGroup_name(); //그룹명 = HashMap key로 세팅 
			
			int groupNo = groupVo.getGrouplist_no();
			friendList = memberSQLMapper.getFriend(groupNo); //같은 그룹에 속한 친구넘버 받기 
			
			for(int friendNo : friendList) {
				HE_MemberVo memberVo = memberSQLMapper.getMemberByNo(friendNo); //위에서 받은 친구넘버로(=멤버테이블의 멤버넘버) 멤버테이블 정보 받기 
				memberList.add(memberVo);
			}
			
			map.put(groupVo, memberList);
			topList.add(map);
		}
		
		
	
		return topList;
	}
	
	//======================= 그룹 추가
	public void addGroupProcess(int member_no, String group_name) {
		
		memberSQLMapper.addGroupProcess(member_no, group_name);
		
	}
	
	//======================= 그룹명 변경 
	public void updateGroupProcess(HE_NoteBox_GroupListVo groupVo) {
		String group_name = groupVo.getGroup_name();
		int grouplist_no = groupVo.getGrouplist_no();
		
		memberSQLMapper.updateGroupProcess(grouplist_no, group_name);
	}
	
	//=======================그룹 삭제 : select 삭제할 그룹에 속했던 친구들 -> update 해당 친구들 기본그룹으로 자동 이동시키기 -> delete 해당 그룹명 
	public void deleteGroupProcess(int member_no, int before_grouplist_no) {

		String group_name = "기본";
		
		//1.select 삭제할 그룹에 속했던 친구들
		ArrayList<HE_NoteBox_FriendListVo> list = memberSQLMapper.getFriendListByGroupNo(before_grouplist_no);
		
		if(list != null) {
			int grouplist_no = memberSQLMapper.getGroupListByGroupNoAndName(member_no, group_name);
			
			//2.update 해당 친구들 기본그룹으로 자동 이동시키기
			for(HE_NoteBox_FriendListVo friend : list) {
				int friend_no = friend.getFriend_no();
				memberSQLMapper.updateFriendGroupProcess(before_grouplist_no, grouplist_no, friend_no);
			}
		}
		
		//3.delete 해당 그룹명 
		memberSQLMapper.deleteGroupProcess(before_grouplist_no);
	}
	

	//======================= 친구 추가 
	public void addFriendProcess(int grouplist_no, String id) {
		
		HE_MemberVo resultMemberVo = memberSQLMapper.getMemberById(id);
		
		System.out.println(resultMemberVo.getMember_no());
		
		int friend_no = resultMemberVo.getMember_no();
		
		memberSQLMapper.addFriendProcess(grouplist_no, friend_no);
	}	
	
	//=======================친구 그룹 변경 
	public void updateFriendGroupProcess(int before_grouplist_no, int grouplist_no, int friend_no) {

		System.out.println("updateFriendGroupProcess0:"+before_grouplist_no+", "+grouplist_no+", "+friend_no);
		memberSQLMapper.updateFriendGroupProcess(before_grouplist_no, grouplist_no, friend_no);
		System.out.println("updateFriendGroupProcess1:"+before_grouplist_no+", "+grouplist_no+", "+friend_no);
	}
	
	//=======================친구 삭제
	public void deleteFriendProcess(HE_NoteBox_FriendListVo vo){
		memberSQLMapper.deleteFriendProcess(vo);
	}
	
	

	//=============================================================================================
	//=====================Toast
	public ArrayList<Object> getNewToast(int member_no) {
		//HE_NoteBoxVo
		return memberSQLMapper.getNewToast(member_no);
	}
	
	//=====================Toast_sender list 정보 HE_MemberVo 뽑기 
	public ArrayList<Object> getSenderList(ArrayList<Object> toastList) {
		
		ArrayList<Object> senderList = new ArrayList<Object>();//HE_MemberVo
		
		for(Object vo : toastList) {//HE_NoteBoxVo
			int senderNo = ((HE_NoteBoxVo) vo).getMember_no();//HE_NoteBoxVo
			Object senderVo = memberSQLMapper.getMemberByNo(senderNo); //HE_MemberVo
			senderList.add(senderVo);
		}
		
		return senderList;
	}
	//=====================admin Toast
	public HE_NoteBoxVo checkAdminToast(int member_no){
		return memberSQLMapper.checkAdminToast(member_no);
		
	}

	//=============================================================================================
	
	
	
	
	//=========================================================================================
	//========================================시터 요청 수락 시, 권한 변경 체크=======================
	//========================check mydog Authority(finddogboard + sitter)=====================
	//——————————————————————————-권한
	 public ArrayList<HE_FinddogBoardVo> getMyAuthority(int member_no){
		 
		 ArrayList<HE_FinddogBoardVo> myFinddogList = new ArrayList<HE_FinddogBoardVo>();
		 System.out.println("myFinddogList size:"+myFinddogList.size());
		 
		 
		 ArrayList<Integer> myFinddogNoList = new ArrayList<Integer>();
		 
		 
		 //finddogboard 내가 쓴 모든 글 
		 ArrayList<Integer> finddogList = memberSQLMapper.getMyFinddogBoard(member_no);
		 //sitterboard 내가 쓴 모든 글 
		 ArrayList<Integer> sitterBoardList = memberSQLMapper.getMySitterNofromSitterBoard(member_no);
		 
		 
		 
		 //1. finddogboard 내가 쓴 모든 글로 finddogboard_no 로 루프 
		 for(Integer finddogNo :  finddogList) {
			 //sitterboard_process 게시판에 올라온 글 있는 지 + 권한 Y 체크 
			 int count = memberSQLMapper.countYESFromSitterProcess(finddogNo);
			 
			 if(count == 0) {
				 System.out.println("카운트 ==0:주고받지않은 내권한 : 파인드글번호 : "+finddogNo);
				 //count == 0 이면 내 권한 
				 myFinddogNoList.add(finddogNo);
			 }
			 
			 //sitterboard_process 게시판으로부터 권한 Y 인 최근의 sitterboard_no 빼내기(권한이 오고갔던 흔적)
			 Integer sitterNo = memberSQLMapper.getRecentSitterNoFromSitterProcessByFinddogNo(finddogNo);
			 
			 try {
				 //sitterboard 내가 쓴 모든 글 루프 돌면서 위에서 빼낸 sitterboard_no 값과 같은지 비교 
				 for(Integer no : sitterBoardList) {
					 
					 //sitterboard_no가 같으면 내 권한 (오고 갔다가 다시 내게 온 경우)
					 if(no ==  sitterNo) {
						 System.out.println("no ==  sitterNo:주고받은 내권한 : 파인드글번호 : "+finddogNo + ",시터글번호 : "+sitterNo);
						 myFinddogNoList.add(finddogNo);
						 break;
					 }
				 }
				 
				 
			 }catch(Exception e){
				 System.out.println("트라이 에러");
				 System.out.println(e.getMessage());
			 }
			
		 }
		 
		 //2. sitter신청 수락해서 생긴 권한 
		 
		 //sitterBoardList 루프 돌기
		 for(Integer no : sitterBoardList) {
			 
			//sitterboard_process 에서 내 sitterboard_no & 권한 Y 인  finddogboard_no 뽑아내기 (권한이 최소 한번은 내게 왔던 값임)
			 ArrayList<Integer> testList = memberSQLMapper.getFinddogNoFromSitterProcessBySitterNo(no);
			 System.out.println("sitterboard_process 에서 내 sitterboard_no & 권한 Y 인  list:"+testList.size());
			 
			 //위 루프돌면서 
			 for(Integer testNo : testList) {
				 System.out.println("sitterboard_process 에서 내 sitterboard_no & 권한 Y 인  finddogboard_no:"+testNo);
				 //finddogbaord_no & 권한 Y인 가장 최근 sitterboard_no 뽑기 
				int recentNo = memberSQLMapper.getRecentSitterNoFromSitterProcessByFinddogNo(testNo);
				
				//내 시터보드리스트 루프돌면서 위와 같은 값 있는지 비교 
				for(Integer sitterNo : sitterBoardList) {
					
					//값 같으면 내 권한 
					if(sitterNo == recentNo) {
						System.out.println("sitterNo == recentNo:주고받은 내권한 : 파인드글번호 : "+testNo + ",시터글번호 : "+sitterNo);
						
						
						
						if(myFinddogNoList.size() != 0) {
							//내가 올린 시터 등록 글에 동일 finddogboard_no로 권한 오고간 경우가 모두 나올 경우,추가하지 말기 
							for(int i=0; i < myFinddogNoList.size();i++) {
								System.out.println("numbering:"+myFinddogNoList.size());
								if(testNo == myFinddogNoList.get(i)) {
									break;
								}else if(testNo != myFinddogNoList.get(i) && i == myFinddogNoList.size()-1) {
									System.out.println("no추가 :"+testNo+",size: "+myFinddogNoList.size());
									myFinddogNoList.add(testNo);
									
								}
							}
						
						}else {
							System.out.println("myFinddogNoList.size() == 0 : "+"no추가 :"+testNo+",size: "+myFinddogNoList.size());
							myFinddogNoList.add(testNo);
						}
						
				 
					}
			 
			 
				}
			 }
		 }
		 
		 //최종 finddogboard_no로 finddogboardVo 뽑기 
		 for(Integer no : myFinddogNoList) {
			 System.out.println("최종내권한:"+no);
			 
			 HE_FinddogBoardVo vo = finddogBoardSQLMapper.getContentByNo(no);
			 myFinddogList.add(vo);
		 }
		 
		 
		 
			
	return myFinddogList;
		

	}
	
	
	//============================ mypage - 나의 견추적
	
	public ArrayList<HashMap<HE_FinddogBoardVo, ArrayList<HashMap<String,Object>>>> getMyDogHistory(int member_no, int page_number){
			
		
		ArrayList<HashMap<HE_FinddogBoardVo, ArrayList<HashMap<String,Object>>>> topList = new  ArrayList<HashMap<HE_FinddogBoardVo, ArrayList<HashMap<String,Object>>>>();
		 
		//finddogBoard 버튼 권한
		ArrayList<HE_FinddogBoardVo> myFinddogList = getMyAuthority(member_no);
			
		//System.out.println("try"+"length:"+sitterList.size());
			
			
			for(HE_FinddogBoardVo finddogVo : myFinddogList) {
				
				HashMap<HE_FinddogBoardVo, ArrayList<HashMap<String,Object>>> topMap = new HashMap<HE_FinddogBoardVo, ArrayList<HashMap<String,Object>>>();
				
		
				int finddogNo = finddogVo.getFinddogboard_no();
				
				//견추적
				ArrayList<HashMap<String, Object>> history = finddogBoardServiceImpl.getFinddogHistory(finddogNo);
				
				/*ArrayList<HashMap<String, Object>>  topList
				map.put("sitterVo", vo);
				map.put("memberVo", memberVo);
			
				
				topList.add(map);*/
				
				topMap.put(finddogVo, history);
				topList.add(topMap);
					
				}
				
			
		
		
		
		
			return topList;

		
		
		/*
		
		//ArrayList<HashMap<Object, HashMap<String, Object>>>  topList = new  ArrayList<HashMap<Object, HashMap<String, Object>>>();
		
		
		ArrayList<HashMap<Object, ArrayList<HashMap<String,Object>>>> topList =new ArrayList<HashMap<Object, ArrayList<HashMap<String,Object>>>>();
		
			
		//내가 신청한 sitterboard_process 게시글 가져오기 
		ArrayList<HE_SitterBoard_ProcessVo> list = sitterBoard_ProcessSQLMapper.getMyDogHistory(member_no, page_number);
			
			
			
			for(HE_SitterBoard_ProcessVo vo : list) {
				
				//HashMap<Object, HashMap<String, Object>> topMap = new HashMap<Object, HashMap<String,Object>>();
				
				HashMap<Object, ArrayList<HashMap<String,Object>>> topMap = new HashMap<Object, ArrayList<HashMap<String,Object>>>();
				
				int finddogboard_no = vo.getFinddogboard_no();
				
				HE_FinddogBoardVo finddogVo = finddogBoardSQLMapper.getContentByNo(finddogboard_no);
				
				ArrayList<HE_SitterBoard_ProcessVo> sitterList = sitterBoard_ProcessSQLMapper.getFinddogHistory(finddogboard_no);
				
				ArrayList<HashMap<String,Object>> middleList =  new ArrayList<HashMap<String,Object>>();
				
				
				for(HE_SitterBoard_ProcessVo sitterProcessVo : sitterList) {
					
					HashMap<String, Object> map = new HashMap<String, Object>();
					
					int sitterboard_no = sitterProcessVo.getSitterboard_no();
					
					
					HE_SitterBoardVo sitterVo = sitterBoardSQLMapper.getContentByNo(sitterboard_no);
					int memberNo =sitterVo.getMember_no();
					HE_MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
				
					
					//int memberNo = sitterVo.getMember_no();
					//HE_MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
					
					
					map.put("sitterVo", sitterProcessVo);
					map.put("memberVo", memberVo);
					
				
					middleList.add(map);
					
				}
				
				topMap.put(finddogVo, middleList);
				topList.add(topMap);
			}
				
			
			
			return  topList;*/
		
		
		
		
		}
	

	public int getMyDogHistoryCount(int member_no, int page_number){
		int count = sitterBoard_ProcessSQLMapper.getMyDogHistoryCount(member_no, page_number);
		return count;
	}
	
}
