package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_SitterBoardVo {
    private int sitterboard_no;
    private int member_no;
    private String title;
    private String content;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;
    private String possibleArea;
    private double latitude;
    private double longtitude;
    private String contact;
    private int readcount;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date writeDate;
    
    public HE_SitterBoardVo() {
		// TODO Auto-generated constructor stub
	}

	public HE_SitterBoardVo(int sitterboard_no, int member_no, String title, String content, Date endDate,
			String possibleArea, double latitude, double longtitude, String contact, int readcount, Date writeDate) {
		this.sitterboard_no = sitterboard_no;
		this.member_no = member_no;
		this.title = title;
		this.content = content;
		this.endDate = endDate;
		this.possibleArea = possibleArea;
		this.latitude = latitude;
		this.longtitude = longtitude;
		this.contact = contact;
		this.readcount = readcount;
		this.writeDate = writeDate;
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

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getPossibleArea() {
		return possibleArea;
	}

	public void setPossibleArea(String possibleArea) {
		this.possibleArea = possibleArea;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(double longtitude) {
		this.longtitude = longtitude;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
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
