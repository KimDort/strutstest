package com.icanman.project.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.project.dao.ProjectDAO;
import com.icanman.project.model.Project;
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
			e.printStackTrace();
			throw e;
		}finally {
			if(conn!=null){conn.close();}
		}	
		return list;
	}
	public List<Project> list()throws SQLException{
		DBConn dbConn=new DBConn();
		Connection conn=dbConn.getConnection();
		ProjectDAO dao=new ProjectDAO(); 
		List<Project> list = new ArrayList<>();
		try {
			list=dao.list(conn);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
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
			success=dao.register(conn, vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(conn!=null){conn.close();}
		}
		return success;
	}
	
	public Project read(int pno)throws SQLException{
		Project project = new Project();
		DBConn dbConn=new DBConn();
		Connection conn=dbConn.getConnection();
		ProjectDAO dao=new ProjectDAO();
		try {
			project=dao.read(conn, pno);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(conn!=null){conn.close();}
		}
		
		return project;
	}
	public int modify(Project vo)throws SQLException{
		int success=0;
		DBConn dbConn=new DBConn();
		Connection conn=dbConn.getConnection();
		ProjectDAO dao=new ProjectDAO();
		try {
			success=dao.modify(conn, vo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(conn!=null){conn.close();}
		}
		return success;
	}
	
	public int delete(int pno)throws SQLException{
		int success=0;
		DBConn dbConn=new DBConn();
		ProjectDAO dao= new ProjectDAO();
		Connection conn=null;
		try {
			conn=dbConn.getConnection();
			success=dao.delete(conn, pno);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(conn!=null){conn.close();}
		}
		return success;
	}
}
