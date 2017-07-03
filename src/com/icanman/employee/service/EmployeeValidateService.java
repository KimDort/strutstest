package com.icanman.employee.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.icanman.employee.model.Career;
import com.icanman.employee.model.Employee;
import com.icanman.employee.model.License;
import com.icanman.employee.model.Validate;
import com.icanman.tools.BaseValidate;
import com.icanman.tools.Tools;

public class EmployeeValidateService implements Cloneable {
	private BaseValidate baseValidate = new BaseValidate();
	private Tools tool = new Tools();
	public Validate totalValidateMethod(Employee employee, Career career, License license)throws Exception{
		EmployeeService service= new EmployeeService();
		Validate validate = new Validate();	
		validate.setTrue(true);
		
		try {
			//사원 기본 정보 널 체크
			if(!checkNullEmplyee(employee).getTrue()){
				validate=checkNullEmplyee(employee);
				return validate;
			}
			//사원 입사일이 현재일 보다 이 후인지 체크
			if(!checkNowDateEmployee(employee).getTrue()){
				validate=checkNowDateEmployee(employee);
				return validate;
			}
			//생년월일 자리 수 체크
			if(!checkBirthDayEmployee(employee).getTrue()){
				validate=checkBirthDayEmployee(employee);
				return validate;
			}
			//주민번호 자리 수 체크
			if(!checkIdnumberEmployee(employee).getTrue()){
				validate=checkIdnumberEmployee(employee);
				return validate;
			}
			//생년월일, 주민번호 숫자만 입력
			if(!checkNumericEmployee(employee).getTrue()){
				validate=checkNumericEmployee(employee);
				return validate;
			}
			//경력 선택 하였으나 값이 없을 시 체크
			if("Career".equals(employee.getIsnew()) && career==null){
				validate.setMessage("경력 하나 이상은 입력하셔야 합니다.");
				validate.setTrue(false);
				return validate;
			}
			
			//경력 입력 시 유효성 검사
			if(career != null){
				//유효성 검사를 위한 리스트 생성
				List<Career> careerList = new ArrayList<>();
				careerList=service.createList(career);
				//경력 널 체크
				if(!checkNullCareer(careerList).getTrue()){
					validate=checkNullCareer(careerList);
					return validate;
				}
				//경력 시작일, 종료일이 현재 일 보다 이 후 인지 체크
				if(!checkNowDateCareer(careerList).getTrue()){
					validate=checkNowDateCareer(careerList);
					return validate;
				}
				//경력 시작일, 종료일이 입사일 보다 이 후 인지 체크
				if(!checkJoinDateCareer(employee, careerList).getTrue()){
					validate=checkJoinDateCareer(employee, careerList);
					return validate;
				}
				//경력 중복일 체크
				if(!checkDuplicateDateCareer(careerList).getTrue()){
					validate=checkDuplicateDateCareer(careerList);
					return validate;
				}
			}
			
			//자격증 값이 있는지 체크
			if(license != null){
				//유효성 검사를 위한 리트스 생성
				List<License> licenseList = new ArrayList<>();
				licenseList=service.createList(license);
				//자격증 널 체크
				if(!checkNullLicense(licenseList).getTrue()){
					validate=checkNullLicense(licenseList);
					return validate;
				}
				//자격증 취득일이 현재일보다 이후인지 체크
				if(!checkNowDateLicense(licenseList).getTrue()){
					validate=checkNowDateLicense(licenseList);
					return validate;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	public Validate checkNullEmplyee(Employee employee)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			if(baseValidate.checkNull(employee.getName())){
				validate.setMessage("이름을 입력해 주십시오.");
				validate.setFocus("employee.name");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getCompany())){
				validate.setMessage("소속회사를 입력해 주십시오.");
				validate.setFocus("employee.company");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getRank())){
				validate.setMessage("직급을 선택해 주십시오.");
				validate.setFocus("employee.rank");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getPosition())){
				validate.setMessage("역활 및 직무를 입력해주십시오.");
				validate.setFocus("employee.position");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getJoin())){
				validate.setMessage("입사일을 선택해 주십시오.");
				validate.setFocus("employee.join");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getIsnew())){
				validate.setMessage("신입 & 경력을 선택해 주십시오.");
				validate.setFocus("employee.isnew");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getHaveskill())){
				validate.setMessage("스킬은 하나 이상 입력하셔야 합니다.");
				validate.setFocus("employee.haveskill");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getIdnumber1())){
				validate.setMessage("생년월일을 입력해 주십시오.");
				validate.setFocus("employee.idnumber1");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getIdnumber2())){
				validate.setMessage("주민번호를 입력해 주십시오.");
				validate.setFocus("employee.idnumber2");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getZipcode()) ||
					baseValidate.checkNull(employee.getAddress())){
				validate.setMessage("주소를 입력해 주십시오.");
				validate.setFocus("employee.address");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
			if(baseValidate.checkNull(employee.getAddress_detail())){
				validate.setMessage("상세주소를 입력해 주십시오.");
				validate.setFocus("employee.address_detail");
				validate.setIndex(0);
				validate.setTrue(false);
				return validate;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	
	public Validate checkNullCareer(List<Career> career)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			for(int idx=0;idx<career.size();idx++){
				if(baseValidate.checkNull(career.get(idx).getPeriod_start())){
					validate.setMessage("경력 시작일을 입력해 주십시오.");
					validate.setFocus("career.period_start");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
				if(baseValidate.checkNull(career.get(idx).getPeriod_end())){
					validate.setMessage("경력 종료일을 입력해 주십시오.");
					validate.setFocus("career.period_end");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
				if(baseValidate.checkNull(career.get(idx).getPeriod_company())){
					validate.setMessage("경력 회사를 입력해 주십시오.");
					validate.setFocus("career.period_company");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
				if(baseValidate.checkNull(career.get(idx).getPeriod_rank())){
					validate.setMessage("경력 직급을 입력해 주십시오.");
					validate.setFocus("career.period_rank");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
				if(baseValidate.checkNull(career.get(idx).getPeriod_position())){
					validate.setMessage("경력 직무 및 역할을 입력해 주십시오.");
					validate.setFocus("career.period_position");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	
	public Validate checkNullLicense(List<License> license)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			for(int idx=0;idx<license.size();idx++){
				if(baseValidate.checkNull(license.get(idx).getLicense_name())){
					validate.setMessage("자격증 이름을 입력해 주십시오.");
					validate.setFocus("license.license_name");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
				if(baseValidate.checkNull(license.get(idx).getLicense_level())){
					validate.setMessage("자격증 등급을 입력해 주십시오.");
					validate.setFocus("license.license_level");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
				if(baseValidate.checkNull(license.get(idx).getLicense_date())){
					validate.setMessage("자격증 취득일을 선택해 주십시오.");
					validate.setFocus("license.license_date");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
				if(baseValidate.checkNull(license.get(idx).getLicense_publisher())){
					validate.setMessage("자격증 발행처를 입력해 주십시오.");
					validate.setFocus("license.license_publisher");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return validate;
	}
	public Validate checkNowDateEmployee(Employee employee)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			if(!checkNowDate(employee.getJoin())){
				validate.setMessage("현재일보다 이전의 날짜를 선택해주십시오.");
				validate.setFocus("employee.join");
				validate.setTrue(false);
				return validate;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	public Validate checkNowDateCareer(List<Career> career)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			for(int idx=0;idx<career.size();idx++){
				if(!checkNowDate(career.get(idx).getPeriod_start())){
					validate.setMessage("현재일보다 이전의 날짜를 선택해주십시오.");
					validate.setFocus("career.period_start");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
				if(!checkNowDate(career.get(idx).getPeriod_end())){
					validate.setMessage("현재일보다 이전의 날짜를 선택해주십시오.");
					validate.setFocus("career.period_end");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return validate;
	}
	public Validate checkNowDateLicense(List<License> license)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			for(int idx=0;idx<license.size();idx++){
				if(!checkNowDate(license.get(idx).getLicense_date())){
					validate.setMessage("현재일보다 이전의 날짜를 선택해주십시오.");
					validate.setFocus("license.license_date");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return validate;
	}
	public boolean checkNowDate(Object obj)throws Exception{
		Date nowDate = tool.getNowDate();
		Date inputDate = tool.setParseDate(obj.toString());
		try {
			if(nowDate.getTime() < inputDate.getTime()){
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return true;
	}
	public Validate checkStartEndDateCareer(List<Career> list)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			for(int idx=0;idx<list.size();idx++){
				Date startDate = tool.setParseDate(list.get(idx).getPeriod_start());
				Date endDate = tool.setParseDate(list.get(idx).getPeriod_end());
				if(startDate.getTime() > endDate.getTime()){
					validate.setMessage("시작일이 종료일 보다 이 후 일 수 없습니다.");
					validate.setFocus("career.period_start");
					validate.setIndex(idx);
					validate.setTrue(false);
					return validate;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return validate;
	}
	public Validate checkJoinDateCareer(Employee employee, List<Career> list)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			for(int idx=0;idx<list.size();idx++){
				Date joinDate = tool.setParseDate(employee.getJoin());
				Date startDate = tool.setParseDate(list.get(idx).getPeriod_start());
				Date endDate  = tool.setParseDate(list.get(idx).getPeriod_end());
				
				if(joinDate.getTime() < startDate.getTime()){
					validate.setMessage("입사일 보다 이전 날짜를 선택해주십시오.");
					validate.setIndex(idx);
					validate.setFocus("career.period_start");
					validate.setTrue(false);
					return validate;
				}
				if(joinDate.getTime() < endDate.getTime()){
					validate.setMessage("입사일 보다 이전 날짜를 선택해주십시오.");
					validate.setIndex(idx);
					validate.setFocus("career.period_end");
					validate.setTrue(false);
					return validate;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return validate;
	}
	public Validate checkNumericEmployee(Employee employee)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			if(!baseValidate.checkIntegerType(employee.getIdnumber1())){
				validate.setMessage("숫자만 입력해 주십시오.");
				validate.setFocus("employee.idnumber1");
				validate.setTrue(false);
				return validate;
			}
			if(!baseValidate.checkIntegerType(employee.getIdnumber2())){
				validate.setMessage("숫자만 입력해 주십시오.");
				validate.setFocus("employee.idnumber2");
				validate.setTrue(false);
				return validate;
				}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	public Validate checkBirthDayEmployee(Employee employee)throws Exception{
		Validate validate=new Validate();
		validate.setTrue(true);
		try {
			if(6 > employee.getIdnumber1().length()){
				validate.setMessage("생년월일 6자리를 입력해 주십시오.");
				validate.setFocus("employee.idnumber1");
				validate.setTrue(false);
				return validate;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	public Validate checkIdnumberEmployee(Employee employee)throws Exception{
		Validate validate= new Validate();
		validate.setTrue(true);
		try {
			if( 7 > employee.getIdnumber2().length()){
				validate.setMessage("주민번호 7 자리를 입력해 주십시오.");
				validate.setFocus("employee.idnumber2");
				validate.setTrue(false);
				return validate;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return validate;
	}
	public Validate checkDuplicateDateCareer(List<Career> list)throws Exception{
		Validate validate = new Validate();
		validate.setTrue(true);
		try {
			for(int idx=0; idx<list.size()-1;idx++){
				Date startIdx=tool.setParseDate(list.get(idx).getPeriod_start());
				Date endIdx=tool.setParseDate(list.get(idx).getPeriod_end());
				for(int jdx=1; jdx<list.size();jdx++){
					Date startJdx=tool.setParseDate(list.get(jdx).getPeriod_start());
					Date endJdx=tool.setParseDate(list.get(jdx).getPeriod_end());
					
					if(startIdx.getTime() <= startJdx.getTime() && startJdx.getTime() <= endIdx.getTime()){
						validate.setMessage("중복된 경력 사항이 있습니다.");
						validate.setFocus("career.period_start");
						validate.setIndex(jdx);
						validate.setTrue(false);
						return validate;
					}
					
					if(startIdx.getTime() <= endJdx.getTime() && endJdx.getTime() <= endIdx.getTime()){
						validate.setMessage("중복된 경력 사항이 있습니다.");
						validate.setFocus("career.period_end");
						validate.setIndex(jdx);
						validate.setTrue(false);
						return validate;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	/*public Validate employeeNullCheck(Employee employee) throws Exception {
		Validate validate=null;

		try {
			Employee createEmployee = new Employee();
			createEmployee = employee;
			Class<?> classEmploye = createEmployee.getClass();
			
			for (int jdx = 0; jdx < classEmploye.getMethods().length; jdx++) {
				if ("get".equals(classEmploye.getMethods()[jdx].getName().substring(0, 3))) {
					if (!"getClass".equals(classEmploye.getMethods()[jdx].getName())) {
						Method method = classEmploye.getMethod(classEmploye.getMethods()[jdx].getName());
						//System.out.println("Method Name("+method.getName()+"), Method Value("+method.invoke(createEmployee)+")");
						if(baseValidate.checkNull(method.invoke(createEmployee))){
							validate=CreateMessage(classEmploye.getSimpleName(),method.getName(), baseValidate.checkNull(method.invoke(createEmployee)),0);
							break;
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	public Validate CreateMessage(String className,String name, boolean nullCheck, int index)throws Exception{
		Validate validate = new Validate();
		try {
			if(nullCheck){
				validate.setMessage("Please "+name.replaceAll("get", "")+" Write  Or Select");
				validate.setFocus(className.toLowerCase()+"."+name.replaceAll("get", "").toLowerCase());
				validate.setIndex(index);
				validate.setTrue(false);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw e;
		}
		return validate;
	}
	public Validate careerNullCheck(List<Career> list) throws Exception {
		Validate validate=null;

		try {
			Career createCareer = new Career();
			for(int idx=0;idx<list.size();idx++){
				createCareer=list.get(idx);
				Class<?> classCareer = createCareer.getClass(); 
				for(int jdx=0;jdx<classCareer.getMethods().length;jdx++){
					if("get".equals(classCareer.getMethods()[jdx].getName().substring(0,3))){
						if(!"getClass".equals(classCareer.getMethods()[jdx].getName()) &&
								!"getPeriod_no".equals(classCareer.getMethods()[jdx].getName())&&
								!"getMember_no".equals(classCareer.getMethods()[jdx].getName())){
							Method method = classCareer.getMethod(classCareer.getMethods()[jdx].getName());
							if(baseValidate.checkNull(method.invoke(createCareer))){
								validate=CreateMessage(classCareer.getSimpleName(),method.getName(), baseValidate.checkNull(method.invoke(createCareer)),idx);
								break;
							}
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw e;
		}
		return validate;
	}*/
}
