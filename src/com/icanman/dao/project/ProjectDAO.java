package com.icanman.dao.project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.icanman.model.Project;
import com.icanman.tools.DBConn;
import com.icanman.tools.SearchCriteria;

public class ProjectDAO {	
	public int register(Connection conn, Project vo){
		int success=0;
		PreparedStatement pstmt=null;
		String sql="INSERT INTO PROJECT VALUES(projectseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getStart());
			pstmt.setString(4, vo.getEnd());
			pstmt.setString(5, vo.getOrder_company());
			pstmt.setString(6, vo.getCreate_skill());
			pstmt.setString(7, vo.getEtc());
			pstmt.setString(8, String.valueOf(vo.getIsdelete()));
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return success;
	}
	
	public List<Project> list(Connection conn, SearchCriteria cri){
		List<Project> list = new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, PROJECT_END, "
					+"PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL, PROJECT_ETC, PROJECT_ISDELETE FROM "
					+"(SELECT ROWNUM AS R, PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, "
					+"PROJECT_END, PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL, PROJECT_ETC, PROJECT_ISDELETE FROM "
					+"(SELECT PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, PROJECT_END, "
					+"PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL, PROJECT_ETC, PROJECT_ISDELETE FROM PROJECT ORDER BY PROJECT_NO DESC))"
					+"WHERE PROJECT_NO > 0 AND PROJECT_ISDELETE != 'Y' AND R >=? AND R <= ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cri.getPageStart());
			pstmt.setInt(2, cri.getPerPageNum());
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				Project vo=new Project();
				vo.setNo(rs.getInt("PROJECT_NO"));
				vo.setName(rs.getString("PROJECT_NAME"));
				vo.setContent(rs.getString("PROJECT_CONTENT"));
				vo.setStart(rs.getString("PROJECT_START"));
				vo.setEnd(rs.getString("PROJECT_END"));
				vo.setOrder_company(rs.getString("PROJECT_ORDER_COMPANY"));
				vo.setCreate_skill(rs.getString("PROJECT_CREATE_SKILL"));
				vo.setEtc(rs.getString("PROJECT_ETC"));
				vo.setIsdelete(rs.getString("PROJECT_ISDELETE").charAt(0));
				list.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
}
