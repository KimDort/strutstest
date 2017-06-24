package com.icanman.dao.employee;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.icanman.model.License;

public class LicenseDAO {
	public int register(Connection conn, License license){
		int success=0;
		PreparedStatement pstmt=null;
		String sql="INSERT INTO LICENSE VALUES((SELECT NVL(MAX(LICENSE_NO),0)+1 FROM LICENSE),"
				+ "(EMPLOYEESEQ.CURRVAL), ?, ?, ?, ?)";
		try {
			pstmt=conn.prepareStatement(sql);
			for(int idx=0;idx<license.getLicense_name().length;idx++){
				pstmt.setString(1, license.getLicense_name()[idx]);
				pstmt.setString(2, license.getLicense_level()[idx]);
				pstmt.setString(3, license.getLicense_date()[idx]);
				pstmt.setString(4, license.getLicense_publisher()[idx]);
				success=pstmt.executeUpdate();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return success;
	}
}
