package com.icanman.employee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Employee;
import com.icanman.tools.SearchCriteria;

//Employee DAO Class
public class EmployeeDAO{
	
	//Employee Get List Method
	public List<Employee> list(Connection conn, SearchCriteria cri){
		List<Employee> list = new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT * FROM (SELECT ROWNUM AS R,"
					+"MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
					+"MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
					+"MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,"
					+"PROJECT_HISTORY,  MEMBER_HAVESKILL, MEMBER_ISEXIT "
					+"FROM (SELECT MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
					+"MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
					+"MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW," 
					+"(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.MEMBER_NO=EMPLOYEE.MEMBER_NO) AS PROJECT_HISTORY,"
					+" MEMBER_HAVESKILL, MEMBER_ISEXIT "
					+"FROM EMPLOYEE ORDER BY MEMBER_NO DESC"
					+"))WHERE R >= ? AND R <= ? AND MEMBER_ISEXIT = 'N' ";
			try {
				pstmt=conn.prepareStatement(sql);
				int idx=1;
				pstmt.setInt(idx++, cri.getPage());
				pstmt.setInt(idx++, cri.getPageEnd());
				rs=pstmt.executeQuery();
				while(rs.next()){
					Employee vo = new Employee();
					vo.setNo(rs.getInt("MEMBER_NO"));
					vo.setName(rs.getString("MEMBER_NAME"));
					vo.setCompany(rs.getString("MEMBER_COMPANY"));
					vo.setIdnumber1(rs.getString("MEMBER_IDNUMBER").split("-")[0]);
					vo.setIdnumber2(rs.getString("MEMBER_IDNUMBER").split("-")[1]);
					vo.setZipcode(rs.getString("MEMBER_ZIPCODE"));
					vo.setAddress(rs.getString("MEMBER_ADDRESS"));
					vo.setAddress_detail(rs.getString("MEMBER_ADDRESS_DETAIL"));
					vo.setRank(rs.getString("MEMBER_RANK"));
					vo.setJoin(rs.getString("MEMBER_JOIN"));
					vo.setOut(rs.getString("MEMBER_OUT"));
					vo.setIsnew(rs.getString("MEMBER_ISNEW"));
					vo.setHaveskill(rs.getString("MEMBER_HAVESKILL"));
					vo.setProjecthistory(rs.getInt("PROJECT_HISTORY"));
					vo.setIsexit(rs.getString("MEMBER_ISEXIT").charAt(0));
					list.add(vo);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally {
				if(rs!=null){try {rs.close();} catch (Exception e2) {}}
				if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
			}
		return list;
	}
	
	//Employee DB Insert Method
	public int register(Connection conn, Employee vo){
		int success=0;
		PreparedStatement pstmt=null;
		try {
			String sql="INSERT INTO EMPLOYEE VALUES(EMPLOYEESEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt=conn.prepareStatement(sql);
			int idx=1;
			pstmt.setString(idx++, vo.getName());
			pstmt.setString(idx++, vo.getCompany());
			pstmt.setString(idx++, vo.getIdnumber1()+"-"+vo.getIdnumber2());
			pstmt.setString(idx++, vo.getZipcode());
			pstmt.setString(idx++, vo.getAddress());
			pstmt.setString(idx++, vo.getAddress_detail());
			pstmt.setString(idx++, vo.getRank());
			pstmt.setString(idx++, vo.getJoin());
			pstmt.setString(idx++, vo.getOut());
			pstmt.setString(idx++, vo.getIsnew());
			pstmt.setString(idx++, vo.getHaveskill());	
			pstmt.setString(idx++, String.valueOf(vo.getIsexit()));
			pstmt.setString(idx++, vo.getPosition());
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			success=0;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return success;
	}
	
	//Read Employee 
	public Employee read(Connection conn, int no){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Employee employee = null;
		try {
			employee = new Employee();
			String sql="SELECT * FROM EMPLOYEE WHERE MEMBER_NO = ? AND MEMBER_ISEXIT != 'Y'";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			while(rs.next()){
				employee.setNo(rs.getInt("MEMBER_NO"));
				employee.setName(rs.getString("MEMBER_NAME"));
				employee.setCompany(rs.getString("MEMBER_COMPANY"));
				employee.setIdnumber1(rs.getString("MEMBER_IDNUMBER").split("-")[0]);
				employee.setIdnumber2(rs.getString("MEMBER_IDNUMBER").split("-")[1]);
				employee.setZipcode(rs.getString("MEMBER_ZIPCODE"));
				employee.setAddress(rs.getString("MEMBER_ADDRESS"));
				employee.setAddress_detail(rs.getString("MEMBER_ADDRESS_DETAIL"));
				employee.setRank(rs.getString("MEMBER_RANK"));
				employee.setJoin(rs.getString("MEMBER_JOIN").substring(0,10));
				employee.setOut(rs.getString("MEMBER_OUT"));
				employee.setIsnew(rs.getString("MEMBER_ISNEW"));
				employee.setHaveskill(rs.getString("MEMBER_HAVESKILL"));
				employee.setIsexit(rs.getString("MEMBER_ISEXIT").charAt(0));
				employee.setPosition(rs.getString("MEMBER_POSITION"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return employee;
	}
}
