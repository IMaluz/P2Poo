package br.com.luiza.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import br.com.luiza.db.User;
 

public class DbListener implements ServletContextListener {
    public static final String CLASS_NAME = "org.sqlite.JDBC";
    public static final String URL = "jdbc:sqlite:p2.db";
    public static Exception exception = null;
    
    public static Connection getConnection() throws Exception{
        return DriverManager.getConnection(URL);
    }
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try{
            Class.forName(CLASS_NAME);
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            stmt.execute(User.getCreateStatement());
            if(User.getUsers().isEmpty()){
                User.insertUser("admin", "Administrador", "ADMIN", "1234");
                User.insertUser("maria", "Maria", "USER", "123");
            }
            stmt.close();
            con.close();
        }catch(Exception ex){
            exception = ex;
        }
    }
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}