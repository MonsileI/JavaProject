package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_FinddogBoard_LikeVo {
	   private int like_no;
	   private int member_no ;
	   private int finddogboard_no;
		@DateTimeFormat(pattern = "yyyy-MM-dd")
	   private Date  writeDate;
	   
	   public HE_FinddogBoard_LikeVo() {
		// TODO Auto-generated constructor stub
	}

	public HE_FinddogBoard_LikeVo(int like_no, int member_no, int finddogboard_no, Date writeDate) {
		super();
		this.like_no = like_no;
		this.member_no = member_no;
		this.finddogboard_no = finddogboard_no;
		this.writeDate = writeDate;
	}

	public int getLike_no() {
		return like_no;
	}

	public void setLike_no(int like_no) {
		this.like_no = like_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getFinddogboard_no() {
		return finddogboard_no;
	}

	public void setFinddogboard_no(int finddogboard_no) {
		this.finddogboard_no = finddogboard_no;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	   
	   
}
