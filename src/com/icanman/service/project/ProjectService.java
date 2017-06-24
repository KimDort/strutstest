package com.icanman.service.project;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.dao.project.ProjectDAO;
import com.icanman.model.Project;
import com.icanman.tools.DBConn;
import com.icanman.tools.SearchCriteria;

public class ProjectService {
	public List<Project> list(SearchCriteria cri)throws SQLException{
		DBConn dbConn=new DBConn();
		Connection conn=dbConn.getConnection();
		ProjectDAO dao=new ProjectDAO(); 
		List<Project> list = new ArrayList<>();
		try {
			list=dao.list(conn, cri);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			if(conn!=null){conn.close();}
		}	
		return list;
	}
	
	public int register(Project vo)throws SQLException{
		int success=0;
		DBConn dbConn=new DBConn();
		Connection conn=dbConn.getConnection();
		ProjectDAO dao=new ProjectDAO(); 
		try {
			conn.setAutoCommit(false);
			success=dao.register(conn, vo);
			conn.commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			if(conn!=null){conn.rollback();success=0;}
		}finally {
			if(conn!=null){conn.close();}
		}
		return success;
	}
}
