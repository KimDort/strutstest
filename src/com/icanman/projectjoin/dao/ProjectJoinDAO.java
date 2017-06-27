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
		
		String sql="SELECT JOIN_NO, PROJECT_NO, MEMBER_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT, PROJECT_NAME, EMPLOYEE, R FROM "
					+"(SELECT JOIN_NO, PROJECT_NO, MEMBER_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT, PROJECT_NAME, EMPLOYEE,ROWNUM AS R FROM "
					+"(SELECT JOIN_NO, PROJECT_NO, MEMBER_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT, "
					+"(SELECT PROJECT_NAME FROM PROJECT WHERE PROJECT.PROJECT_NO = PROJECT_JOIN.PROJECT_NO)AS PROJECT_NAME,"
					+"(SELECT MEMBER_NAME FROM EMPLOYEE WHERE MEMBER_NO=PROJECT_JOIN.MEMBER_NO)AS EMPLOYEE FROM PROJECT_JOIN ORDER BY JOIN_NO))"
					+"WHERE R >= ? AND R <= ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cri.getPageStart());
			pstmt.setInt(2, cri.getPerPageNum());
			rs=pstmt.executeQuery();
			for(int idx=0;rs.next();idx++){
				ProjectJoin vo = new ProjectJoin();
				/*vo.setNo(rs.getInt("JOIN_NO"));
				vo.setMno(mnoArray);
				vo.setPno(pnoArray);
				vo.setPosition(positionArray);
				vo.setJoin(joinArray);
				vo.setOut(outArray);
				vo.setMember(memberArray);
				vo.setProject(projectArray);*/
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int register(Connection conn, ProjectJoin vo)throws SQLException{
		PreparedStatement pstmt=null;
		int success=0;
		String sql="INSERT INTO PROJECT_JOIN VALUES(PROJECTJOINSEQ.NEXTVAL, ?, ?, ?, ?, ?,)";
		try {
			pstmt=conn.prepareStatement(sql);
			/*for(int idx=0; idx<vo.getMno().length;idx++){
				pstmt.setInt(1, vo.getMno()[idx]);
				pstmt.setInt(2, vo.getPno()[idx]);
				pstmt.setString(3, vo.getPosition()[idx]);
				pstmt.setString(4, vo.getJoin()[idx]);
				pstmt.setString(5, vo.getOut()[idx]);
				success=pstmt.executeUpdate();
			}*/
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			success=0;
		}
		
		return success;
	}
}
