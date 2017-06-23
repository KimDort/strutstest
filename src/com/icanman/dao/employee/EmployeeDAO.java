package com.icanman.dao.employee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.icanman.model.Employee;
import com.icanman.tools.SearchCriteria;

//Employee DAO Class
public class EmployeeDAO{
	
	//Employee Get List Method
	public List<Employee> list(Connection conn, SearchCriteria cri) throws Exception {
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
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cri.getPage());
			pstmt.setInt(2, cri.getPageEnd());
			rs=pstmt.executeQuery();
			while(rs.next()){
				Employee vo = new Employee();
				vo.setNo(rs.getInt("MEMBER_NO"));
				vo.setName(rs.getString("MEMBER_NAME"));
				vo.setCompany(rs.getString("MEMBER_COMPANY"));
				vo.setIdnumber(rs.getString("MEMBER_IDNUMBER"));
				vo.setZipcode(rs.getString("MEMBER_ZIPCODE"));
				vo.setAddress(rs.getString("MEMBER_ADDRESS"));
				vo.setAddress_detail(rs.getString("MEMBER_ADDRESS_DETAIL"));
				vo.setRank(rs.getString("MEMBER_RANK"));
				vo.setJoin(rs.getDate("MEMBER_JOIN"));
				vo.setOut(rs.getDate("MEMBER_OUT"));
				vo.setIsnew(rs.getString("MEMBER_ISNEW"));
				vo.setHaveskill(rs.getString("MEMBER_HAVESKILL"));
				vo.setProjecthistory(rs.getInt("PROJECT_HISTORY"));
				vo.setIsexit(rs.getString("MEMBER_ISEXIT").charAt(0));
				list.add(vo);
			}
		return list;
	}
	
	//Employee DB Insert Method
	public int register(Connection conn, Employee vo) throws Exception {
		int success=0;
		PreparedStatement pstmt=null;
		try {
			String sql="INSERT INTO EMPLOYEE VALUES(EMPLOYEESEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getCompany());
			pstmt.setString(3, vo.getIdnumber());
			pstmt.setString(4, vo.getZipcode());
			pstmt.setString(5, vo.getAddress());
			pstmt.setString(6, vo.getAddress_detail());
			pstmt.setString(7, vo.getRank());
			pstmt.setDate(8, vo.getJoin());
			pstmt.setDate(9, vo.getOut());
			pstmt.setString(10, vo.getIsnew());
			pstmt.setString(11, vo.getHaveskill());	
			pstmt.setString(12, String.valueOf(vo.getIsexit()));
			pstmt.setString(13, vo.getPosition());
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return success;
	}

}
