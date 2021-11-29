package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_ArticleBoardVo {
	
	private int articleboard_no;
	private int member_no;
	private String title;
	private String content;
	private int readcount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	
	public HE_ArticleBoardVo() {
		super();
	}

	public HE_ArticleBoardVo(int articleboard_no, int member_no, String title, String content, int readcount,
			Date writeDate) {
		super();
		this.articleboard_no = articleboard_no;
		this.member_no = member_no;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.writeDate = writeDate;
	}

	public int getArticleboard_no() {
		return articleboard_no;
	}

	public void setArticleboard_no(int articleboard_no) {
		this.articleboard_no = articleboard_no;
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
