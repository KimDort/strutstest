package com.icanman.tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConn {
	public Connection getConnection()throws SQLException{
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
