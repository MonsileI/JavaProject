package com.ja.webproject.vo;

public class HE_FinddogBoard_ImageBoardVo {

	   private int imageboard_no;
	   private int finddogboard_no;
	   private String imageboard_url;
	   private String imageboard_ori;
	   
	   public HE_FinddogBoard_ImageBoardVo() {
		// TODO Auto-generated constructor stub
	}

	public HE_FinddogBoard_ImageBoardVo(int imageboard_no, int finddogboard_no, String imageboard_url,
			String imageboard_ori) {
		super();
		this.imageboard_no = imageboard_no;
		this.finddogboard_no = finddogboard_no;
		this.imageboard_url = imageboard_url;
		this.imageboard_ori = imageboard_ori;
	}

	public int getImageboard_no() {
		return imageboard_no;
	}

	public void setImageboard_no(int imageboard_no) {
		this.imageboard_no = imageboard_no;
	}

	public int getFinddogboard_no() {
		return finddogboard_no;
	}

	public void setFinddogboard_no(int finddogboard_no) {
		this.finddogboard_no = finddogboard_no;
	}

	public String getImageboard_url() {
		return imageboard_url;
	}

	public void setImageboard_url(String imageboard_url) {
		this.imageboard_url = imageboard_url;
	}

	public String getImageboard_ori() {
		return imageboard_ori;
	}

	public void setImageboard_ori(String imageboard_ori) {
		this.imageboard_ori = imageboard_ori;
	}
	   
	
}
