package com.icanman.project.action;

import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectCreateFromAction implements Action{
	private SearchCriteria cri;
	private int page;
	private int perPageNum;
	@Override
	public String execute() throws Exception {
		cri=new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		return "success";
	}
	public SearchCriteria getCri() {
		return cri;
	}
	public void setCri(SearchCriteria cri) {
		this.cri = cri;
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
	
}
