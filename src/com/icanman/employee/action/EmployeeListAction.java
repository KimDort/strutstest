package com.icanman.employee.action;

import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Employee;
import com.icanman.employee.service.EmployeeService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

//Employee List Action Class
public class EmployeeListAction implements Action, Preparable, ModelDriven{
	
	//Employee List Service Class
	private EmployeeService employeeService;
	//List Page Create Class
	private SearchCriteria cri;
	//Employee Info Heap List 
	private List<Employee> list;
	
	private int page;
	private int perPageNum;
	
	@Override
	public String execute() throws Exception {
		list=new ArrayList<>();
		employeeService = new EmployeeService();
		list=employeeService.list(cri);/*
		Career career = new Career();
		List<Career> carlist=new ArrayList<>();
		career.setPeriod_start("2017-05-01");
		career.setPeriod_end("2017-06-21");
		carlist.add(career);
		System.out.println(employeeService.checkJoinDate("2017-05-01", carlist));
		System.out.println(employeeService.checkNowDate("2017-06-29"));*/
		
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
