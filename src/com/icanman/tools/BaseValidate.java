package com.icanman.tools;

public class BaseValidate {
	public boolean checkStringType(Object obj){
		boolean checkType=false;
		if(obj instanceof String){
			checkType=true;
		}
		return checkType;
	}
	//숫자 타입인지
	public boolean checkIntegerType(Object obj){
		boolean checkType=false;
		String input=String.valueOf(obj);
		char charInput;
		for(int idx=0;idx<input.length();idx++){
			charInput=input.charAt(idx);
			if(charInput >= 0x30 && charInput <= 0x39){
				return true;
			}
		}
		return checkType;
	}
	
	//널 값 체크
	public boolean checkNull(Object obj){
		boolean nullCheck=false;
		
		if(obj instanceof String){
			String str=String.valueOf(obj);
			str=str.trim();
			if(str.isEmpty() || "".equals(str) 
					|| str==null || " ".equals(str)){
				nullCheck=true;
			}else{
				nullCheck=false;
			}
		}
		
		if(obj instanceof Integer){
			if((Integer) obj <= 0 || (Integer) obj == null){
				nullCheck =  true;
			}else{
				nullCheck=false;
			}
		}
		return nullCheck;
	}
	
	//사이즈 체크
	public boolean checkMaxLength(int maxNum, Object obj){
		boolean checkLength=false;
		if(obj instanceof String){
			checkLength=((String) obj).length() < maxNum ? false:true;
		}
		if(obj instanceof Integer){
			checkLength=(Integer) obj < maxNum ? false:true;
		}
		return checkLength;
	}
	
}
