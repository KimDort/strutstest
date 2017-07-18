package com.icanman.employee.action;

import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;import com.icanman.employee.model.License;
import com.icanman.employee.service.EmployeeService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

//Employee List Action Class
public class EmployeeListAction implements Action, Preparable, ModelDriven{
	//List Page Create Class
	private SearchCriteria cri;
	//Employee Info Heap List 
	private List<Employee> list;
	private List<Career> career;
	private List<String> searchSkill;
	
	private int page;
	private int perPageNum;
	
	@Override
	public String execute() throws Exception {
		list=new ArrayList<>();
		EmployeeService employeeService = new EmployeeService();
		list=employeeService.list(cri);
		career=employeeService.careerList();
		searchSkill=employeeService.getMaxSkill();
		return "success";
	}


	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return cri;
	}

	@Override
	public void prepare() throws Exception {
		cri = new SearchCriteria();
	}
	
	
	public List<String> getSearchSkill() {
		return searchSkill;
	}


	public void setSearchSkill(List<String> searchSkill) {
		this.searchSkill = searchSkill;
	}


	public List<Career> getCareer() {
		return career;
	}


	public void setCareer(List<Career> career) {
		this.career = career;
	}


	public SearchCriteria getCri() {
		return cri;
	}


	public void setCri(SearchCriteria cri) {
		this.cri = cri;
	}


	public List<Employee> getList() {
		return list;
	}

	public void setList(List<Employee> list) {
		this.list = list;
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
	
}
