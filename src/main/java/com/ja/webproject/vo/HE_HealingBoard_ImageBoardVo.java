package com.ja.webproject.vo;

public class HE_HealingBoard_ImageBoardVo {
	
    private int imageboard_no;
    private int healingboard_no;
    private String imageboard_url;
    private String imageboard_ori;
	
    public HE_HealingBoard_ImageBoardVo() {
		super();
	}

	public HE_HealingBoard_ImageBoardVo(int imageboard_no, int healingboard_no, String imageboard_url,
			String imageboard_ori) {
		super();
		this.imageboard_no = imageboard_no;
		this.healingboard_no = healingboard_no;
		this.imageboard_url = imageboard_url;
		this.imageboard_ori = imageboard_ori;
	}

	public int getImageboard_no() {
		return imageboard_no;
	}

	public void setImageboard_no(int imageboard_no) {
		this.imageboard_no = imageboard_no;
	}

	public int getHealingboard_no() {
		return healingboard_no;
	}

	public void setHealingboard_no(int healingboard_no) {
		this.healingboard_no = healingboard_no;
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
