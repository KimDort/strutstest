package com.icanman.service.member;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.icanman.dao.employee.EmployeeDAO;
import com.icanman.model.Employee;
import com.icanman.tools.DBConn;
import com.icanman.tools.SearchCriteria;
//Employee Service Class
public class EmployeeService{
	
	//DB Connection Class
	private DBConn dbConn;

	public List<Employee> list(SearchCriteria cri) throws Exception {
		dbConn=new DBConn();
		List<Employee> list=new ArrayList<>();
		Connection conn = dbConn.getConnection();
		EmployeeDAO dao=new EmployeeDAO();
		
		list=dao.list(conn, cri);
		
		if(conn!=null){
			conn.close();
		}
		return list;
	}
	
	public int register(Employee vo)throws Exception{
		dbConn=new DBConn();
		Connection conn=dbConn.getConnection();
		EmployeeDAO dao=new EmployeeDAO();
		
		int success=0;
		success=dao.register(conn, vo);
		
		return success;
	}
}
