package com.icanman.projectjoin.action;

import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.service.EmployeeService;
import com.icanman.project.model.Project;
import com.icanman.project.service.ProjectService;
import com.icanman.projectjoin.model.ProjectJoin;
import com.icanman.projectjoin.service.ProjectJoinService;
import com.opensymphony.xwork2.Action;

public class ProjectModifyAllFromAction implements Action{
	private int projectNumber;
	private List<ProjectJoin> projectJoinList;
	private List<Employee> employeeList;
	private List<Employee> addMoreEmployeeList;
	private List<Career> careerList;
	private Project project;
	@Override
	public String execute() throws Exception {
		ProjectJoinService projectJoinService = new ProjectJoinService();
		EmployeeService employeeService = new EmployeeService();
		ProjectService projectService = new ProjectService();
		
		addMoreEmployeeList=employeeService.addMoreEmployee();
		careerList = employeeService.readCareerProjectJoin(projectNumber);
		project = projectService.read(projectNumber);
		projectJoinList=projectJoinService.read(projectNumber);
		employeeList=employeeService.readProjectJoin(projectNumber);
		return "success";
	}
	
	public List<Employee> getAddMoreEmployeeList() {
		return addMoreEmployeeList;
	}

	public void setAddMoreEmployeeList(List<Employee> addMoreEmployeeList) {
		this.addMoreEmployeeList = addMoreEmployeeList;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public int getProjectNumber() {
		return projectNumber;
	}
	public void setProjectNumber(int projectNumber) {
		this.projectNumber = projectNumber;
	}
	public List<ProjectJoin> getProjectJoinList() {
		return projectJoinList;
	}
	public void setProjectJoinList(List<ProjectJoin> projectJoinList) {
		this.projectJoinList = projectJoinList;
	}
	public List<Employee> getEmployeeList() {
		return employeeList;
	}
	public void setEmployeeList(List<Employee> employeeList) {
		this.employeeList = employeeList;
	}
	public List<Career> getCareerList() {
		return careerList;
	}
	public void setCareerList(List<Career> careerList) {
		this.careerList = careerList;
	}
	
}
