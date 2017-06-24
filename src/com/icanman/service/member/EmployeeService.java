package com.icanman.service.member;

import java.sql.Connection;
import java.sql.SQLException;
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

	public List<Employee> list(SearchCriteria cri) throws SQLException {
		DBConn dbConn=new DBConn();
		List<Employee> list=new ArrayList<>();
		Connection conn = dbConn.getConnection();
		EmployeeDAO dao=new EmployeeDAO();
		
		try {
			list=dao.list(conn, cri);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(conn!=null){
				conn.close();
			}
		}
		return list;
	}
	
	public int register(Employee employee, Career career, License license) throws SQLException{
		EmployeeDAO employeeDao = new EmployeeDAO();
		CareerDAO careerDao = new CareerDAO();
		LicenseDAO licenseDao = new LicenseDAO();
		DBConn dbConn=new DBConn();
		Connection conn=null;
		int success=0;
		try {		
			conn=dbConn.getConnection();
			conn.setAutoCommit(false);		
			if(employeeDao.register(conn, employee)!=0){
				if(career!=null){
					careerDao.register(conn, career);
				}else if(license!=null){
					licenseDao.register(conn, license);
				}
			}else{
				if(conn!=null){conn.rollback();success=0;}
			}
			conn.commit();
			success=1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			if(conn!=null){conn.rollback();success=0;}
		}

		return success;
	}
}
