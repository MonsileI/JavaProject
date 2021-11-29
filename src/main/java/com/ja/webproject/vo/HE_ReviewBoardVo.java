package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_ReviewBoardVo {
	
	private int reviewboard_no;
	private int member_no;
	private String title;
	private String content;
	private int readcount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	
	public HE_ReviewBoardVo() {
		super();
	}

	public HE_ReviewBoardVo(int reviewboard_no, int member_no, String title, String content, int readcount,
			Date writeDate) {
		super();
		this.reviewboard_no = reviewboard_no;
		this.member_no = member_no;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.writeDate = writeDate;
	}

	public int getReviewboard_no() {
		return reviewboard_no;
	}

	public void setReviewboard_no(int reviewboard_no) {
		this.reviewboard_no = reviewboard_no;
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
