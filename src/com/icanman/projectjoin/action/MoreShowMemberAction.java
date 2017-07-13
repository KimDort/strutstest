package com.icanman.projectjoin.action;

import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.service.EmployeeService;
import com.opensymphony.xwork2.Action;

public class MoreShowMemberAction implements Action{
	private int startNum;
	private int endNum;
	private List<Employee> employeeList;
	private List<Career> careerList;
	@Override
	public String execute() throws Exception {
		EmployeeService employeeService = new EmployeeService();
		employeeList=employeeService.showMoreEmplyee(startNum, endNum);
		careerList=employeeService.showMoreEmployeeCareer(employeeList);
		
		return "success";
	}
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getEndNum() {
		return endNum;
	}
	public void setEndNum(int endNum) {
		this.endNum = endNum;
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
