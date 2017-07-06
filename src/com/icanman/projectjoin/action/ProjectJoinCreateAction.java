package com.icanman.projectjoin.action;

import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Validate;
import com.icanman.projectjoin.model.ProjectJoin;
import com.icanman.projectjoin.service.ProjectJoinService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectJoinCreateAction implements Action{
	private int page;
	private int perPageNum;
	private SearchCriteria cri;
	private int[] member_no;
	private String[] position;
	private String[] join;
	private String[] out;
	private int callMemberList;
	private String location;
	private Validate val;
	private int pno;
	@Override
	public String execute() throws Exception {
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		cri.setLocation(location);
		ProjectJoinService projectJoinService = new ProjectJoinService();
		
		String result=null;
		val=projectJoinService.totalProjectJoinValidate(createList());
		if(!val.getTrue()){
			result="input";
		}else{
			projectJoinService.register(createList());
			if("project".equals(location)){
				result ="projectSuccess";
			}
			if("projectjoin".equals(location)){
				result= "projectJoinSuccess";	
			}
		}
		return result;
	}
	
	public Validate getVal() {
		return val;
	}

	public void setVal(Validate val) {
		this.val = val;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getCallMemberList() {
		return callMemberList;
	}

	public void setCallMemberList(int callMemberList) {
		this.callMemberList = callMemberList;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}

	public SearchCriteria getCri() {
		return cri;
	}

	public void setCri(SearchCriteria cri) {
		this.cri = cri;
	}

	public int[] getMember_no() {
		return member_no;
	}

	public void setMember_no(int[] member_no) {
		this.member_no = member_no;
	}

	public String[] getPosition() {
		return position;
	}

	public void setPosition(String[] position) {
		this.position = position;
	}

	public String[] getJoin() {
		return join;
	}

	public void setJoin(String[] join) {
		this.join = join;
	}

	public String[] getOut() {
		return out;
	}

	public void setOut(String[] out) {
		this.out = out;
	}
	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public List<ProjectJoin> createList()throws Exception{
		List<ProjectJoin> list = new ArrayList<>();
		if(member_no!=null){
			try {
				for(int idx=0;idx<this.member_no.length;idx++){
					ProjectJoin projectJoin =new ProjectJoin();
					projectJoin.setPno(this.pno);
					projectJoin.setMno(this.member_no[idx]);
					projectJoin.setPosition(this.position[idx]);
					projectJoin.setJoin(this.join[idx]);
					projectJoin.setOut(this.out[idx]);
					list.add(projectJoin);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
}
