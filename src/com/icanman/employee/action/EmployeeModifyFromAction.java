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
	private List<Career> careerList;
	private List<License> licenseList;
	private SearchCriteria cri;
	
	@Override
	public String execute() throws Exception {
		EmployeeService employeeService = new EmployeeService();
		employee = new Employee();
		careerList = new ArrayList<>();
		licenseList = new ArrayList<>();
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		employee=employeeService.readEmployee(no);
		careerList=employeeService.readCareer(no);
		licenseList=employeeService.readLicense(no);
		
		return "success";
	}
	
	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	
	public List<Career> getCareerList() {
		return careerList;
	}

	public void setCareerList(List<Career> careerList) {
		this.careerList = careerList;
	}

	public List<License> getLicenseList() {
		return licenseList;
	}

	public void setLicenseList(List<License> licenseList) {
		this.licenseList = licenseList;
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
