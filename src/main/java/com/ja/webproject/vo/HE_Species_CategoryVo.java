package com.ja.webproject.vo;

public class HE_Species_CategoryVo {
	   private int species_no;
	   private String species;
	   
	   
	  public HE_Species_CategoryVo() {
		// TODO Auto-generated constructor stub
	}


	public HE_Species_CategoryVo(int species_no, String species) {
		super();
		this.species_no = species_no;
		this.species = species;
	}


	public int getSpecies_no() {
		return species_no;
	}


	public void setSpecies_no(int species_no) {
		this.species_no = species_no;
	}


	public String getSpecies() {
		return species;
	}


	public void setSpecies(String species) {
		this.species = species;
	}
	  
}
