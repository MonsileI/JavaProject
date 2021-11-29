package com.ja.webproject.vo;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_MailAuthVo {

	private int mailauth_no;
	private int member_no;
	private String mail_key;
	private String mail_complete;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	
	public HE_MailAuthVo() {
	}

	public HE_MailAuthVo(int mailauth_no, int member_no, String mail_key, String mail_complete, Date writeDate) {
		this.mailauth_no = mailauth_no;
		this.member_no = member_no;
		this.mail_key = mail_key;
		this.mail_complete = mail_complete;
		this.writeDate = writeDate;
	}

	public int getMailauth_no() {
		return mailauth_no;
	}

	public void setMailauth_no(int mailauth_no) {
		this.mailauth_no = mailauth_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getMail_key() {
		return mail_key;
	}

	public void setMail_key(String mail_key) {
		this.mail_key = mail_key;
	}

	public String getMail_complete() {
		return mail_complete;
	}

	public void setMail_complete(String mail_complete) {
		this.mail_complete = mail_complete;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	
	
}