package com.icanman.projectjoin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.projectjoin.model.ProjectJoin;
import com.icanman.tools.SearchCriteria;

public class ProjectJoinDAO {
	
	public List<ProjectJoin> list(Connection conn, SearchCriteria cri)throws SQLException{
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProjectJoin> list = new ArrayList<>();
		
		String sql="SELECT "
				+"		JOIN_NO, PROJECT_NO, MEMBER_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT, PROJECT_NAME, EMPLOYEE, R "
				+"	FROM "
				+"		(SELECT "
				+"			JOIN_NO, PROJECT_NO, MEMBER_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT, PROJECT_NAME, EMPLOYEE, ROWNUM AS R "
				+"		FROM "
				+"			("
				+"			SELECT JOIN_NO, PROJECT_NO, MEMBER_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT, "
				+"				(SELECT PROJECT_NAME FROM PROJECT WHERE PROJECT.PROJECT_NO = PROJECT_JOIN.PROJECT_NO)AS PROJECT_NAME,"
				+"				(SELECT MEMBER_NAME FROM EMPLOYEE WHERE MEMBER_NO=PROJECT_JOIN.MEMBER_NO)AS EMPLOYEE "
				+"			FROM PROJECT_JOIN ORDER BY JOIN_NO DESC"
				+"			)"
				+"		)"
				+"	WHERE R >= ? "
				+"	AND R <= ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cri.getPageStart());
			pstmt.setInt(2, cri.getPageEnd());
			rs=pstmt.executeQuery();
			while(rs.next()){
				ProjectJoin vo = new ProjectJoin();
				vo.setNo(rs.getInt("JOIN_NO"));
				vo.setMno(rs.getInt("MEMBER_NO"));
				vo.setPno(rs.getInt("PROJECT_NO"));
				vo.setPosition(rs.getString("JOIN_POSITION"));
				vo.setJoin(rs.getString("JOIN_IN").substring(0, 10));
				vo.setOut(rs.getString("JOIN_OUT").substring(0, 10));
				vo.setName(rs.getString("PROJECT_NAME"));
				vo.setMember(rs.getString("EMPLOYEE"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return list;
	}
	
	public int register(Connection conn, List<ProjectJoin> list)throws SQLException{
		PreparedStatement pstmt=null;
		int success=0;
		String sql="INSERT INTO "
				+ "		PROJECT_JOIN(JOIN_NO, MEMBER_NO, PROJECT_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT) "
				+ "			VALUES(PROJECTJOINSEQ.NEXTVAL, ?, ?, ?, ?, ?)";
		try {
			pstmt=conn.prepareStatement(sql);
			for(int idx=0;idx<list.size();idx++){
				pstmt.setInt(1, list.get(idx).getMno());
				pstmt.setInt(2, list.get(idx).getPno());
				pstmt.setString(3, list.get(idx).getPosition());
				pstmt.setString(4, list.get(idx).getJoin());
				pstmt.setString(5, list.get(idx).getOut());
				success=pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		
		return success;
	}
	public List<ProjectJoin> read(Connection conn, int projectNumber)throws Exception{
		PreparedStatement pstmt=null;
		List<ProjectJoin> list = new ArrayList<>();
		ResultSet rs=null;
		String sql="SELECT "
				+ "		JOIN_NO, MEMBER_NO, PROJECT_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT, "
				+ "		(SELECT MEMBER_NAME FROM EMPLOYEE WHERE EMPLOYEE.MEMBER_NO=PROJECT_JOIN.MEMBER_NO)AS MEMBER_NAME "
				+ "	FROM PROJECT_JOIN "
				+ "	WHERE PROJECT_NO=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, projectNumber);
			rs=pstmt.executeQuery();
			while(rs.next()){
				ProjectJoin projectJoin = new ProjectJoin();
				projectJoin.setNo(rs.getInt("JOIN_NO"));
				projectJoin.setPno(rs.getInt("PROJECT_NO"));
				projectJoin.setMno(rs.getInt("MEMBER_NO"));
				projectJoin.setPosition(rs.getString("JOIN_POSITION"));
				projectJoin.setJoin(rs.getString("JOIN_IN").substring(0, 10));
				projectJoin.setOut(rs.getString("JOIN_OUT").substring(0, 10));
				projectJoin.setMember(rs.getString("MEMBER_NAME"));
				list.add(projectJoin);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		
		return list;
	}
	
	public int deleteMember(Connection conn, int memberNum)throws Exception{
		int success=0;
		PreparedStatement pstmt=null;
		String sql="DELETE "
				+ "		FROM "
				+ "			PROJECT_JOIN "
				+ "		WHERE MEMBER_NO = ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		
		return success;
	}
}
