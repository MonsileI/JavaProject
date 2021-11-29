package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_ChattingRoomBoardVo {
	
	private int chattingroomboard_no;
	private int chattingboard_no;
	private int member_no;
	private String chatting_content;
	private String chatting_status;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writedate;
	
	public HE_ChattingRoomBoardVo() {
		super();
	}

	public HE_ChattingRoomBoardVo(int chattingroomboard_no, int chattingboard_no, int member_no,
			String chatting_content, String chatting_status, Date writedate) {
		super();
		this.chattingroomboard_no = chattingroomboard_no;
		this.chattingboard_no = chattingboard_no;
		this.member_no = member_no;
		this.chatting_content = chatting_content;
		this.chatting_status = chatting_status;
		this.writedate = writedate;
	}

	public int getChattingroomboard_no() {
		return chattingroomboard_no;
	}

	public void setChattingroomboard_no(int chattingroomboard_no) {
		this.chattingroomboard_no = chattingroomboard_no;
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

	public String getChatting_content() {
		return chatting_content;
	}

	public void setChatting_content(String chatting_content) {
		this.chatting_content = chatting_content;
	}

	public String getChatting_status() {
		return chatting_status;
	}

	public void setChatting_status(String chatting_status) {
		this.chatting_status = chatting_status;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	

	
}
