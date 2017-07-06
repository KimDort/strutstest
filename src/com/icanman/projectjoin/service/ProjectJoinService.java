package com.icanman.projectjoin.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.icanman.employee.model.Validate;
import com.icanman.projectjoin.dao.ProjectJoinDAO;
import com.icanman.projectjoin.model.ProjectJoin;
import com.icanman.tools.BaseValidate;
import com.icanman.tools.DBConn;
import com.icanman.tools.SearchCriteria;
import com.icanman.tools.Tools;

public class ProjectJoinService {
	
	public List<ProjectJoin> read(int projectNumber)throws Exception{
		DBConn dbConn=new DBConn();
		Connection conn= dbConn.getConnection();
		List<ProjectJoin> list = new ArrayList<>();
		ProjectJoinDAO dao = new ProjectJoinDAO();
		try {
			list=dao.read(conn, projectNumber);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {if(conn!=null){conn.close();}}
		
		return list;
	}
	
	public List<ProjectJoin> list(SearchCriteria cri)throws SQLException{
		DBConn dbConn=new DBConn();
		Connection conn= dbConn.getConnection();
		List<ProjectJoin> list = new ArrayList<>();
		ProjectJoinDAO dao = new ProjectJoinDAO();
		try {
			list=dao.list(conn, cri);
			
			for(int idx=0;idx<list.size()-1;idx++){
				for(int jdx=1; jdx< list.size();jdx++){
					if(list.get(idx).getName().equals(list.get(jdx).getName())){
						list.get(jdx).setName("");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			if(conn!=null){conn.close();}
		}
		return list;
	}
	public Validate totalProjectJoinValidate(List<ProjectJoin> list)throws Exception{
		Validate val=null;
		try {
			val = new Validate();
			val.setTrue(true);
			for(int idx=0;idx<list.size();idx++){
				if(!checkProjectJoinNull(list).getTrue()){
					val=checkProjectJoinNull(list);
					return val;
				}
				if(!checkStartEndSize(list).getTrue()){
					val=checkStartEndSize(list);
					return val;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return val;
	}
	public Validate checkProjectJoinNull(List<ProjectJoin> list)throws Exception{
		Validate val = null;
		BaseValidate baseValidate= new BaseValidate();
	
		try {
			val=new Validate();
			val.setTrue(true);
			for(int idx=0;idx<list.size();idx++){
				if(baseValidate.checkNull(list.get(idx).getPosition())){
					val.setFocus("position");
					val.setIndex(list.get(idx).getMno());
					val.setMessage("역할 및 직무를 입력해 주십시오");
					val.setTrue(false);
					return val;
				}
				if(baseValidate.checkNull(list.get(idx).getJoin())){
					val.setFocus("join");
					val.setIndex(list.get(idx).getMno());
					val.setMessage("시작일을 입력해 주십시오.");
					val.setTrue(false);
					return val;
				}
				if(baseValidate.checkNull(list.get(idx).getOut())){
					val.setFocus("out");
					val.setIndex(list.get(idx).getMno());
					val.setMessage("시작일을 입력해 주십시오.");
					val.setTrue(false);
					return val;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return val;
	}
	
	public Validate checkStartEndSize(List<ProjectJoin> list)throws Exception{
		Validate val=null;
		Tools tool=new Tools();
		try {
			val=new Validate();
			val.setTrue(true);
			for(int idx=0;idx<list.size();idx++){
				Date startDate = tool.setParseDate(list.get(idx).getJoin());
				Date endDate = tool.setParseDate(list.get(idx).getOut());
				if(startDate.getTime() > endDate.getTime()){
					val.setFocus("join");
					val.setIndex(list.get(idx).getMno());
					val.setMessage("시작일이 종료일보다 후 일이 될 수 없습니다.");
					val.setTrue(false);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return val;
	}
	
	public int register(List<ProjectJoin> list)throws SQLException{
		int success=0;
		DBConn dbConn=new DBConn();
		Connection conn= dbConn.getConnection();
		ProjectJoinDAO dao = new ProjectJoinDAO();
		try {
			success=dao.register(conn, list);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return success;
	}
}
