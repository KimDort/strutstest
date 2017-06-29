package com.icanman.employee.service;

import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.Validate;
import com.icanman.tools.BaseValidate;

public class EmployeeValidateService {
	private BaseValidate baseValidate = new BaseValidate();

	public Validate employeeNullCheck(Employee employee) throws Exception {
		Validate validate = new Validate();

		String msg = "";
		String focus = "";
		boolean isTrue = true;

		try {
			if (!baseValidate.checkNull(employee.getName())) {
				msg = "이름을 입력해 주십시오.";
				focus = "employee.name";
				isTrue = false;
			}

			if (!baseValidate.checkNull(employee.getCompany())) {
				msg = "소속회사를 입력해 주십시오.";
				focus = "employee.company";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getRank())) {
				msg = "직급을  선택해 주십시오.";
				focus = "employee.rank";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getPosition())) {
				msg = "역활 및 직무를 입력해 주십시오.";
				focus = "employee.position";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getJoin())) {
				msg = "입사일을 선택해 주십시오.";
				focus = "employee.join";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getIsnew())) {
				msg = "신입 또는 경력을 선택해 주십시오.";
				focus = "employee.isnew";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getHaveskill())) {
				msg = "스킬은 하나 이상 입력하셔야 합니다.";
				focus = "employee.haveskill";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getIdnumber1())) {
				msg = "생년월일을 입력하셔야 합니다.";
				focus = "employee.idnumber1";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getIdnumber2())) {
				msg = "주민번호를 입력하셔야 합니다.";
				focus = "employee.idnumber2";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getZipcode())) {
				msg = "주소를 입력하셔야 합니다.";
				focus = "search";
				isTrue = false;
			}
			if (!baseValidate.checkNull(employee.getAddress_detail())) {
				msg = "상세주소를 입력하셔야 합니다.";
				focus = "employee.address_detail";
				isTrue = false;
			}

			validate.setMessage(msg);
			validate.setFocus(focus);
			validate.setTrue(isTrue);
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
