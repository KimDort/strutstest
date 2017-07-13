package com.icanman.project.action;

import java.util.ArrayList;
import java.util.List;

import com.icanman.project.model.Project;
import com.icanman.project.service.ProjectService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectListAction implements Action{
	private SearchCriteria cri;
	private int page;
	private int perPageNum;
	private String location;
	private List<Project> list;
	private String startDay;
	private String endDay;
	
	@Override
	public String execute() throws Exception {
		ProjectService projectService = new ProjectService();
		cri=new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		cri.setLocation(location);
		cri.setStartDay(startDay);
		cri.setEndDay(endDay);
		
		list=new ArrayList<>();
		list=projectService.list(cri);
		return "success";
	}
	
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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public List<Project> getList() {
		return list;
	}

	public void setList(List<Project> list) {
		this.list = list;
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
