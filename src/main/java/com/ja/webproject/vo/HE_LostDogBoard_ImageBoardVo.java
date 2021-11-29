package com.ja.webproject.vo;

public class HE_LostDogBoard_ImageBoardVo {
	
	private int imageboard_no;
    private int lostdogboard_no;
    private String imageboard_url;
    private String imageboard_ori;
	public HE_LostDogBoard_ImageBoardVo() {
		super();
	}
	public HE_LostDogBoard_ImageBoardVo(int imageboard_no, int lostdogboard_no, String imageboard_url, String imageboard_ori) {
		super();
		this.imageboard_no = imageboard_no;
		this.lostdogboard_no = lostdogboard_no;
		this.imageboard_url = imageboard_url;
		this.imageboard_ori = imageboard_ori;
	}
	public int getImageboard_no() {
		return imageboard_no;
	}
	public void setImageboard_no(int imageboard_no) {
		this.imageboard_no = imageboard_no;
	}
	public int getLostdogboard_no() {
		return lostdogboard_no;
	}
	public void setLostdogboard_no(int lostdogboard_no) {
		this.lostdogboard_no = lostdogboard_no;
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
