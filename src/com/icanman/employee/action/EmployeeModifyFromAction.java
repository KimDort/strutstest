package com.icanman.employee.action;

import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.License;
import com.icanman.employee.service.EmployeeService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class EmployeeModifyFromAction implements Action{
	private int no;
	private int page;
	private int perPageNum;
	private Employee employee;
	private List<Career> career;
	private List<License> license;
	private SearchCriteria cri;
	
	@Override
	public String execute() throws Exception {
		EmployeeService employeeService = new EmployeeService();
		employee = new Employee();
		career = new ArrayList<>();
		license = new ArrayList<>();
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		employee=employeeService.readEmployee(no);
		career=employeeService.readCareer(no);
		license=employeeService.readLicense(no);
		
		return "success";
	}
	
	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public List<Career> getCareer() {
		return career;
	}

	public void setCareer(List<Career> career) {
		this.career = career;
	}

	public List<License> getLicense() {
		return license;
	}

	public void setLicense(List<License> license) {
		this.license = license;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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
