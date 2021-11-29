package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_HealingBoardVo {
	
	private int healingboard_no;
	private int member_no;
	private String title;
	private String content;
	private int readcount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	
	public HE_HealingBoardVo() {
		super();
	}

	public HE_HealingBoardVo(int healingboard_no, int member_no, String title, String content, int readcount,
			Date writeDate) {
		super();
		this.healingboard_no = healingboard_no;
		this.member_no = member_no;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.writeDate = writeDate;
	}

	public int getHealingboard_no() {
		return healingboard_no;
	}

	public void setHealingboard_no(int healingboard_no) {
		this.healingboard_no = healingboard_no;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}


	
	
	
}
