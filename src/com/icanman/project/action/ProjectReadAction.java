package com.icanman.project.action;

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

public class ProjectReadAction implements Action{
	private Project project;
	private SearchCriteria cri;
	private int page;
	private int perPageNum;
	private String location;
	private int pno;
	private List<ProjectJoin> joinList;
	private List<Employee> employeeList;
	private List<Career> career;
	
	@Override
	public String execute() throws Exception {
		ProjectService projectService = new ProjectService();
		ProjectJoinService projectJoinService = new ProjectJoinService();
		EmployeeService employeeService = new EmployeeService();
		
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		cri.setLocation(location);
		project=projectService.read(pno);
		joinList=projectJoinService.read(pno);
		career= employeeService.readCareerProjectJoin(pno);
		employeeList=employeeService.readProjectJoin(pno);
		return "success";
	}
	
	public List<Employee> getEmployeeList() {
		return employeeList;
	}

	public void setEmployeeList(List<Employee> employeeList) {
		this.employeeList = employeeList;
	}

	public List<Career> getCareer() {
		return career;
	}

	public void setCareer(List<Career> career) {
		this.career = career;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public List<ProjectJoin> getJoinList() {
		return joinList;
	}

	public void setJoinList(List<ProjectJoin> joinList) {
		this.joinList = joinList;
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

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}
	
}
