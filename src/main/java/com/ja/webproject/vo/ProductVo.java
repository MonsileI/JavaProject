package com.ja.webproject.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ProductVo {

	private int product_no;
	private int store_no;
	private int category_no;
	private String product_content;
	private String product_name; 
	private int product_price;
	private int product_amount;
	private String product_image;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date register_date;
	
	public ProductVo() {
		// TODO Auto-generated constructor stub
	}

	public ProductVo(int product_no, int store_no, int category_no, String product_content, String product_name,
			int product_price, int product_amount, String product_image, Date register_date) {
		super();
		this.product_no = product_no;
		this.store_no = store_no;
		this.category_no = category_no;
		this.product_content = product_content;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_amount = product_amount;
		this.product_image = product_image;
		this.register_date = register_date;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public int getStore_no() {
		return store_no;
	}

	public void setStore_no(int store_no) {
		this.store_no = store_no;
	}

	public int getCategory_no() {
		return category_no;
	}

	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}

	public String getProduct_content() {
		return product_content;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public int getProduct_amount() {
		return product_amount;
	}

	public void setProduct_amount(int product_amount) {
		this.product_amount = product_amount;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public Date getRegister_date() {
		return register_date;
	}

	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}
	
	
	
}