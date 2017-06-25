package com.icanman.action.project;

import com.icanman.model.Project;
import com.icanman.service.project.ProjectService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectModifyFromAction implements Action {
	private Project project;
	private SearchCriteria cri;
	private int page;
	private int perPageNum;
	private int pno;

	@Override
	public String execute() throws Exception {
		ProjectService projectService = new ProjectService();
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		project=projectService.read(pno);
		return "success";
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
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

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}
	
}
