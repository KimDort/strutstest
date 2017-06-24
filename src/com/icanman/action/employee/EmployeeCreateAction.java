package com.icanman.action.employee;

import com.icanman.model.Career;
import com.icanman.model.Employee;
import com.icanman.model.License;
import com.icanman.service.member.EmployeeService;
import com.opensymphony.xwork2.Action;

//Employee Base Info Register Class
public class EmployeeCreateAction implements Action{
	private EmployeeService employeeService;
	private Employee employee;
	private Career career;
	private License license;
	
	@Override
	public String execute() throws Exception {
		employeeService=new EmployeeService();
		if(employeeService.register(employee, career, license)==1){
			return "success";
		}else{
			return "error";
		}
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
	
}
