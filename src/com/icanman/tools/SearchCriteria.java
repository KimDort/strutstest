package com.icanman.tools;

public class SearchCriteria extends Criteria{
	private String location;
	private String isnew;
	private String name;
	private String haveskill;
	private String startDay;
	private String endDay;
	
	
	public String getStartDay() {
		return startDay;
	}

	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}

	public String getEndDay() {
		return endDay;
	}

	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}

	public String getHaveskill() {
		return haveskill;
	}

	public void setHaveskill(String haveskill) {
		this.haveskill = haveskill;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getIsnew() {
		return isnew;
	}

	public void setIsnew(String isnew) {
		this.isnew = isnew;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
