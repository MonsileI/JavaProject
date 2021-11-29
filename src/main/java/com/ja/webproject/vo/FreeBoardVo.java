package com.ja.webproject.vo;

import java.util.Date;

public class FreeBoardVo {

	private int freeboard_no;
	private String nick;
	private String pw;
	private String title;
	private String content;
	private int readcount;
	//@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	private int recommend;
	
	public FreeBoardVo() {
		// TODO Auto-generated constructor stub
	}

	public FreeBoardVo(int freeboard_no, String nick, String pw, String title, String content, int readcount,
			Date writeDate, int recommend) {
		super();
		this.freeboard_no = freeboard_no;
		this.nick = nick;
		this.pw = pw;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.writeDate = writeDate;
		this.recommend = recommend;
	}

	public int getFreeboard_no() {
		return freeboard_no;
	}

	public void setFreeboard_no(int freeboard_no) {
		this.freeboard_no = freeboard_no;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
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

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	
	
	
	
}
