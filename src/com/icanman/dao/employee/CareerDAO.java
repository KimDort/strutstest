package com.icanman.dao.employee;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.icanman.model.Career;

public class CareerDAO {
	public int register(Connection conn, Career career) throws Exception {
		int success = 0;
		String sql = "INSERT INTO CAREER VALUES((SELECT NVL(MAX(CAREER_NO),0)+1 FROM CAREER), (EMPLOYEESEQ.CURRVAL), ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			for (int idx = 0; idx < career.getPeriod_start().length; idx++) {
				pstmt.setString(1, career.getPeriod_start()[idx]);
				pstmt.setString(2, career.getPeriod_end()[idx]);
				pstmt.setString(3, career.getPeriod_company()[idx]);
				pstmt.setString(4, career.getPeriod_rank()[idx]);
				pstmt.setString(5, career.getPeriod_position()[idx]);
				success = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return success;

	}
}
