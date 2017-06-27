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
	private List<Project> list;
	
	@Override
	public String execute() throws Exception {
		ProjectService projectService = new ProjectService();
		cri=new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		
		list=new ArrayList<>();
		list=projectService.list(cri);
		return "success";
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
