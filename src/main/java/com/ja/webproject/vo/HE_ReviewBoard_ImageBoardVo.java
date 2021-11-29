package com.ja.webproject.vo;

public class HE_ReviewBoard_ImageBoardVo {
	
    private int imageboard_no;
    private int reviewboard_no;
    private String imageboard_url;
    private String imageboard_ori;
	
    public HE_ReviewBoard_ImageBoardVo() {
		super();
	}

	public HE_ReviewBoard_ImageBoardVo(int imageboard_no, int reviewboard_no, String imageboard_url,
			String imageboard_ori) {
		super();
		this.imageboard_no = imageboard_no;
		this.reviewboard_no = reviewboard_no;
		this.imageboard_url = imageboard_url;
		this.imageboard_ori = imageboard_ori;
	}

	public int getImageboard_no() {
		return imageboard_no;
	}

	public void setImageboard_no(int imageboard_no) {
		this.imageboard_no = imageboard_no;
	}

	public int getReviewboard_no() {
		return reviewboard_no;
	}

	public void setReviewboard_no(int reviewboard_no) {
		this.reviewboard_no = reviewboard_no;
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
