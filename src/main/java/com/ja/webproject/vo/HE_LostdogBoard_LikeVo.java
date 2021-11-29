package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_LostdogBoard_LikeVo {
	
	  private int like_no;
	  private int lostdogboard_no;
	  private int member_no;
	  @DateTimeFormat(pattern = "yyyy-MM-dd")
	  private Date wridteDate;
	public HE_LostdogBoard_LikeVo() {
		super();
	}
	public HE_LostdogBoard_LikeVo(int like_no, int lostdogboard_no, int member_no, Date wridteDate) {
		super();
		this.like_no = like_no;
		this.lostdogboard_no = lostdogboard_no;
		this.member_no = member_no;
		this.wridteDate = wridteDate;
	}
	public int getLike_no() {
		return like_no;
	}
	public void setLike_no(int like_no) {
		this.like_no = like_no;
	}
	public int getLostdogboard_no() {
		return lostdogboard_no;
	}
	public void setLostdogboard_no(int lostdogboard_no) {
		this.lostdogboard_no = lostdogboard_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public Date getWridteDate() {
		return wridteDate;
	}
	public void setWridteDate(Date wridteDate) {
		this.wridteDate = wridteDate;
	}
	  
	  
	
	  
	
	
}
