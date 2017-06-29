package com.icanman.employee.service;

import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.Validate;
import com.icanman.tools.BaseValidate;

public class EmployeeValidateService {
	private BaseValidate baseValidate = new BaseValidate();
	Class<Employee> aClass=Employee.class;
	
	public Validate employeeNullCheck(Employee employee) throws Exception {
		Validate validate = new Validate();
		
		for(int idx=0;idx<aClass.getMethods().length;idx++){
			System.out.println("field name : "+aClass.getMethods()[idx].getReturnType());
		}
		try {
			if (baseValidate.checkNull(employee.getName())) {
				validate.setMessage("이름을 입력해 주십시오.");
				validate.setFocus("employee.company");
				validate.setTrue(false);
				return validate;
			}

			if (baseValidate.checkNull(employee.getCompany())) {
				validate.setMessage("소속회사를 입력해 주십시오.");
				validate.setFocus("employee.company");
				validate.setTrue(false);
				return validate;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw e;
		}
		return validate;
	}

	public Validate careerNullCheck(List<Career> list) throws Exception {
		Validate validate = new Validate();
		
		String msg = "";
		String focus = "";
		boolean isTrue = true;

		return validate;
	}
}
