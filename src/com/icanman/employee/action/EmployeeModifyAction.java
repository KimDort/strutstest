package com.icanman.employee.action;

import java.util.ArrayList;
import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.License;
import com.icanman.employee.model.Validate;
import com.icanman.employee.service.EmployeeService;
import com.icanman.employee.service.EmployeeValidateService;
import com.icanman.tools.SearchCriteria;
import com.opensymphony.xwork2.Action;

public class EmployeeModifyAction implements Action{
	private int no;
	private String base_start;
	private String base_end;
	private String base_company;
	private String base_rank;
	private String base_position;
	private EmployeeService employeeService;
	private Employee employee;
	private Career career;
	private License license;
	private int page;
	private int perPageNum;
	private SearchCriteria cri;
	private Validate val;
	private List<Career> careerList;
	private List<License> licenseList;
	@Override
	public String execute() throws Exception {
		EmployeeValidateService vali = new EmployeeValidateService();
		EmployeeService employeeService = new EmployeeService();
		licenseList = new ArrayList<>();
		Career baseCareer= new Career();
		
		baseCareer.setPeriod_start(base_start);
		baseCareer.setPeriod_end(base_end);
		baseCareer.setPeriod_company(base_company);
		baseCareer.setPeriod_rank(base_rank);
		baseCareer.setPeriod_position(base_position);
		careerList = new ArrayList<>();
		
		cri = new SearchCriteria();
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		
		if(career==null){
			careerList.add(0, baseCareer);
		}	
		//요청 파라메터 있을 시 리스트 형태로 변환
		if(career!=null){		
			careerList=employeeService.createList(career);
			careerList.add(0, baseCareer);
		}
		
		if(license!=null){
			licenseList=employeeService.createList(license);
		}
		
		val=vali.totalValidateMethod(employee, career, license);
		if(val.getTrue()){
			employee.setNo(no);
			employeeService.updateEmployee(employee, career, license);
			return "success";
		}else{
			return "input";
		}
	}
	
	public List<Career> getCareerList() {
		return careerList;
	}

	public void setCareerList(List<Career> careerList) {
		this.careerList = careerList;
	}

	public List<License> getLicenseList() {
		return licenseList;
	}

	public void setLicenseList(List<License> licenseList) {
		this.licenseList = licenseList;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public EmployeeService getEmployeeService() {
		return employeeService;
	}

	public void setEmployeeService(EmployeeService employeeService) {
		this.employeeService = employeeService;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Career getCareer() {
		return career;
	}

	public void setCareer(Career career) {
		this.career = career;
	}

	public License getLicense() {
		return license;
	}

	public void setLicense(License license) {
		this.license = license;
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

	public Validate getVal() {
		return val;
	}

	public void setVal(Validate val) {
		this.val = val;
	}

	public String getBase_start() {
		return base_start;
	}

	public void setBase_start(String base_start) {
		this.base_start = base_start;
	}

	public String getBase_end() {
		return base_end;
	}

	public void setBase_end(String base_end) {
		this.base_end = base_end;
	}

	public String getBase_company() {
		return base_company;
	}

	public void setBase_company(String base_company) {
		this.base_company = base_company;
	}

	public String getBase_rank() {
		return base_rank;
	}

	public void setBase_rank(String base_rank) {
		this.base_rank = base_rank;
	}

	public String getBase_position() {
		return base_position;
	}

	public void setBase_position(String base_position) {
		this.base_position = base_position;
	}
	
}
