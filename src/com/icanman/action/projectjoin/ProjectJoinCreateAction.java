package com.icanman.action.projectjoin;

import com.icanman.model.ProjectJoin;
import com.icanman.service.projectjoin.ProjectJoinService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

public class ProjectJoinCreateAction implements Action, Preparable, ModelDriven{
	private int page;
	private int perPageNum;
	private SearchCriteria cri;
	private ProjectJoin projectJoin;
	
	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return projectJoin;
	}

	@Override
	public void prepare() throws Exception {
		projectJoin=new ProjectJoin();
	}

	@Override
	public String execute() throws Exception {
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		ProjectJoinService projectJoinService = new ProjectJoinService();
		
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
	
}
