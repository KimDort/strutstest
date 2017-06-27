package com.icanman.employee.service;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.icanman.employee.dao.CareerDAO;
import com.icanman.employee.dao.EmployeeDAO;
import com.icanman.employee.dao.LicenseDAO;
import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.License;
import com.icanman.employee.model.Validate;
import com.icanman.tools.DBConn;
import com.icanman.tools.SearchCriteria;
import com.icanman.tools.Tools;
//Employee Service Class
public class EmployeeService{
	private Tools tool= new Tools();
	
	public List<Validate> totalValidation(Employee employee, Career career, License license){
		boolean result=false;
		//사원, 경력, 자격증 널 값 체크
		List<Validate> nullEmployeeCheck = new ArrayList<>();
		List<Validate> nullCareerCheck = new ArrayList<>();
		List<Validate> nullLicenseCheck = new ArrayList<>();
		//사원, 경력, 자격증 현재 일 보다 후일 인지 체크
		List<Validate> nowDateEmployeeCheck = new ArrayList<>();
		List<Validate> nowDateCareerCheck = new ArrayList<>();
		List<Validate> nowDateLicenseCheck = new ArrayList<>();
		//경력, 자격증 입사일 보다 후일 인지 체크
		List<Validate> joinDateCareerCheck = new ArrayList<>();
		List<Validate> joinDateLicenseCheck = new ArrayList<>();
		//종료일이 시작일 보다 큰지 체크
		List<Validate> startEndCheck = new ArrayList<>();
		//경력 중복 체크
		List<Validate> duplicateCareerCheck = new ArrayList<>();
		//false 일 때 리턴 시켜 줄 리스트
		List<Validate> returnList= new ArrayList<>();
		
		//경력, 자격증 리스트 형태 만들기
		List<Career> careerList = new ArrayList<>();
		List<License> licenseList = new ArrayList<>();
		if(career!=null){
			careerList = createList(career);
		}else if(license!=null){
			licenseList = createList(license);
		}	
		//널 값 체크 리턴 받기
		nullEmployeeCheck=checkEmployee(employee);
		nullCareerCheck=checkCareer(employee, careerList);
		nullLicenseCheck=checkLicense(licenseList);
		//현재 일 비교 값 리턴 받기
		nowDateEmployeeCheck = checkEmployeeNowDate(employee);
		nowDateCareerCheck = checkCareerNowDate(careerList);
		nowDateLicenseCheck = checkLicenseNowDate(licenseList);
		//입사일 기준 체크하기
		joinDateCareerCheck=checkCareerJoinDate(employee, careerList);
		joinDateLicenseCheck=checkLicenseJoinDate(employee, licenseList);
		//경력 시작일 종료일 사이즈 체크
		startEndCheck= checkStartEndDate(careerList);
		//경력 중복 체크
		duplicateCareerCheck=checkDuplicatedDate(careerList);
		//체크 하기
		if(!nullEmployeeCheck.get(0).isTrue()){
			returnList=nullEmployeeCheck;
		}else if(!nullCareerCheck.get(0).isTrue()){
			returnList=nullCareerCheck;
		}else if(!nullLicenseCheck.get(0).isTrue()){
			returnList=nullLicenseCheck;
			//널 값 체크 종료
		}else if(!nowDateEmployeeCheck.get(0).isTrue()){
			returnList=nowDateEmployeeCheck;
		}else if(!nowDateCareerCheck.get(0).isTrue()){
			returnList=nowDateCareerCheck;
		}else if(!nowDateLicenseCheck.get(0).isTrue()){
			returnList=nowDateLicenseCheck;
			//현재 일 보다 큰지 체크 종료
		}else if(!joinDateCareerCheck.get(0).isTrue()){
			returnList=nowDateCareerCheck;
		}else if(!joinDateLicenseCheck.get(0).isTrue()){
			returnList=joinDateLicenseCheck;
			//입사일 보다 이후인지 체크 종료
		}else if(!startEndCheck.get(0).isTrue()){
			returnList=startEndCheck;
			//종료일 시작일 사이즈 체크 종료
		}else if(!duplicateCareerCheck.get(0).isTrue()){
			returnList=duplicateCareerCheck;
			//경력 중복 체크 종료
		}else{
			returnList.get(0).setTrue(true);
		}
		return returnList;
	}
	public List<Employee> list(SearchCriteria cri){
		DBConn dbConn=new DBConn();
		List<Employee> list=new ArrayList<>();
		EmployeeDAO dao=new EmployeeDAO();	
		Connection conn =null;
		try {
			conn = dbConn.getConnection();
			list=dao.list(conn, cri);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null){try {conn.close();} catch (Exception e2) {}}
		}
		return list;
	}
	
	public int register(Employee employee, Career career, License license){
		EmployeeDAO employeeDao = new EmployeeDAO();
		CareerDAO careerDao = new CareerDAO();
		LicenseDAO licenseDao = new LicenseDAO();
		DBConn dbConn=new DBConn();
		Connection conn=null;
		int success=0;
		int employeeSuccess=0;
		int careerSuccess=0;
		int licenseSuccess=0;
		
		List<Career> careerList = new ArrayList<>();
		List<License> licenseList = new ArrayList<>();
		try {		
			conn=dbConn.getConnection();
			conn.setAutoCommit(false);		
			
			employeeSuccess=employeeDao.register(conn, employee);
			
			if(career!=null){
				careerList=createList(career);
				careerSuccess=careerDao.register(conn, careerList);
			}else{
				careerSuccess=1;
			}
			if(license!=null){
				licenseList=createList(license);
				licenseSuccess=licenseDao.register(conn, licenseList);
			}else{
				licenseSuccess=1;
			}
			
			if(employeeSuccess > 0 && careerSuccess > 0 && licenseSuccess > 0){
				conn.commit();
				success=1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(conn!=null){try {conn.rollback();} catch (Exception e2) {}}
		}finally {
			if(conn!=null){try {conn.setAutoCommit(true);conn.close();} catch (Exception e2) {}}
		}

		return success;
	}
	public List<Career> createList(Career vo){
		List<Career> list = new ArrayList<>();
		String[] period_start = vo.getPeriod_start().replaceAll(" ", "").split(",");
		String[] period_end = vo.getPeriod_end().replaceAll(" ", "").split(",");
		String[] period_company = vo.getPeriod_company().replaceAll(" ", "").split(",");
		String[] period_position = vo.getPeriod_position().replaceAll(" ", "").split(",");
		String[] period_rank = vo.getPeriod_rank().replaceAll(" ", "").split(",");
	
		for(int idx=0; idx < period_start.length; idx++){
			Career career = new Career();
			career.setPeriod_start(period_start[idx]);
			career.setPeriod_end(period_end[idx]);
			career.setPeriod_company(period_company[idx]);
			career.setPeriod_rank(period_rank[idx]);
			career.setPeriod_position(period_position[idx]);
			list.add(career);
		}
		return list;
	}
	public List<License> createList(License vo){
		List<License> list = new ArrayList<>();
		String[] license_name=vo.getLicense_name().replaceAll(" ", "").split(",");
		String[] license_level=vo.getLicense_level().replaceAll(" ", "").split(",");
		String[] license_getdate=vo.getLicense_date().replaceAll(" ", "").split(",");
		String[] license_publisher=vo.getLicense_publisher().replaceAll(" ", "").split(",");
		for(int idx=0;idx<license_name.length;idx++){
			License license = new License();
			license.setLicense_name(license_name[idx]);
			license.setLicense_level(license_level[idx]);
			license.setLicense_date(license_getdate[idx]);
			license.setLicense_publisher(license_publisher[idx]);
			list.add(license);
		}
		return list;
	}
	//사원정보 체크
	public List<Validate> checkEmployee(Employee employee){
		String message ="";
		String focus="";
		boolean isTrue=false;
		List<Validate> list = new ArrayList<>();
		Validate val = new Validate();
		if(tool.checkNull(employee.getName())){
			message="이름을 입력해 주십시오.";
			focus="employee.name";
		}else if(tool.checkNull(employee.getCompany())){
			message="소속회사를 입력해 주십시오.";
			focus="employee.company";
		}else if(tool.checkNull(employee.getRank())){
			message="직급을 선택해 주십시오.";
			focus="employee.rank";
		}else if(tool.checkNull(employee.getPosition())){
			message="역할 및 직무를 입력해 주십시오.";
			focus="employee.position";
		}else if(tool.checkNull(employee.getJoin())){
			message="입사일을 선택해 주십시오.";
			focus="employee.join";
		}else if(tool.checkNull(employee.getIsnew())){
			message="경력 & 신입 중 선택해 주십시오.";
			focus="employee.isnew";
		}else if(tool.checkNull(employee.getHaveskill())){
			message="스킬은 하나 이상 입력하셔야 합니다.";
			focus="employee.haveskill";
		}else if(tool.checkNull(employee.getIdnumber1())){
			message="생년월일을 입력해 주십시오.";
			focus="employee.idnumber1";
		}else if(tool.checkNull(employee.getIdnumber2())){
			message="주민등록번호를 입력해 주십시오.";
			focus="employee.idnumber2";
		}else if(tool.checkNull(employee.getZipcode()) || tool.checkNull(employee.getAddress())){
			message="주소를 입력하셔야 합니다.";
			focus="employee.address";
		}else if(tool.checkNull(employee.getAddress_detail())){
			message="상세 주소를 입력해 주십시오.";
			focus="employee.address_detail";
		}else{
			isTrue=true;
		}
		
		val.setFocus(focus);
		val.setMessage(message);
		val.setTrue(isTrue);
		list.add(val);
		
		return list;
	}
	//경력 체크
	public List<Validate> checkCareer(Employee employee, List<Career> list){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		
		if("Career".equals(employee.getIsnew())){
			if(list.isEmpty() || list == null){
				message="경력 하나 이상은 입력 하셔야 합니다.";
				focus="";
				index=0;
			}else{
				//경력 리스트 널 값 검사
				for(int idx=0;idx<list.size();idx++){
					if(tool.checkNull(list.get(idx).getPeriod_start())){
						message="경력시작일을 입력하셔야 합니다.";
						focus="career.period_start";
						index=idx;
					}else if(tool.checkNull(list.get(idx).getPeriod_end())){
						message="경력종료일을 입력하셔야 합니다.";
						focus="career.period_end";
						index=idx;
					}else if(tool.checkNull(list.get(idx).getPeriod_company())){
						message="경력회사를 입력하셔야 합니다.";
						focus="career.period_company";
						index=idx;
					}else if(tool.checkNull(list.get(idx).getPeriod_rank())){
						message="직급을 입력하셔야 합니다.";
						focus="career.period_rank";
						index=idx;
					}else if(tool.checkNull(list.get(idx).getPeriod_company())){
						message="역할 및 직무를 입력하셔야 합니다.";
						focus="career.period_position";
						index=idx;
					}else{
						isTrue=true;
					}
				}
			}
		}else{
			isTrue=true;
		}
		
		val.setMessage(message);
		val.setFocus(focus);
		val.setIndex(index);
		val.setTrue(isTrue);
		valList.add(val);
		
		return valList;
	}
	//자격증 체크
	public List<Validate> checkLicense(List<License> list){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		
		//자격증 리스트 널 값 검사
		if (list != null) {
			for (int idx = 0; idx < list.size(); idx++) {
				if (tool.checkNull(list.get(idx).getLicense_name())) {
					message = "자격증 이름을 입력하셔야 합니다.";
					focus = "license.license_name";
					index = idx;
				} else if (tool.checkNull(list.get(idx).getLicense_level())) {
					message = "자격증 등급을 입력하셔야 합니다.";
					focus = "license.license_level";
					index = idx;
				} else if (tool.checkNull(list.get(idx).getLicense_date())) {
					message = "자격증 취득일을 입력하셔야 합니다.";
					focus = "license.license_date";
					index = idx;
				} else if (tool.checkNull(list.get(idx).getLicense_publisher())) {
					message = "자격증 발급처를 입력하셔야 합니다.";
					focus = "license.license_publisher";
					index = idx;
				} else {
					isTrue = true;
				}
			}
		}else{
			isTrue=true;
		}
		
		val.setFocus(focus);
		val.setMessage(message);
		val.setTrue(isTrue);
		val.setIndex(index);
		valList.add(val);
		return valList;
	}
	public boolean checkStringType(Object obj){
		boolean checkType=false;
		if(obj instanceof String){
			checkType=true;
		}
		return checkType;
	}
	
	//사원 Date 타입 비교 체크
	public List<Validate> checkEmployeeNowDate(Employee employee){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		
		if(!checkNowDate(employee.getJoin())){
			message="현재 날짜보다 후의 날은 선택 하실 수 없습니다.";
			focus="employee.join";
		}else{
			isTrue=true;
		}
		val.setMessage(message);
		val.setFocus(focus);
		val.setTrue(isTrue);
		val.setIndex(index);
		valList.add(val);
		
		return valList;
	}
	//경력 Date 타입 비교 체크
	public List<Validate> checkCareerNowDate(List<Career> list){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		
		for(int idx=0;idx<list.size();idx++){
			if(!checkNowDate(list.get(idx).getPeriod_start())){
				message="현재 날짜보다 후의 날은 선택 하실 수 없습니다.";
				focus="career.period_start";
				index=idx;
			}else if(!checkNowDate(list.get(idx).getPeriod_end())){
				message="현재 날짜보다 후의 날은 선택 하실 수 없습니다.";
				focus="career.period_end";
				index=idx;
			}else{
				isTrue=true;
			}
		}
		val.setMessage(message);
		val.setFocus(focus);
		val.setTrue(isTrue);
		val.setIndex(index);
		valList.add(val);
		
		return valList;
	}
	//자격증 Date 타입 비교 체크
	public List<Validate> checkLicenseNowDate(List<License> list){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		
		for(int idx=0;idx<list.size();idx++){
			if(!checkNowDate(list.get(idx).getLicense_date())){
				message="현재 날짜보다 후의 날은 선택 하실 수 없습니다.";
				focus="license.license_date";
				index=idx;
			}else{
				isTrue=true;
			}
		}
		val.setMessage(message);
		val.setFocus(focus);
		val.setTrue(isTrue);
		val.setIndex(index);
		valList.add(val);
		
		return valList;
	}
	//경력 Date 입사일 Date 비교 체크
	public List<Validate> checkCareerJoinDate(Employee employee, List<Career> list){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		
		for(int idx=0;idx<list.size();idx++){
			if(!checkJoinDate(employee.getJoin(),list.get(idx).getPeriod_start())){
				message="입사일보다 이후 날짜는 선택하실 수 없습니다.";
				focus="career.period_start";
				index=idx;
			}else if(!checkJoinDate(employee.getJoin(),list.get(idx).getPeriod_end())){
				message="입사일보다 이후 날짜는 선택하실 수 없습니다.";
				focus="career.period_end";
				index=idx;
			}else{
				isTrue=true;
			}
		}
		val.setMessage(message);
		val.setFocus(focus);
		val.setTrue(isTrue);
		val.setIndex(index);
		valList.add(val);
		
		return valList;
	}
	//자격증 Date 입사일 Date 비교 체크
	public List<Validate> checkLicenseJoinDate(Employee employee, List<License> list){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		
		for(int idx=0;idx<list.size();idx++){
			if(!checkJoinDate(employee.getJoin(),list.get(idx).getLicense_date())){
				message="입사일보다 이후 날짜는 선택하실 수 없습니다.";
				focus="license.license_date";
				index=idx;
			}else{
				isTrue=true;
			}
		}
		val.setMessage(message);
		val.setFocus(focus);
		val.setTrue(isTrue);
		val.setIndex(index);
		valList.add(val);
		
		return valList;
	}
	//현재 일 기준 체크
	public boolean checkNowDate(String getDate){
		boolean result=false;
		SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			Date nowDate= new Date();
			String now = formater.format(nowDate);
			Date nowDateFrm= formater.parse(now);
			Date date = formater.parse(getDate);
			if(nowDateFrm.getTime() > date.getTime()){
				result=true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}
	//입사일과 비교
	public boolean checkJoinDate(String getJoinDate, String putGetDate){
		boolean result=false;
		SimpleDateFormat formater= new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date joinDate = formater.parse(getJoinDate);
			Date putDate = formater.parse(putGetDate);
			
			if(joinDate.getTime() > putDate.getTime()){
				result=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	//종료일 시작일 보다 큰지 체크
	public List<Validate> checkStartEndDate(List<Career> list){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		SimpleDateFormat formater= new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			for(int idx=0;idx<list.size();idx++){
				Date startDate=formater.parse(list.get(idx).getPeriod_start());
				Date endDate=formater.parse(list.get(idx).getPeriod_end());
				
				if(startDate.getTime() <= endDate.getTime()){
					message="종료일이 시작일 보다 같거나 클 순 없습니다.";
					focus="career.period_end";
					index=idx;
				}else{
					isTrue=true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		val.setMessage(message);
		val.setFocus(focus);
		val.setTrue(isTrue);
		val.setIndex(index);
		valList.add(val);
		return valList;
	}
	
	//경력 중복 체크
	public List<Validate> checkDuplicatedDate(List<Career> list){
		String message="";
		String focus="";
		boolean isTrue=false;
		int index=0;
		
		Validate val = new Validate();
		List<Validate> valList = new ArrayList<>();
		
		SimpleDateFormat formater= new SimpleDateFormat("yyyy-MM-dd");
		try {
			for(int idx=0;idx<list.size();idx++){
				Date startIdxDate=formater.parse(list.get(idx).getPeriod_start());
				Date endIdxDate=formater.parse(list.get(idx).getPeriod_end());
				for(int jdx=1;jdx<list.size();jdx++){
					Date startJdxDate=formater.parse(list.get(jdx).getPeriod_start());
					Date endJdxDate=formater.parse(list.get(jdx).getPeriod_end());
					
					if((startIdxDate.getTime() <= startJdxDate.getTime()) &&
							(endIdxDate.getTime() >= startJdxDate.getTime())){
						message="중복된 경력 사항이 있습니다.";
						focus="career.period_start";
						index=jdx;
					}else if((startIdxDate.getTime() <= endJdxDate.getTime()) &&
							(endIdxDate.getTime() >= endJdxDate.getTime())){
						message="중복된 경력 사항이 있습니다.";
						focus="career.period_end";
						index=jdx;
					}else{
						isTrue=true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		val.setFocus(focus);
		val.setMessage(message);
		val.setTrue(isTrue);
		val.setIndex(index);
		valList.add(val);
		
		return valList;
	}
	
}
