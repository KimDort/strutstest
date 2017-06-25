package com.icanman.dao.projectjoin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.model.ProjectJoin;
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
			while(rs.next()){
				ProjectJoin vo = new ProjectJoin();
				vo.setNo(rs.getInt("JOIN_NO"));
				vo.setMno(rs.getInt("MEMBER_NO"));
				vo.setPno(rs.getInt("PROJECT_NO"));
				vo.setPosition(rs.getString("JOIN_POSITION"));
				vo.setJoin(rs.getString("JOIN_IN").substring(0, 10));
				vo.setOut(rs.getString("JOIN_OUT").substring(0, 10));
				vo.setProject(rs.getString("PROJECT_NAME"));
				vo.setMember(rs.getString("EMPLOYEE"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
