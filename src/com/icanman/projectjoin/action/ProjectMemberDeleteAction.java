package com.icanman.projectjoin.action;

import com.icanman.projectjoin.service.ProjectJoinService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectMemberDeleteAction implements Action{
	private int memberNum;
	private int page;
	private int perPageNum;
	private SearchCriteria cri;
	private String location;
	
	@Override
	public String execute() throws Exception {
		ProjectJoinService projectJoinService = new ProjectJoinService();
		cri=new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		cri.setLocation(location);
		String result=null;
		if(projectJoinService.deleteMember(memberNum) < 0){
			result="error";
		}else{
			result="success";
		}
		return result;
	}
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
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
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
}
