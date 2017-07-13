package com.icanman.projectjoin.action;

import java.util.List;

import com.icanman.employee.model.Employee;
import com.icanman.employee.service.EmployeeService;
import com.opensymphony.xwork2.Action;

public class AddMoreMemberAction implements Action{
	private List<Employee> employeeList;
	
	@Override
	public String execute() throws Exception {
		EmployeeService employeeService = new EmployeeService();
		employeeList = employeeService.addMoreEmployee();
		
		return "success";
	}

	public List<Employee> getEmployeeList() {
		return employeeList;
	}

	public void setEmployeeList(List<Employee> employeeList) {
		this.employeeList = employeeList;
	}
	
}
