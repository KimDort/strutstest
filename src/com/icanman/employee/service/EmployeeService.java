package com.icanman.employee.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.dao.CareerDAO;
import com.icanman.employee.dao.EmployeeDAO;
import com.icanman.employee.dao.LicenseDAO;
import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.License;
import com.icanman.employee.model.Validate;
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
				careerSuccess=careerDao.register(conn, inputBaseCareer(employee, careerList));
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
	public List<Career> inputBaseCareer(Employee employee, List<Career> getList)throws Exception{
		List<Career> list=getList;
		try {
			Career career = new Career();
			career.setPeriod_start(employee.getJoin());
			career.setPeriod_end(employee.getOut().isEmpty()?"":employee.getOut());
			career.setPeriod_company(employee.getCompany());
			career.setPeriod_rank(employee.getRank());
			career.setPeriod_position(employee.getPosition());
			list.add(0, career);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}
	public Employee readEmployee(int no)throws Exception{
		EmployeeDAO employeeDao = new EmployeeDAO();
		Employee employee=null;
		DBConn dbConn=new DBConn();
		Connection conn=null;
		try {
			conn=dbConn.getConnection();
			employee=employeeDao.read(conn, no);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(conn!=null){try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return employee;
	}
	
	public List<Career> readCareer(int no){
		CareerDAO careerDao = new CareerDAO();
		List<Career> list = new ArrayList<>();
		DBConn dbConn=new DBConn();
		Connection conn=null;
		try {
			conn=dbConn.getConnection();
			list=careerDao.read(conn, no);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null){try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return list;
	}
	
	public List<License> readLicense(int no){
		LicenseDAO licenseDao = new LicenseDAO();
		List<License> list = new ArrayList<>();
		DBConn dbConn=new DBConn();
		Connection conn=null;
		try {
			conn=dbConn.getConnection();
			list=licenseDao.read(conn, no);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null){try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return list;
	}
	public List<Career> createList(Career vo){
		List<Career> list = new ArrayList<>();
		String[] period_start = vo.getPeriod_start().replaceAll(" ", "").split(",",-1);
		String[] period_end = vo.getPeriod_end().replaceAll(" ", "").split(",",-1);
		String[] period_company = vo.getPeriod_company().replaceAll(" ", "").split(",",-1);
		String[] period_position = vo.getPeriod_position().replaceAll(" ", "").split(",",-1);
		String[] period_rank = vo.getPeriod_rank().replaceAll(" ", "").split(",",-1);
		System.out.println("경력 리스트로 변환 : "+vo.getPeriod_start());
		System.out.println("경력 리스트 배열 사이즈 : "+period_start.length);
		
		for(int idx=0; idx < period_start.length; idx++){
			Career career = new Career();
			System.out.println("경력 리스트 변환 중 idx : "+idx);
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
		String[] license_name=vo.getLicense_name().replaceAll(" ", "").split(",",-1);
		String[] license_level=vo.getLicense_level().replaceAll(" ", "").split(",",-1);
		String[] license_getdate=vo.getLicense_date().replaceAll(" ", "").split(",",-1);
		String[] license_publisher=vo.getLicense_publisher().replaceAll(" ", "").split(",",-1);
		System.out.println("자격증 리스트로 변환 : "+vo.getLicense_name());
		System.out.println("자격증 리스트 배열 사이즈 : "+license_name.length);
		for(int idx=0;idx<license_name.length;idx++){
			License license = new License();
			System.out.println("자격증 리스트 변환 중 idx : "+idx);
			license.setLicense_name(license_name[idx]);
			license.setLicense_level(license_level[idx]);
			license.setLicense_date(license_getdate[idx]);
			license.setLicense_publisher(license_publisher[idx]);
			list.add(license);
		}
		return list;
	}
}
