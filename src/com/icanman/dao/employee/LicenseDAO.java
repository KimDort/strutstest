package com.icanman.dao.employee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.icanman.model.License;

public class LicenseDAO {
	public int register(Connection conn, List<License> list){
		int success=0;
		PreparedStatement pstmt=null;
		String sql="INSERT INTO LICENSE VALUES((SELECT NVL(MAX(LICENSE_NO),0)+1 FROM LICENSE),"
				+ "(EMPLOYEESEQ.CURRVAL), ?, ?, ?, ?)";
		try {
			pstmt=conn.prepareStatement(sql);
			for(int idx=0;idx<list.size();idx++){
				pstmt.setString(1, list.get(idx).getLicense_name());
				pstmt.setString(2, list.get(idx).getLicense_level());
				pstmt.setString(3, list.get(idx).getLicense_date());
				pstmt.setString(4, list.get(idx).getLicense_publisher());
				success=pstmt.executeUpdate();
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
