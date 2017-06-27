package com.icanman.projectjoin.action;

import java.util.List;

import com.icanman.projectjoin.model.ProjectJoin;
import com.icanman.projectjoin.service.ProjectJoinService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectJoinListAction implements Action{
	private List<ProjectJoin> list;
	private int page;
	private int perPageNum;
	private SearchCriteria cri;

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		ProjectJoinService projectjoinService = new ProjectJoinService();
		cri = new SearchCriteria();
		
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		list=projectjoinService.list(cri);
		
		return "success";
	}
	
	public List<ProjectJoin> getList() {
		return list;
	}

	public void setList(List<ProjectJoin> list) {
		this.list = list;
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
