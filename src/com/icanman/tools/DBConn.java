package com.icanman.tools;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {
	public Connection getConnection(){
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String id="tester1";
		String pass="cjsekd13";
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn=DriverManager.getConnection(url,id,pass);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return conn;
	}
}
