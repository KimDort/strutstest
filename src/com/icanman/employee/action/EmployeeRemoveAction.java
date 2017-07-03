package com.icanman.employee.action;

import com.icanman.employee.service.EmployeeService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class EmployeeRemoveAction implements Action{
	private int no;
	private int page;
	private int perPageNum;
	private SearchCriteria cri;
	@Override
	public String execute() throws Exception {
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		
		EmployeeService employeeService = new EmployeeService();
		if(employeeService.deleteUpdate(no)<1){
			return "error";
		}else{
			return "success";
		}
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
