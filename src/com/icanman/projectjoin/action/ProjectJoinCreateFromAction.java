package com.icanman.projectjoin.action;

import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectJoinCreateFromAction implements Action{
	private int page;
	private int perPageNum;
	private String location;
	private SearchCriteria cri;
	
	@Override
	public String execute() throws Exception {
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		cri.setLocation(location);
		
		return "success";
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}

	public SearchCriteria getCri() {
		return cri;
	}

	public void setCri(SearchCriteria cri) {
		this.cri = cri;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	
}
