package com.icanman.action.employee;

import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

public class EmployeeFromAction implements Action, Preparable, ModelDriven {
	private SearchCriteria cri;
	@Override
	public String execute() throws Exception {
		cri=cri;
		return "success";
	}

	@Override
	public Object getModel() {
		return cri;
	}

	@Override
	public void prepare() throws Exception {
		cri=new SearchCriteria();
	}

	public SearchCriteria getCri() {
		return cri;
	}

	public void setCri(SearchCriteria cri) {
		this.cri = cri;
	}
	
}
