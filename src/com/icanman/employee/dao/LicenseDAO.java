package com.icanman.employee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.License;

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
	
	public List<License> read(Connection conn, int no){
		List<License> list = new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		License license=null;
		try {
			String sql="SELECT * FROM LICENSE WHERE MEMBER_NO=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			while(rs.next()){
				license = new License();
				license.setLicense_no(rs.getInt("LICENSE_NO"));
				license.setMember_no(rs.getInt("MEMBER_NO"));
				license.setLicense_name(rs.getString("LICENSE_NAME"));
				license.setLicense_level(rs.getString("LICENSE_LEVEL"));
				license.setLicense_date(rs.getString("LICENSE_GETDATE").substring(0, 10));
				license.setLicense_publisher(rs.getString("LICENSE_PUBLISHER"));
				list.add(license);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return list;
	}
}
