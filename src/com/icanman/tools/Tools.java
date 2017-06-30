package com.icanman.tools;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Tools {
	public Date getNowDate() throws Exception{
		SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		Date baseDate = new Date();
		String strNow= formater.format(baseDate);
		Date nowDate;
		try {
			nowDate = formater.parse(strNow);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
		
		return nowDate;
	}
	
	public Date setParseDate(String strDate) throws Exception{
		SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		Date date;
		try {
			date = formater.parse(strDate);
			System.out.println(date);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return date;
	}
}
