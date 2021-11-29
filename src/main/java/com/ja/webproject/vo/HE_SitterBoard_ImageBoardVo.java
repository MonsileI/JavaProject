package com.ja.webproject.vo;

public class HE_SitterBoard_ImageBoardVo {
	
    private int imageboard_no;
    private int sitterboard_no;
    private String imageboard_url;
    private String imageboard_ori;
    
    
    public HE_SitterBoard_ImageBoardVo() {
	}


	public HE_SitterBoard_ImageBoardVo(int imageboard_no, int sitterboard_no, String imageboard_url, String imageboard_ori) {
		this.imageboard_no = imageboard_no;
		this.sitterboard_no = sitterboard_no;
		this.imageboard_url = imageboard_url;
		this.imageboard_ori = imageboard_ori;
	}


	public int getImageboard_no() {
		return imageboard_no;
	}


	public void setImageboard_no(int imageboard_no) {
		this.imageboard_no = imageboard_no;
	}


	public int getSitterboard_no() {
		return sitterboard_no;
	}


	public void setSitterboard_no(int sitterboard_no) {
		this.sitterboard_no = sitterboard_no;
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
