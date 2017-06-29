package com.icanman.employee.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Career {
	private int period_no;
	private int member_no;
	private String period_start;
	private String period_end;
	private String period_company;
	private String period_rank;
	private String period_position;
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
		int strDate=0;
		String str="";
		String start=this.period_start;
		String end=this.period_end;
		Calendar startCal= Calendar.getInstance();
		Calendar endCal= Calendar.getInstance();
		
		int startYear=Integer.parseInt(start.substring(0, 4));
		int endYear=Integer.parseInt(end.substring(0, 4));
		int startMonth=Integer.parseInt(start.substring(5, 7));
		int endMonth=Integer.parseInt(end.substring(5, 7));
		
		strDate=((endYear-startYear)*12)+(endMonth-startMonth);
		str=strDate/12>0?String.valueOf(strDate/12)+"년":"";
		str+=(endMonth-startMonth)>0?String.valueOf((endMonth-startMonth))+"개월":"";
		System.out.println(startCal.getTimeInMillis() /(24 * 60 * 60 * 1000));
		
		try {
			SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = formater.parse(start);
			Date endDate = formater.parse(end);
			startCal.setTime(startDate);
			endCal.setTime(endDate);
			
		/*	int startYear=startCal.get(Calendar.YEAR);
			int startMonth=startCal.get(Calendar.MONTH)+1;
			int startDay=startCal.get(Calendar.DATE);
			int endYear=endCal.get(Calendar.YEAR);
			int endMonth=endCal.get(Calendar.MONTH)+1;
			int endDay=endCal.get(Calendar.DATE);
			
			int endIdx=endCal.get(Calendar.MONTH);
			if(endYear-startYear > 0){
				
			}
			for(int idx=startCal.get(Calendar.MONTH);idx<=endIdx;idx++){
				
			}
			
			strDate=year>0?String.valueOf(year)+"년":"";
			strDate+=month>0?String.valueOf(month)+"개월":"";*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
}
