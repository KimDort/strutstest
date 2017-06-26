package com.icanman.service.employee;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.icanman.dao.employee.CareerDAO;
import com.icanman.dao.employee.EmployeeDAO;
import com.icanman.dao.employee.LicenseDAO;
import com.icanman.model.Career;
import com.icanman.model.Employee;
import com.icanman.model.License;
import com.icanman.tools.DBConn;
import com.icanman.tools.SearchCriteria;
//Employee Service Class
public class EmployeeService{

	public List<Employee> list(SearchCriteria cri){
		DBConn dbConn=new DBConn();
		List<Employee> list=new ArrayList<>();
		EmployeeDAO dao=new EmployeeDAO();	
		Connection conn =null;
		try {
			conn = dbConn.getConnection();
			list=dao.list(conn, cri);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null){try {conn.close();} catch (Exception e2) {}}
		}
		return list;
	}
	
	public int register(Employee employee, Career career, License license){
		EmployeeDAO employeeDao = new EmployeeDAO();
		CareerDAO careerDao = new CareerDAO();
		LicenseDAO licenseDao = new LicenseDAO();
		DBConn dbConn=new DBConn();
		Connection conn=null;
		int success=0;
		int employeeSuccess=0;
		int careerSuccess=0;
		int licenseSuccess=0;
		
		List<Career> careerList = new ArrayList<>();
		List<License> licenseList = new ArrayList<>();
		try {		
			conn=dbConn.getConnection();
			conn.setAutoCommit(false);		
			
			employeeSuccess=employeeDao.register(conn, employee);
			
			if(career!=null){
				careerList=createList(career);
				careerSuccess=careerDao.register(conn, careerList);
			}else{
				careerSuccess=1;
			}
			if(license!=null){
				licenseList=createList(license);
				licenseSuccess=licenseDao.register(conn, licenseList);
			}else{
				licenseSuccess=1;
			}
			
			if(employeeSuccess > 0 && careerSuccess > 0 && licenseSuccess > 0){
				conn.commit();
				success=1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(conn!=null){try {conn.rollback();} catch (Exception e2) {}}
		}finally {
			if(conn!=null){try {conn.setAutoCommit(true);conn.close();} catch (Exception e2) {}}
		}

		return success;
	}
	public List<Career> createList(Career vo){
		List<Career> list = new ArrayList<>();
		String[] period_start = vo.getPeriod_start().replaceAll(" ", "").split(",");
		String[] period_end = vo.getPeriod_end().replaceAll(" ", "").split(",");
		String[] period_company = vo.getPeriod_company().replaceAll(" ", "").split(",");
		String[] period_position = vo.getPeriod_position().replaceAll(" ", "").split(",");
		String[] period_rank = vo.getPeriod_rank().replaceAll(" ", "").split(",");
	
		for(int idx=0; idx < period_start.length; idx++){
			Career career = new Career();
			career.setPeriod_start(period_start[idx]);
			career.setPeriod_end(period_end[idx]);
			career.setPeriod_company(period_company[idx]);
			career.setPeriod_rank(period_rank[idx]);
			career.setPeriod_position(period_position[idx]);
			list.add(career);
		}
		return list;
	}
	public List<License> createList(License vo){
		List<License> list = new ArrayList<>();
		String[] license_name=vo.getLicense_name().replaceAll(" ", "").split(",");
		String[] license_level=vo.getLicense_level().replaceAll(" ", "").split(",");
		String[] license_getdate=vo.getLicense_date().replaceAll(" ", "").split(",");
		String[] license_publisher=vo.getLicense_publisher().replaceAll(" ", "").split(",");
		for(int idx=0;idx<license_name.length;idx++){
			License license = new License();
			license.setLicense_name(license_name[idx]);
			license.setLicense_level(license_level[idx]);
			license.setLicense_date(license_getdate[idx]);
			license.setLicense_publisher(license_publisher[idx]);
			list.add(license);
		}
		return list;
	}
	
	public String employeeNullValidation(Employee employee){
		String message ="";
		if(!checkNull(employee.getName())){
			message="이름을 입력해 주십시오.";
		}else if(!checkNull(employee.getCompany())){
			message="소속회사를 입력해 주십시오.";
		}else if(!checkNull(employee.getRank())){
			message="직급을 선택해 주십시오.";
		}else if(!checkNull(employee.getPosition())){
			message="역할 및 직무를 입력해 주십시오.";
		}else if(!checkNull(employee.getJoin())){
			message="입사일을 선택해 주십시오.";
		}else if(!checkNull(employee.getIsnew())){
			message="경력 & 신입 중 선택해 주십시오.";
		}else if(!checkNull(employee.getHaveskill())){
			message="스킬은 하나 이상 입력하셔야 합니다.";
		}else if(!checkNull(employee.getIdnumber1())){
			message="생년월일을 입력해 주십시오.";
		}else if(!checkNull(employee.getIdnumber2())){
			message="주민등록번호를 입력해 주십시오.";
		}else if(!checkNull(employee.getZipcode()) || !checkNull(employee.getAddress())){
			message="주소를 입력하셔야 합니다.";
		}else if(!checkNull(employee.getAddress_detail())){
			message="상세 주소를 입력해 주십시오.";
		}
		return message;
	}
	
	public boolean checkNull(String textVal){
		boolean nullcheck=false;
		textVal=textVal.trim();
		if("".equals(textVal) || null==textVal || textVal.isEmpty()){
			nullcheck=false;
		}else{
			nullcheck=true;
		}
		return nullcheck;
	}
}
