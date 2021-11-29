package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class BuyVo {	
	private int buy_no;
	private int product_no;
	private int member_no; 
	private int buy_amount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date buy_date;

	public BuyVo() {
		// TODO Auto-generated constructor stub
	}

	public BuyVo(int buy_no, int product_no, int member_no, int buy_amount, Date buy_date) {
		super();
		this.buy_no = buy_no;
		this.product_no = product_no;
		this.member_no = member_no;
		this.buy_amount = buy_amount;
		this.buy_date = buy_date;
	}

	public int getBuy_no() {
		return buy_no;
	}

	public void setBuy_no(int buy_no) {
		this.buy_no = buy_no;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getBuy_amount() {
		return buy_amount;
	}

	public void setBuy_amount(int buy_amount) {
		this.buy_amount = buy_amount;
	}

	public Date getBuy_date() {
		return buy_date;
	}

	public void setBuy_date(Date buy_date) {
		this.buy_date = buy_date;
	}
	
	
	
}
