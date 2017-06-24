package com.icanman.action.project;

import com.icanman.model.Project;
import com.icanman.service.project.ProjectService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

public class ProjectCreateAction implements Action, Preparable, ModelDriven<Project>{
	private SearchCriteria cri;
	private int page;
	private int perPageNum;
	private Project project;
	
	@Override
	public String execute() throws Exception {
		cri=new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		ProjectService projectService= new ProjectService();
		projectService.register(project);
		return "success";
	}

	@Override
	public Project getModel() {
		return project;
	}

	@Override
	public void prepare() throws Exception {	
		project=new Project();
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
