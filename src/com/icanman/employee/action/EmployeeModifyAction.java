package com.icanman.employee.action;

import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.License;
import com.icanman.employee.model.Validate;
import com.icanman.employee.service.EmployeeService;
import com.icanman.employee.service.EmployeeValidateService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class EmployeeModifyAction implements Action{
	private int no;
	private EmployeeService employeeService;
	private Employee employee;
	private Career career;
	private License license;
	private int page;
	private int perPageNum;
	private SearchCriteria cri;
	private Validate val;
	
	@Override
	public String execute() throws Exception {
		EmployeeValidateService vali = new EmployeeValidateService();
		List<Career> careerList = new ArrayList<>();
		List<License> licenseList = new ArrayList<>();
		EmployeeService employeeService = new EmployeeService();
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);

		if(career!=null){
			careerList=employeeService.createList(career);
		}
		
		if(license!=null){
			licenseList=employeeService.createList(license);
		}
		
		val=vali.totalValidateMethod(employee, career, license);
		if(val.getTrue()){
			
			return "success";
		}else{
			return "input";
		}
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public EmployeeService getEmployeeService() {
		return employeeService;
	}

	public void setEmployeeService(EmployeeService employeeService) {
		this.employeeService = employeeService;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Career getCareer() {
		return career;
	}

	public void setCareer(Career career) {
		this.career = career;
	}

	public License getLicense() {
		return license;
	}

	public void setLicense(License license) {
		this.license = license;
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

	public Validate getVal() {
		return val;
	}

	public void setVal(Validate val) {
		this.val = val;
	}
	
}
