package com.icanman.employee.service;

import com.icanman.employee.model.Employee;
import com.icanman.employee.model.Validate;
import com.icanman.tools.BaseValidate;

public class EmployeeValidateService {
	private BaseValidate baseValidate = new BaseValidate();
	
	public Validate employeeNullCheck(Employee employee){
		Validate validate = new Validate();
		
		String msg="";
		String focus="";
		boolean isTrue=true;
		
		if(!baseValidate.checkNull(employee.getName())){
			msg="이름을 입력해 주십시오.";
			focus="employee.name";
			isTrue=false;
		}
		
		validate.setMessage(msg);
		validate.setFocus(focus);
		validate.setTrue(isTrue);
		return validate;
	}
}
