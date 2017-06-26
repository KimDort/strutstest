package com.icanman.model;

import java.sql.Date;

public class License {
	private int license_no;
	private int member_no;
	private String license_name;
	private String license_date;
	private String license_level;
	private String license_publisher;
	public int getLicense_no() {
		return license_no;
	}
	public void setLicense_no(int license_no) {
		this.license_no = license_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getLicense_name() {
		return license_name;
	}
	public void setLicense_name(String license_name) {
		this.license_name = license_name;
	}
	public String getLicense_date() {
		return license_date;
	}
	public void setLicense_date(String license_date) {
		this.license_date = license_date;
	}
	public String getLicense_level() {
		return license_level;
	}
	public void setLicense_level(String license_level) {
		this.license_level = license_level;
	}
	public String getLicense_publisher() {
		return license_publisher;
	}
	public void setLicense_publisher(String license_publisher) {
		this.license_publisher = license_publisher;
	}
	
}
