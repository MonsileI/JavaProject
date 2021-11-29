package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_NoteBoxVo {

    private int notebox_no;
    private int member_no;
    private int friend_no;
    private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date writeDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date readDate;
    
    public HE_NoteBoxVo() {
	}

	public HE_NoteBoxVo(int notebox_no, int member_no, int friend_no, String content, Date writeDate,
			Date readDate) {
		super();
		this.notebox_no = notebox_no;
		this.member_no = member_no;
		this.friend_no = friend_no;
		this.content = content;
		this.writeDate = writeDate;
		this.readDate = readDate;
	}

	public int getNotebox_no() {
		return notebox_no;
	}

	public void setNotebox_no(int notebox_no) {
		this.notebox_no = notebox_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getFriend_no() {
		return friend_no;
	}

	public void setFriend_no(int friend_no) {
		this.friend_no = friend_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}
    
	
}
