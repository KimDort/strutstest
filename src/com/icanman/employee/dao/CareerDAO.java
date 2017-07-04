package com.icanman.employee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;

public class CareerDAO {
	public int register(Connection conn, List<Career> list){
		int success = 0;
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO CAREER VALUES((SELECT NVL(MAX(CAREER_NO),0)+1 FROM CAREER), (EMPLOYEESEQ.CURRVAL), ?, ?, ?, ?, ?)";
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
	public int register(Connection conn, List<Career> list, int mno){
		int success = 0;
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO CAREER VALUES((SELECT NVL(MAX(CAREER_NO),0)+1 FROM CAREER), ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			int pstmtCount=1;
			for (int idx = 0; idx < list.size(); idx++) {
				pstmt.setInt(pstmtCount++, mno);
				pstmt.setString(pstmtCount++, list.get(idx).getPeriod_start());
				pstmt.setString(pstmtCount++, list.get(idx).getPeriod_end());
				pstmt.setString(pstmtCount++, list.get(idx).getPeriod_company());
				pstmt.setString(pstmtCount++, list.get(idx).getPeriod_rank());
				pstmt.setString(pstmtCount++, list.get(idx).getPeriod_position());
				success = pstmt.executeUpdate();
				pstmtCount=1;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return success;

	}
	public List<Career> list(Connection conn)throws Exception{
		List<Career> list = new ArrayList<>();
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		Career career=null;
		try {
			String sql="SELECT"
					+ "		CAREER_NO, MEMBER_NO, CAREER_PERIOD_START,"
					+ "		NVL(CAREER_PERIOD_END,SYSDATE)AS CAREER_PERIOD_END,"
					+ "		CAREER_COMPANY, CAREER_RANK, CAREER_POSITION"
					+ "	FROM "
					+ "		CAREER ";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				career = new Career();
				career.setPeriod_no(rs.getInt("CAREER_NO"));
				career.setMember_no(rs.getInt("MEMBER_NO"));
				career.setPeriod_start(rs.getString("CAREER_PERIOD_START").substring(0,10));
				career.setPeriod_end(rs.getString("CAREER_PERIOD_END").substring(0, 10));
				career.setPeriod_company(rs.getString("CAREER_COMPANY"));
				career.setPeriod_rank(rs.getString("CAREER_RANK"));
				career.setPeriod_position(rs.getString("CAREER_POSITION"));
				list.add(career);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return list;
	}
		
	public List<Career> read(Connection conn, int member_no){
		List<Career> list = new ArrayList<>();
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		Career career=null;
		try {
			String sql="SELECT"
					+ "		CAREER_NO, MEMBER_NO, CAREER_PERIOD_START,"
					+ "		NVL(CAREER_PERIOD_END,SYSDATE)AS CAREER_PERIOD_END,"
					+ "		CAREER_COMPANY, CAREER_RANK, CAREER_POSITION"
					+ "	FROM "
					+ "			CAREER "
					+ "	WHERE MEMBER_NO=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, member_no);
			rs=pstmt.executeQuery();
			while(rs.next()){
				career = new Career();
				career.setPeriod_no(rs.getInt("CAREER_NO"));
				career.setMember_no(rs.getInt("MEMBER_NO"));
				career.setPeriod_start(rs.getString("CAREER_PERIOD_START").substring(0,10));
				career.setPeriod_end(rs.getString("CAREER_PERIOD_END").substring(0, 10));
				career.setPeriod_company(rs.getString("CAREER_COMPANY"));
				career.setPeriod_rank(rs.getString("CAREER_RANK"));
				career.setPeriod_position(rs.getString("CAREER_POSITION"));
				list.add(career);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return list;
	}
	public int delete(Connection conn, int member_no)throws Exception{
		int success=0;
		PreparedStatement pstmt=null;
		String sql="DELETE FROM CAREER WHERE MEMBER_NO=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, member_no);
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}
			}
		}
		return success;
	}
	
	public List<Career> showMoreEmployeeCareer(Connection conn, List<Employee> employeeList)throws Exception{
		List<Career> list= new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT "
				+ "		CAREER_NO, MEMBER_NO, CAREER_PERIOD_START, NVL(CAREER_PERIOD_END,SYSDATE)AS CAREER_PERIOD_END, "
				+ "		CAREER_COMPANY, CAREER_RANK, CAREER_POSITION "
				+ "	FROM CAREER"
				+ "	WHERE MEMBER_NO=?";
		try {
			pstmt=conn.prepareStatement(sql);
			int pstmtCount=1;
			for(int idx=0;idx<employeeList.size();idx++){
				pstmt.setInt(pstmtCount++, employeeList.get(idx).getNo());
				rs=pstmt.executeQuery();
				while(rs.next()){
					Career career = new Career();
					career.setMember_no(rs.getInt("MEMBER_NO"));
					career.setPeriod_company(rs.getString("CAREER_COMPANY"));
					career.setPeriod_start(rs.getString("CAREER_PERIOD_START").substring(0, 10));
					career.setPeriod_end(rs.getString("CAREER_PERIOD_END").substring(0, 10));
					career.setPeriod_no(rs.getInt("CAREER_NO"));
					career.setPeriod_position(rs.getString("CAREER_POSITION"));
					career.setPeriod_rank(rs.getString("CAREER_RANK"));
					list.add(career);
				}
				pstmtCount=1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}
			}
		}
		return list;
	}
}
