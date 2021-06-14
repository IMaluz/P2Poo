package br.com.luiza.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import br.com.luiza.config.DbListener;

public class Disciplinas {

    private String name;
    private String horario;
    private String dia;
    private String aulas;
    private String p1;
    private String p2;

    public static String getCreateStatement() {
        return "CREATE TABLE IF NOT EXISTS disciplinas("
                + "name VARCHAR(50) PRIMARY KEY,"
                + "dia VARCHAR(10), "
                + "horario VARCHAR(10), "
                + "aulas VARCHAR(4), "
                + "p1 VARCHAR(4), "
                + "p2 VARCHAR(4) "
                + ")";
    }

    public static ArrayList<Disciplinas> getList() throws Exception {
        ArrayList<Disciplinas> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * from disciplinas ORDER BY name");
        while (rs.next()) {
            String name = rs.getString("name");
            String horario = rs.getString("horario");
            String dia = rs.getString("dia");
            String aulas = rs.getString("aulas");
            String p1 = rs.getString("p1");
            String p2 = rs.getString("p2");

            list.add(new Disciplinas(name, dia, horario, aulas, p1, p2));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }

    public static void insert(String name, String horario, String dia, String aulas) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "INSERT INTO disciplinas(name, horario ,dia, aulas) VALUES(?, ?, ?, ?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, horario);
        stmt.setString(3, dia);
        stmt.setString(4, aulas);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public static void update(String p1, String p2, String name) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "UPDATE disciplinas "
                + "SET p1=?, "
                + "p2=? "
                + "WHERE name=?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, p1);
        stmt.setString(2, p2);
        stmt.setString(3, name);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public static void delete(String name) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "DELETE FROM disciplinas WHERE name = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public Disciplinas(String name, String horario, String dia, String aulas, String p1, String p2) {
        this.name = name;
        this.horario = horario;
        this.dia = dia;
        this.aulas = aulas;
        this.p1 = p1;
        this.p2 = p2;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public String getAulas() {
        return aulas;
    }

    public void setAulas(String aulas) {
        this.aulas = aulas;
    }

    public String getP1() {
        return p1;
    }

    public void setP1(String p1) {
        this.p1 = p1;
    }

    public String getP2() {
        return p2;
    }

    public void setP2(String p2) {
        this.p2 = p2;
    }
    
}
