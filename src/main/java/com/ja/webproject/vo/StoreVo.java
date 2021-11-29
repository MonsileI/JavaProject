package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StoreVo {

	private int store_no;
	private int member_no;
	private String store_name;
	private String store_content;
	private String logo_link;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date open_date;


	public StoreVo() {
		// TODO Auto-generated constructor stub
	}


	public StoreVo(int store_no, int member_no, String store_name, String store_content, String logo_link,
			Date open_date) {
		super();
		this.store_no = store_no;
		this.member_no = member_no;
		this.store_name = store_name;
		this.store_content = store_content;
		this.logo_link = logo_link;
		this.open_date = open_date;
	}


	public int getStore_no() {
		return store_no;
	}


	public void setStore_no(int store_no) {
		this.store_no = store_no;
	}


	public int getMember_no() {
		return member_no;
	}


	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}


	public String getStore_name() {
		return store_name;
	}


	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}


	public String getStore_content() {
		return store_content;
	}


	public void setStore_content(String store_content) {
		this.store_content = store_content;
	}


	public String getLogo_link() {
		return logo_link;
	}


	public void setLogo_link(String logo_link) {
		this.logo_link = logo_link;
	}


	public Date getOpen_date() {
		return open_date;
	}


	public void setOpen_date(Date open_date) {
		this.open_date = open_date;
	}
	
	
	
}
