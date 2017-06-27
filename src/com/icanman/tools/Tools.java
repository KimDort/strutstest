package com.icanman.tools;

public class Tools {
	public boolean checkIntegerType(Object obj){
		boolean checkType=false;
		if(obj instanceof Integer){
			checkType=true;
		}
		return checkType;
	}
	
	public boolean checkNull(Object obj){
		boolean nullCheck=false;
		
		if(obj instanceof String){
			if(((String) obj).isEmpty() || "".equals(((String) obj)) 
					|| ((String) obj)==null){
				nullCheck=true;
			}
		}
		
		if(obj instanceof Integer){
			if((Integer) obj <= 0 || (Integer) obj == null){
				nullCheck =  true;
			}
		}
		return nullCheck;
	}
	
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
