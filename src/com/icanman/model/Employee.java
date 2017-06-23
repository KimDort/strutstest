package com.icanman.model;

import java.sql.Date;

public class Employee {
	private int no;
	private String name;
	private String company;
	private String idnumber;
	private String zipcode;
	private String address;
	private String address_detail;
	private String rank;
	private Date join;
	private Date out;
	private String isnew;
	private String haveskill;
	private String position;
	private char isexit='N';
	private int projecthistory;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getIdnumber() {
		return idnumber;
	}
	public void setIdnumber(String idnumber) {
		this.idnumber = idnumber;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public Date getJoin() {
		return join;
	}
	public void setJoin(Date join) {
		this.join = join;
	}
	public Date getOut() {
		return out;
	}
	public void setOut(Date out) {
		this.out = out;
	}
	public String getIsnew() {
		return isnew;
	}
	public void setIsnew(String isnew) {
		this.isnew = isnew;
	}
	public String getHaveskill() {
		return haveskill;
	}
	public void setHaveskill(String haveskill) {
		this.haveskill = haveskill;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public char getIsexit() {
		return isexit;
	}
	public void setIsexit(char isexit) {
		this.isexit = isexit;
	}
	public int getProjecthistory() {
		return projecthistory;
	}
	public void setProjecthistory(int projecthistory) {
		this.projecthistory = projecthistory;
	}
	
}
