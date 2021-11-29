package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_SitterBoard_ProcessVo {
	
	private int sitterboard_process_no;
	private int sitterboard_no;
	private int finddogboard_no;
	private int member_no;
	private String message;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date acceptDate;
	private String status;
	private int readcount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	
	public HE_SitterBoard_ProcessVo() {
		// TODO Auto-generated constructor stub
	}

	public HE_SitterBoard_ProcessVo(int sitterboard_process_no, int sitterboard_no, int finddogboard_no, int member_no, String message,
			Date acceptDate, String status, int readcount, Date writeDate) {
		this.sitterboard_process_no = sitterboard_process_no;
		this.sitterboard_no = sitterboard_no;
		this.finddogboard_no = finddogboard_no;
		this.member_no = member_no;
		this.message = message;
		this.acceptDate = acceptDate;
		this.status = status;
		this.readcount = readcount;
		this.writeDate = writeDate;
	}

	public int getSitterboard_process_no() {
		return sitterboard_process_no;
	}

	public void setSitterboard_process_no(int sitterboard_process_no) {
		this.sitterboard_process_no = sitterboard_process_no;
	}

	public int getSitterboard_no() {
		return sitterboard_no;
	}

	public void setSitterboard_no(int sitterboard_no) {
		this.sitterboard_no = sitterboard_no;
	}

	public int getFinddogboard_no() {
		return finddogboard_no;
	}

	public void setFinddogboard_no(int finddogboard_no) {
		this.finddogboard_no = finddogboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getAcceptDate() {
		return acceptDate;
	}

	public void setAcceptDate(Date acceptDate) {
		this.acceptDate = acceptDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
