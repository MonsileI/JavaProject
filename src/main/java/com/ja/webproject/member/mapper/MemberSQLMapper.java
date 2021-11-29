package com.ja.webproject.member.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.webproject.vo.HE_FinddogBoardVo;
import com.ja.webproject.vo.HE_MemberVo;
import com.ja.webproject.vo.HE_NoteBoxVo;
import com.ja.webproject.vo.HE_NoteBox_FriendListVo;
import com.ja.webproject.vo.HE_NoteBox_GroupListVo;
import com.ja.webproject.vo.HE_SitterBoard_ProcessVo;

public interface MemberSQLMapper {
	
	//===================================회원 관련==============================================
	//===============회원가입 시, 중복 ID 검사 - Ajax
	public int checkId(String inputedId);
	
	//===============회원가입 시, 중복 Nick 검사 - Ajax
	public int checkNick(String inputedNick);
	
	//===============친구추가 시, ID 검사 - Ajax
	public HE_MemberVo getFriendById(String inputedId);

	
	//=============HE_Member : xml 위치변경 고려 
	
	public HE_MemberVo getMemberByNo(int no);
	
	public HE_MemberVo getMemberById(String id);
	
	//===================================쪽지함 관련==============================================
	//==============HE_NoteBox

	public int checkNewNote(int member_no);
	
	public HE_NoteBoxVo getContentByNo(int notebox_no);

	public ArrayList<HE_NoteBoxVo> getSentContent(
			@Param("member_no") int member_no,
			@Param("search_type_sent") String search_type_sent, 
			@Param("search_word_sent") String search_word_sent,
			@Param("page_num") int page_num);
	
	public ArrayList<HE_NoteBoxVo> getRecvContent(
			@Param("member_no") int member_no,
			@Param("search_type_recv") String search_type_recv, 
			@Param("search_word_recv") String search_word_recv,
			@Param("page_num_recv") int page_num_recv);
	
	public int getSentCount(
			@Param("member_no") int member_no,
			@Param("search_type_sent") String search_type_sent, 
			@Param("search_word_sent") String search_word_sent,
			@Param("page_num") int page_num);
	
	public int getRecvCount(
			@Param("member_no") int member_no,
			@Param("search_type_recv") String search_type_recv, 
			@Param("search_word_recv") String search_word_recv,
			@Param("page_num_recv") int page_num_recv);
	
	public void sendNote(HE_NoteBoxVo noteVo);
	
	public void confirmNote(int notebox_no);

	public void deleteCheckedNote(int no);
	

	//==============HE_NoteBox_GroupList
	
	public ArrayList<HE_NoteBox_GroupListVo> getGroupList(int member_no);
	
	public void addGroupProcess(
			@Param("no") int no, 
			@Param("group_name") String group_name);
	
	public int getGroupListByGroupNoAndName(
			@Param("member_no") int member_no, 
			@Param("group_name") String group_name);
	
	public void updateGroupNo(
			@Param("update_group_no") int update_group_no, 
			@Param("friend_no") int friend_no);

	public void updateGroupProcess(
			@Param("grouplist_no") int grouplist_no, 
			@Param("group_name") String group_name);
	
	public void deleteGroupProcess(int delete_group_no);

	
	//==============HE_NoteBox_FriendList
	
	public int checkMyFriend(
			@Param("grouplist_no") int grouplist_no, 
			@Param("member_no") int member_no);
	
	public ArrayList<Integer> getFriend(int groupNo);
	
	public ArrayList<HE_NoteBox_FriendListVo> getFriendListByGroupNo(int delete_group_no);
	
	public void addFriendProcess(
			@Param("grouplist_no") int grouplist_no, 
			@Param("friend_no") int friend_no);

	public void updateFriendGroupProcess(
			@Param("before_grouplist_no") int before_grouplist_no, 
			@Param("grouplist_no") int grouplist_no, 
			@Param("friend_no") int friend_no);
	
	public void deleteFriendProcess(HE_NoteBox_FriendListVo vo);
	
	
	//==============Toast
	public ArrayList<Object> getNewToast(int member_no);//HE_NoteBoxVo
	
	//==============admin Toast
	public HE_NoteBoxVo checkAdminToast(int member_no);

	//=========================================================================================
	//========================================시터 요청 수락 시, 권한 변경 체크=======================
	//========================check mydog Authority(finddogboard + sitter)=====================
	//——————————————————————————-권한
	 public ArrayList<Integer> getMyFinddogBoard(int member_no);
	 public int countYESFromSitterProcess(int finddogboard_no);
	 
	 public ArrayList<Integer> getMySitterNofromSitterBoard(int member_no);
	 public Integer getRecentSitterNoFromSitterProcessByFinddogNo(int finddogboard_no);
	 
	 public ArrayList<Integer> getFinddogNoFromSitterProcessBySitterNo(int sitterboard_no);
	//=========================================================================================
	//=========================LostdogBoard & FinddogBoard matching system
	public void sendMatchingNote(
			@Param("admin_no") int admin_no, 
			@Param("member_no") int member_no, 
			@Param("message") String message);
}
