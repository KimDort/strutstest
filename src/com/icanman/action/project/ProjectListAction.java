package com.icanman.action.project;

import java.util.ArrayList;
import java.util.List;

import com.icanman.model.Project;
import com.icanman.service.project.ProjectService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

public class ProjectListAction implements Action, Preparable, ModelDriven{
	private SearchCriteria cri;
	private List<Project> list;

	@Override
	public void prepare() throws Exception {
		cri=new SearchCriteria();
	}

	@Override
	public String execute() throws Exception {
		ProjectService projectService = new ProjectService();
		list=new ArrayList<>();
		list=projectService.list(cri);
		return "success";
	}

	@Override
	public Object getModel() {
		return cri;
	}

	public List<Project> getList() {
		return list;
	}

	public void setList(List<Project> list) {
		this.list = list;
	}
	
}
