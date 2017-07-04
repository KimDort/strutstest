package com.icanman.project.action;

import com.icanman.project.model.Project;
import com.icanman.project.service.ProjectService;
import com.opensymphony.xwork2.Action;

public class ProjectSelecInfoAction implements Action{
	private int projectSelectNum;
	private Project projectSelectInfo;
	@Override
	public String execute() throws Exception {
		ProjectService projectService = new ProjectService();
		projectSelectInfo=projectService.read(projectSelectNum);
		return "success";
	}
	public Project getProjectSelectInfo() {
		return projectSelectInfo;
	}
	public void setProjectSelectInfo(Project projectSelectInfo) {
		this.projectSelectInfo = projectSelectInfo;
	}
	public int getProjectSelectNum() {
		return projectSelectNum;
	}
	public void setProjectSelectNum(int projectSelectNum) {
		this.projectSelectNum = projectSelectNum;
	}
	
}
