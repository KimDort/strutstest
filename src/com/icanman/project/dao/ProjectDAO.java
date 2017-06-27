package com.icanman.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.project.model.Project;
import com.icanman.tools.DBConn;
import com.icanman.tools.SearchCriteria;

public class ProjectDAO {	
	public int register(Connection conn, Project vo)throws SQLException{
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
	
	public List<Project> list(Connection conn, SearchCriteria cri)throws SQLException{
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
				vo.setStart(rs.getString("PROJECT_START").substring(0, 10));
				vo.setEnd(rs.getString("PROJECT_END").substring(0, 10));
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
	public Project read(Connection conn, int pno)throws SQLException{
		Project project = new Project();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT * FROM PROJECT WHERE PROJECT_NO=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
			rs=pstmt.executeQuery();
			while(rs.next()){
				project.setNo(rs.getInt("PROJECT_NO"));
				project.setName(rs.getString("PROJECT_NAME"));
				project.setContent(rs.getString("PROJECT_CONTENT"));
				project.setStart(rs.getString("PROJECT_START"));
				project.setEnd(rs.getString("PROJECT_END"));
				project.setOrder_company(rs.getString("PROJECT_ORDER_COMPANY"));
				project.setCreate_skill(rs.getString("PROJECT_CREATE_SKILL"));
				project.setEtc(rs.getString("PROJECT_ETC"));
				project.setIsdelete(rs.getString("PROJECT_ISDELETE").charAt(0));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return project;
	}
	
	public int modify(Connection conn, Project vo)throws SQLException{
		int success=0;
		PreparedStatement pstmt=null;
		String sql="UPDATE PROJECT SET PROJECT_NAME=?, PROJECT_CONTENT=?, PROJECT_START=?, PROJECT_END=?, "
				+ "PROJECT_ORDER_COMPANY=?, PROJECT_CREATE_SKILL=?, PROJECT_ETC=? WHERE PROJECT_NO=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getStart());
			pstmt.setString(4, vo.getEnd());
			pstmt.setString(5, vo.getOrder_company());
			pstmt.setString(6, vo.getCreate_skill());
			pstmt.setString(7, vo.getEtc());
			pstmt.setInt(8, vo.getNo());
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return success;
	}
	
	public int delete(Connection conn, int pno)throws SQLException{
		int success=0;
		PreparedStatement pstmt=null;
		String sql="UPDATE PROJECT SET PROJECT_ISDELETE='Y' WHERE PROJECT_NO=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			if(conn!=null){conn.rollback();}
		}
		return success;
	}
}
