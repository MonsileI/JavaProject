package com.ja.webproject.vo;

public class HE_NoteBox_FriendListVo {

    private int friendlist_no;
    private int grouplist_no;
    private int friend_no;
    
    public HE_NoteBox_FriendListVo() {
	
	}

	public HE_NoteBox_FriendListVo(int friendlist_no, int grouplist_no, int friend_no) {
		this.friendlist_no = friendlist_no;
		this.grouplist_no = grouplist_no;
		this.friend_no = friend_no;
	}

	public int getFriendlist_no() {
		return friendlist_no;
	}

	public void setFriendlist_no(int friendlist_no) {
		this.friendlist_no = friendlist_no;
	}

	public int getGrouplist_no() {
		return grouplist_no;
	}

	public void setGrouplist_no(int grouplist_no) {
		this.grouplist_no = grouplist_no;
	}

	public int getFriend_no() {
		return friend_no;
	}

	public void setFriend_no(int friend_no) {
		this.friend_no = friend_no;
	}
    
    
}
