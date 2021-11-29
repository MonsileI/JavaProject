package com.ja.webproject.vo;

public class HE_NoteBox_GroupListVo {

    private int grouplist_no;
    private int member_no;
    private String group_name;
    
    public HE_NoteBox_GroupListVo() {
	}

	public HE_NoteBox_GroupListVo(int grouplist_no, int member_no, String group_name) {
		this.grouplist_no = grouplist_no;
		this.member_no = member_no;
		this.group_name = group_name;
	}

	public int getGrouplist_no() {
		return grouplist_no;
	}

	public void setGrouplist_no(int grouplist_no) {
		this.grouplist_no = grouplist_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
    
}
