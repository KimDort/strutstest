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
	public String getMaxSkill(Connection conn)throws Exception{
		String skills="";
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT "
				+ "			LISTAGG(MEMBER_HAVESKILL, ',') WITHIN GROUP(ORDER BY MEMBER_HAVESKILL)  AS MEMBER_HAVESKILL "
				+ "		FROM "
				+ "			EMPLOYEE";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				skills=rs.getString("MEMBER_HAVESKILL");
			}
		}  catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(rs!=null){try {rs.close();} catch (Exception e2) {}}
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		
		return skills;
	}
	public List<Employee> addMoreEmployee(Connection conn)throws Exception{
		List<Employee> list = new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT"
				+ "		MEMBER_NO, MEMBER_NAME, MEMBER_HAVESKILL, MEMBER_POSITION, MEMBER_ISNEW "
				+ "		FROM "
				+ "			EMPLOYEE "
				+ "		WHERE "
				+ "			MEMBER_ISEXIT = 'N'"
				+ "		AND "
				+ "			MEMBER_NO NOT IN(SELECT MEMBER_NO FROM PROJECT_JOIN)";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				Employee employee = new Employee();
				employee.setNo(rs.getInt("MEMBER_NO"));
				employee.setName(rs.getString("MEMBER_NAME"));
				employee.setHaveskill(rs.getString("MEMBER_HAVESKILL"));
				employee.setPosition(rs.getString("MEMBER_POSITION"));
				employee.setIsnew(rs.getString("MEMBER_ISNEW"));
				list.add(employee);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(rs!=null){try {rs.close();} catch (Exception e2) {}}
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return list;
	}
	//Employee Get List Method
	public List<Employee> list(Connection conn, SearchCriteria cri)throws Exception{
		List<Employee> list = new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT "
				+ "		R, MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
				+"		MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
				+"		MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,"
				+"		CASE "
				+"			WHEN PROJECT_HISTORY > 0 THEN '참가중'"
				+"			WHEN PROJECT_HISTORY <= 0 THEN '미참가'"
				+"		END AS PROJECT_HISTORY, "
				+"		MEMBER_HAVESKILL,  MEMBER_HAVESKILL, MEMBER_ISEXIT "
				+"		FROM "
				+"		(SELECT ROWNUM AS R,"
				+"			MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
				+"			MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
				+"			MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,"
				+"			PROJECT_HISTORY,  MEMBER_HAVESKILL, MEMBER_ISEXIT "
				+"			FROM "
				+"				(SELECT MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
				+"					MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
				+"					MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW," 
				+"					(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.MEMBER_NO=EMPLOYEE.MEMBER_NO) "
				+ "					AS PROJECT_HISTORY, MEMBER_HAVESKILL, MEMBER_ISEXIT "
				+"				FROM "
				+ "					EMPLOYEE "
				+ "					ORDER BY MEMBER_NO DESC)"
				+ "		)"
				+ "	WHERE R >= ? "
				+ "	AND R <= ? "
				+ "	AND MEMBER_ISEXIT = 'N' "
				+ "	AND MEMBER_NAME LIKE '%' || ? || '%'"
				+ "	AND MEMBER_ISNEW LIKE '%' || ? || '%'"
				+ "	AND MEMBER_HAVESKILL LIKE '%' || ? || '%'";
			try {
				pstmt=conn.prepareStatement(sql);
				int idx=1;
				pstmt.setInt(idx++, cri.getPage());
				pstmt.setInt(idx++, cri.getPageEnd());
				pstmt.setString(idx++, cri.getName());
				pstmt.setString(idx++, cri.getIsnew());
				pstmt.setString(idx++, cri.getHaveskill());
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
					vo.setJoin(rs.getString("MEMBER_JOIN").substring(0, 10));
					vo.setOut(rs.getString("MEMBER_OUT"));
					vo.setIsnew(rs.getString("MEMBER_ISNEW"));
					vo.setHaveskill(rs.getString("MEMBER_HAVESKILL"));
					vo.setProjecthistory(rs.getString("PROJECT_HISTORY"));
					vo.setIsexit(rs.getString("MEMBER_ISEXIT").charAt(0));
					list.add(vo);
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}finally {
				if(rs!=null){try {rs.close();} catch (Exception e2) {}}
				if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
			}
		return list;
	}
	//Employee Get List Method
		public List<Employee> list(Connection conn)throws Exception{
			List<Employee> list = new ArrayList<>();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="SELECT * "
					+"		FROM "
					+"		(SELECT ROWNUM AS R,"
					+"			MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
					+"			MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
					+"			MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,"
					+"			PROJECT_HISTORY,  MEMBER_HAVESKILL, MEMBER_ISEXIT "
					+"			FROM "
					+"				(SELECT MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
					+"					MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
					+"					MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW," 
					+"					(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.MEMBER_NO=EMPLOYEE.MEMBER_NO) "
					+"					AS PROJECT_HISTORY, MEMBER_HAVESKILL, MEMBER_ISEXIT "
					+"				FROM "
					+"					EMPLOYEE "
					+"					ORDER BY MEMBER_NAME ASC)"
					+"		)"
					+ "		WHERE R >=1 "
					+ "		AND R <= 5"
					+ "		AND MEMBER_NO NOT IN(SELECT MEMBER_NO FROM PROJECT_JOIN)";
				try {
					pstmt=conn.prepareStatement(sql);
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
						vo.setJoin(rs.getString("MEMBER_JOIN").substring(0, 10));
						vo.setOut(rs.getString("MEMBER_OUT"));
						vo.setIsnew(rs.getString("MEMBER_ISNEW"));
						vo.setHaveskill(rs.getString("MEMBER_HAVESKILL"));
						vo.setProjecthistory(rs.getString("PROJECT_HISTORY"));
						vo.setIsexit(rs.getString("MEMBER_ISEXIT").charAt(0));
						vo.setRowNum(rs.getInt("R"));
						list.add(vo);
					}
				} catch (Exception e) {
					e.printStackTrace();
					throw e;
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
			String sql="INSERT INTO "
					+ "		EMPLOYEE("
					+ "					MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER, MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
					+ "					MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW, MEMBER_HAVESKILL, MEMBER_ISEXIT, MEMBER_POSITION"
					+ "				) "
					+ "		VALUES("
					+ "				(SELECT NVL(MAX(MEMBER_NO),0)+1 FROM EMPLOYEE), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?"
					+ "				)";
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
	public Employee read(Connection conn, int member_no){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Employee employee = null;
		try {
			employee = new Employee();
			String sql="SELECT "
					+ "		MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER, MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL, "
					+ "		MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW, MEMBER_HAVESKILL, MEMBER_ISEXIT, MEMBER_POSITION "
					+ "		FROM "
					+ "		EMPLOYEE "
					+ "			WHERE "
					+ "				MEMBER_NO = ? "
					+ "			AND MEMBER_ISEXIT != 'Y'";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, member_no);
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
	
	public int update(Connection conn, Employee employee)throws Exception{
		int success=0;
		PreparedStatement pstmt=null;
		
		try {
			String sql="UPDATE "
					+ "	EMPLOYEE SET "
					+ "		MEMBER_NAME=?, MEMBER_COMPANY=?, MEMBER_IDNUMBER=?, MEMBER_ZIPCODE=?,"
					+ "		MEMBER_ADDRESS=?, MEMBER_ADDRESS_DETAIL=?, MEMBER_RANK=?, MEMBER_JOIN=?,"
					+ "		MEMBER_OUT=?, MEMBER_ISNEW=?, MEMBER_HAVESKILL=?, MEMBER_POSITION=?"
					+ "	WHERE MEMBER_NO=?";
			pstmt=conn.prepareStatement(sql);
			int idx=1;
			pstmt.setString(idx++, employee.getName());
			pstmt.setString(idx++, employee.getCompany());
			pstmt.setString(idx++, employee.getIdnumber1()+"-"+employee.getIdnumber2());
			pstmt.setString(idx++, employee.getZipcode());
			pstmt.setString(idx++, employee.getAddress());
			pstmt.setString(idx++, employee.getAddress_detail());
			pstmt.setString(idx++, employee.getRank());
			pstmt.setString(idx++, employee.getJoin().substring(0, 10));
			pstmt.setString(idx++, employee.getOut());
			pstmt.setString(idx++, employee.getIsnew());
			pstmt.setString(idx++, employee.getHaveskill());
			pstmt.setString(idx++, employee.getPosition());
			pstmt.setInt(idx++, employee.getNo());
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return success;
	}
	
	public int deleteUpdate(Connection conn, int no)throws Exception{
		int success=0;
		PreparedStatement pstmt=null;
		String sql="UPDATE "
				+ "		EMPLOYEE SET "
				+ "			MEMBER_ISEXIT='Y' "
				+ "		WHERE "
				+ "			MEMBER_NO=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			success=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return success;
	}
	
	public List<Employee> showMoreEmplyee(Connection conn,int startNum ,int endNum)throws Exception{
		List<Employee> list = new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT "
				+ "		R, MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
				+"		MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
				+"		MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,"
				+"		PROJECT_HISTORY,  MEMBER_HAVESKILL, MEMBER_ISEXIT "
				+"		FROM "
				+"		(SELECT ROWNUM AS R,"
				+"			MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
				+"			MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
				+"			MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,"
				+"			PROJECT_HISTORY,  MEMBER_HAVESKILL, MEMBER_ISEXIT "
				+"			FROM "
				+"				(SELECT MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,"
				+"					MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,"
				+"					MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW," 
				+"					(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.MEMBER_NO=EMPLOYEE.MEMBER_NO) "
				+ "					AS PROJECT_HISTORY, MEMBER_HAVESKILL, MEMBER_ISEXIT "
				+"				FROM "
				+ "					EMPLOYEE "
				+ "					ORDER BY MEMBER_NAME ASC)"
				+ "		)"
				+ "	WHERE R >= ? "
				+ "	AND R <= ? "
				+ "	AND MEMBER_ISEXIT = 'N' ";
		try {
			pstmt=conn.prepareStatement(sql);
			int idx=1;
			pstmt.setInt(idx++, startNum);
			pstmt.setInt(idx++, endNum);
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
				vo.setJoin(rs.getString("MEMBER_JOIN").substring(0, 10));
				vo.setOut(rs.getString("MEMBER_OUT"));
				vo.setIsnew(rs.getString("MEMBER_ISNEW"));
				vo.setHaveskill(rs.getString("MEMBER_HAVESKILL"));
				vo.setProjecthistory(rs.getString("PROJECT_HISTORY"));
				vo.setIsexit(rs.getString("MEMBER_ISEXIT").charAt(0));
				vo.setRowNum(rs.getInt("R"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		return list;
	}
	
	public List<Employee> readProjectJoin(Connection conn, int projectNum)throws Exception{
		List<Employee> list = new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT "
				+ "			EMPLOYEE.MEMBER_NO AS MEMBER_NO, EMPLOYEE.MEMBER_NAME AS MEMBER_NAME, "
				+ "			EMPLOYEE.MEMBER_HAVESKILL AS MEMBER_HAVESKILL, EMPLOYEE.MEMBER_POSITION AS MEMBER_POSITION,"
				+ "			EMPLOYEE.MEMBER_ISNEW AS MEMBER_ISNEW "
				+ "		FROM "
				+ "			EMPLOYEE, PROJECT_JOIN "
				+ "		WHERE "
				+ "			EMPLOYEE.MEMBER_NO=PROJECT_JOIN.MEMBER_NO "
				+ "		AND "
				+ "			PROJECT_JOIN.PROJECT_NO=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, projectNum);
			rs=pstmt.executeQuery();
			while(rs.next()){
				Employee employee = new Employee();
				employee.setNo(rs.getInt("MEMBER_NO"));
				employee.setName(rs.getString("MEMBER_NAME"));
				employee.setHaveskill(rs.getString("MEMBER_HAVESKILL"));
				employee.setPosition(rs.getString("MEMBER_POSITION"));
				employee.setIsnew(rs.getString("MEMBER_ISNEW"));
				list.add(employee);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(pstmt!=null){try {pstmt.close();} catch (Exception e2) {}}
		}
		
		return list;
	}
}
