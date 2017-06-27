package com.icanman.employee.action;

import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.License;
import com.icanman.employee.model.Validate;
import com.icanman.employee.service.EmployeeService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;
//Employee Base Info Register Class
public class EmployeeCreateAction implements Action{
	private EmployeeService employeeService;
	private Employee employee;
	private Career career;
	private License license;
	private int page;
	private int perPageNum;
	private SearchCriteria cri;
	private List<Validate> val;
	
	@Override
	public String execute() throws Exception {
		cri=new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		employeeService=new EmployeeService();
		
		String result="";
		//유효성 검사 기준으로 등록
		val=employeeService.totalValidation(employee, career, license);
		
		if(val.get(0).isTrue()){
			employeeService.register(employee, career, license);
			result="success";
		}else{
			result="input";
		}
		
		return result;
	}
	
	public List<Validate> getVal() {
		return val;
	}

	public void setVal(List<Validate> val) {
		this.val = val;
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
}
