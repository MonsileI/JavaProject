package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HE_LostDogBoardVo {
	
	  private int lostdogboard_no;
	  private int member_no;
	  private int species_no;
	  private String title;
	  private String content;
	  private String lostPlace;
	  private double latitude;
	  private double longtitude;
	  @DateTimeFormat(pattern = "yyyy-MM-dd")
	  private Date lostDate;
	  private String petName;
	  private String petGender;
	  private int petAge;
	  private String contact;
	  private String status;
	  private int readcount;
	  @DateTimeFormat(pattern = "yyyy-MM-dd")
	  private Date writeDate;
	public HE_LostDogBoardVo() {
		super();
	}
	public HE_LostDogBoardVo(int lostdogboard_no, int member_no, int species_no, String title, String content,
			String lostPlace, double latitude, double longtitude, Date lostDate, String petName, String petGender,
			int petAge, String contact, String status, int readcount, Date writeDate) {
		super();
		this.lostdogboard_no = lostdogboard_no;
		this.member_no = member_no;
		this.species_no = species_no;
		this.title = title;
		this.content = content;
		this.lostPlace = lostPlace;
		this.latitude = latitude;
		this.longtitude = longtitude;
		this.lostDate = lostDate;
		this.petName = petName;
		this.petGender = petGender;
		this.petAge = petAge;
		this.contact = contact;
		this.status = status;
		this.readcount = readcount;
		this.writeDate = writeDate;
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
	public int getSpecies_no() {
		return species_no;
	}
	public void setSpecies_no(int species_no) {
		this.species_no = species_no;
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
	public String getLostPlace() {
		return lostPlace;
	}
	public void setLostPlace(String lostPlace) {
		this.lostPlace = lostPlace;
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
	public Date getLostDate() {
		return lostDate;
	}
	public void setLostDate(Date lostDate) {
		this.lostDate = lostDate;
	}
	public String getPetName() {
		return petName;
	}
	public void setPetName(String petName) {
		this.petName = petName;
	}
	public String getPetGender() {
		return petGender;
	}
	public void setPetGender(String petGender) {
		this.petGender = petGender;
	}
	public int getPetAge() {
		return petAge;
	}
	public void setPetAge(int petAge) {
		this.petAge = petAge;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
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
