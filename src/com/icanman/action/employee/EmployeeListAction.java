package com.icanman.action.employee;

import java.util.ArrayList;
import java.util.List;

import com.icanman.model.Employee;
import com.icanman.service.member.EmployeeService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

//Employee List Action Class
public class EmployeeListAction implements Action, Preparable, ModelDriven{
	
	//Employee List Service Class
	private EmployeeService employeeServiceImpl;
	//List Page Create Class
	private SearchCriteria cri;
	//Employee Info Heap List 
	private List<Employee> list;
	
	@Override
	public String execute() throws Exception {
		list=new ArrayList<>();
		employeeServiceImpl = new EmployeeService();
		list=employeeServiceImpl.list(cri);
		cri=cri;
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
}
