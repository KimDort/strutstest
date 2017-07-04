package com.icanman.projectjoin.action;

import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.service.EmployeeService;
import com.icanman.project.model.Project;
import com.icanman.project.service.ProjectService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectJoinCreateFromAction implements Action{
	private int page;
	private int perPageNum;
	private String location;
	private SearchCriteria cri;
	private List<Employee> employee;
	private List<Career> career;
	private List<Project> project;
	private int projectNum;
	
	@Override
	public String execute() throws Exception {
		EmployeeService employeeService = new EmployeeService();
		ProjectService projectService = new ProjectService();
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		cri.setLocation(location);
		employee=employeeService.list();
		career = employeeService.careerList();
		project = projectService.list();
		return "success";
	}
	
	public int getProjectNum() {
		return projectNum;
	}

	public void setProjectNum(int projectNum) {
		this.projectNum = projectNum;
	}

	public List<Project> getProject() {
		return project;
	}

	public void setProject(List<Project> project) {
		this.project = project;
	}

	public List<Career> getCareer() {
		return career;
	}

	public void setCareer(List<Career> career) {
		this.career = career;
	}

	public List<Employee> getEmployee() {
		return employee;
	}

	public void setEmployee(List<Employee> employee) {
		this.employee = employee;
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
