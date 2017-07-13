package com.icanman.action;

import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.service.EmployeeService;
import com.icanman.project.model.Project;
import com.icanman.project.service.ProjectService;
import com.icanman.projectjoin.model.ProjectJoin;
import com.icanman.projectjoin.service.ProjectJoinService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class MainListAction implements Action{
	private List<Employee> employeeList;
	private List<Project> projectList;
	private List<ProjectJoin> projectJoinList;
	private List<Career> career;
	
	@Override
	public String execute() throws Exception {
		SearchCriteria cri = new SearchCriteria();
		EmployeeService employeeService = new EmployeeService();
		ProjectService projectService = new ProjectService();
		ProjectJoinService joinService = new ProjectJoinService();
		cri.setPage(1);
		cri.setPerPageNum(5);
		
		employeeList = employeeService.list(cri);
		projectList = projectService.list(cri);
		projectJoinList = joinService.list(cri);
		career = employeeService.careerList();
		return "success";
	}

	public List<Employee> getEmployeeList() {
		return employeeList;
	}

	public void setEmployeeList(List<Employee> employeeList) {
		this.employeeList = employeeList;
	}

	public List<Project> getProjectList() {
		return projectList;
	}

	public void setProjectList(List<Project> projectList) {
		this.projectList = projectList;
	}

	public List<ProjectJoin> getProjectJoinList() {
		return projectJoinList;
	}

	public void setProjectJoinList(List<ProjectJoin> projectJoinList) {
		this.projectJoinList = projectJoinList;
	}

	public List<Career> getCareer() {
		return career;
	}

	public void setCareer(List<Career> career) {
		this.career = career;
	}
	
}
