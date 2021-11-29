package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_SitterBoard_CommentVo {

    private int comment_no;
    private int sitterboard_no;
    private int member_no;
    private String comment_content;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date writeDate;
    
    
    public HE_SitterBoard_CommentVo() {
	}

	public HE_SitterBoard_CommentVo(int comment_no, int sitterboard_no, int member_no, String comment_content,
			Date writeDate) {
		this.comment_no = comment_no;
		this.sitterboard_no = sitterboard_no;
		this.member_no = member_no;
		this.comment_content = comment_content;
		this.writeDate = writeDate;
	}


	public int getComment_no() {
		return comment_no;
	}


	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}


	public int getSitterboard_no() {
		return sitterboard_no;
	}


	public void setSitterboard_no(int sitterboard_no) {
		this.sitterboard_no = sitterboard_no;
	}


	public int getMember_no() {
		return member_no;
	}


	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}


	public String getComment_content() {
		return comment_content;
	}


	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}


	public Date getWriteDate() {
		return writeDate;
	}


	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
    
	
    
}
