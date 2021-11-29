package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_NoticeBoardVo {
	
	private int noticeboard_no;
	private int member_no;
	private String title;
	private String content;
	private int readcount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	
	public HE_NoticeBoardVo() {
		super();
	}

	public HE_NoticeBoardVo(int noticeboard_no, int member_no, String title, String content, int readcount,
			Date writeDate) {
		super();
		this.noticeboard_no = noticeboard_no;
		this.member_no = member_no;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.writeDate = writeDate;
	}

	public int getNoticeboard_no() {
		return noticeboard_no;
	}

	public void setNoticeboard_no(int noticeboard_no) {
		this.noticeboard_no = noticeboard_no;
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
