package com.icanman.dao.employee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.icanman.model.Career;

public class CareerDAO {
	public int register(Connection conn, List<Career> list){
		int success = 0;
		String sql = "INSERT INTO CAREER VALUES((SELECT NVL(MAX(CAREER_NO),0)+1 FROM CAREER), (EMPLOYEESEQ.CURRVAL), ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			for (int idx = 0; idx < list.size(); idx++) {
				pstmt.setString(1, list.get(idx).getPeriod_start());
				pstmt.setString(2, list.get(idx).getPeriod_end());
				pstmt.setString(3, list.get(idx).getPeriod_company());
				pstmt.setString(4, list.get(idx).getPeriod_rank());
				pstmt.setString(5, list.get(idx).getPeriod_position());
				success = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return success;

	}
}
