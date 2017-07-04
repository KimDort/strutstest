package com.icanman.employee.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Career {
	private int period_no;
	private int member_no;
	private String period_start;
	private String period_end;
	private String period_company;
	private String period_rank;
	private String period_position;
	private int totalCareer;
	
	public int getTotalCareer() {
		return totalCareer;
	}
	public void setTotalCareer(int totalCareer) {
		this.totalCareer = totalCareer;
	}
	public int getPeriod_no() {
		return period_no;
	}
	public void setPeriod_no(int period_no) {
		this.period_no = period_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getPeriod_start() {
		return period_start;
	}
	public void setPeriod_start(String period_start) {
		this.period_start = period_start;
	}
	public String getPeriod_end() {
		return period_end;
	}
	public void setPeriod_end(String period_end) {
		this.period_end = period_end;
	}
	public String getPeriod_company() {
		return period_company;
	}
	public void setPeriod_company(String period_company) {
		this.period_company = period_company;
	}
	public String getPeriod_rank() {
		return period_rank;
	}
	public void setPeriod_rank(String period_rank) {
		this.period_rank = period_rank;
	}
	public String getPeriod_position() {
		return period_position;
	}
	public void setPeriod_position(String period_position) {
		this.period_position = period_position;
	}
	
	public String getDateDifference(){
		String str="";
		String start=this.period_start;
		String end=this.period_end;
		long year=0;
		long month=0;
		
		try {
			SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = formater.parse(start);
			Date endDate = formater.parse(end);
		
			long startYear=startDate.getTime()/(24 * 60 * 60 * 1000);
			long endYear = endDate.getTime()/(24 * 60 * 60 * 1000);
			
			month=(endYear-startYear)/30;
			
			if(month>12){
				year+=month/12;
				month=month%12;
			}
			
			str=year>0?String.valueOf(year)+"년":"";
			str+=month>0?String.valueOf(month)+"개월":"";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
}
