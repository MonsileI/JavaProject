package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_OwnerBoardVo {
	
    private int ownerboard_no;
    private int member_no;
    private int finddogboard_no;
    private String status;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date writeDate;

	public HE_OwnerBoardVo() {

	}
	
	public HE_OwnerBoardVo(int ownerboard_no, int member_no, int finddogboard_no, String status, Date writeDate) {
		this.ownerboard_no = ownerboard_no;
		this.member_no = member_no;
		this.finddogboard_no = finddogboard_no;
		this.status = status;
		this.writeDate = writeDate;
	}
	public int getOwnerboard_no() {
		return ownerboard_no;
	}
	public void setOwnerboard_no(int ownerboard_no) {
		this.ownerboard_no = ownerboard_no;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
    
    

}
