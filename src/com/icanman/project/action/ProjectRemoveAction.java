package com.icanman.project.action;

import com.icanman.project.service.ProjectService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class ProjectRemoveAction implements Action{
	private int page;
	private int perPageNum;
	private SearchCriteria cri;
	private int no;
	private int pno;
	@Override
	public String execute() throws Exception {
		ProjectService projectService = new ProjectService();
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		System.out.println("액션 클래스 파라메터 no : "+no+", pno : "+pno);
		if(projectService.delete(no) < 0){
			return "error";
		}else{
			return "success";
		}
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
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
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	
}
