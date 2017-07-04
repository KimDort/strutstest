package com.icanman.projectjoin.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.projectjoin.dao.ProjectJoinDAO;
import com.icanman.projectjoin.model.ProjectJoin;
import com.icanman.tools.DBConn;
import com.icanman.tools.SearchCriteria;

public class ProjectJoinService {
	public List<ProjectJoin> list(SearchCriteria cri)throws SQLException{
		DBConn dbConn=new DBConn();
		Connection conn= dbConn.getConnection();
		List<ProjectJoin> list = new ArrayList<>();
		ProjectJoinDAO dao = new ProjectJoinDAO();
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
}
