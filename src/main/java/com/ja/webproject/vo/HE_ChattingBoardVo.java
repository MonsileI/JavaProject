package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_ChattingBoardVo {
	
	private int chattingboard_no;
	private int member_no;
	private String title;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writedate;
	public HE_ChattingBoardVo() {
		super();
	}
	public HE_ChattingBoardVo(int chattingboard_no, int member_no, String title, Date writedate) {
		super();
		this.chattingboard_no = chattingboard_no;
		this.member_no = member_no;
		this.title = title;
		this.writedate = writedate;
	}
	public int getChattingboard_no() {
		return chattingboard_no;
	}
	public void setChattingboard_no(int chattingboard_no) {
		this.chattingboard_no = chattingboard_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	
	
	
	
}
