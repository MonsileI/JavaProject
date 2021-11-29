package com.ja.webproject.vo;

public class HE_ArticleBoard_ImageBoardVo {
	
    private int imageboard_no;
    private int noticeboard_no;
    private String imageboard_url;
    private String imageboard_ori;
	
    public HE_ArticleBoard_ImageBoardVo() {
		super();
	}

	public HE_ArticleBoard_ImageBoardVo(int imageboard_no, int noticeboard_no, String imageboard_url,
			String imageboard_ori) {
		super();
		this.imageboard_no = imageboard_no;
		this.noticeboard_no = noticeboard_no;
		this.imageboard_url = imageboard_url;
		this.imageboard_ori = imageboard_ori;
	}

	public int getImageboard_no() {
		return imageboard_no;
	}

	public void setImageboard_no(int imageboard_no) {
		this.imageboard_no = imageboard_no;
	}

	public int getNoticeboard_no() {
		return noticeboard_no;
	}

	public void setNoticeboard_no(int noticeboard_no) {
		this.noticeboard_no = noticeboard_no;
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
