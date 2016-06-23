package br.ufsm.csi.model.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConectarPostGressFactory {
	
	public static Connection getConexao() {

		Connection conn = null;
		
		String host = "localhost";
		String database = "prova1";
		String user = "postgres";
		String password = "1234";
		
		String url = "jdbc:postgresql://" +host +":5432/" +database;

		try {
			Class.forName("org.postgresql.Driver");
			
			conn = DriverManager.getConnection(url, user, password);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return conn;
	}
}
