package data;
import entidades.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class DataAdministrativo {
	public LinkedList<Cliente> getAll(){
		Statement stmt = null;
        ResultSet rs = null;
        LinkedList<Cliente> administradores = new LinkedList<>();
        try {
            stmt = DbConnector.getInstancia().getConn().createStatement();
            rs = stmt.executeQuery("select * from cliente where isAdmin=1;");

            if (rs != null) {
                while (rs.next()) {
                    Cliente c = new Cliente();
                    c.setId(rs.getInt(1));
                    c.setNombre(rs.getString(2));;
                    c.setApellido(rs.getString(3));
                    c.setMail(rs.getString(4));
                    c.setDni(rs.getString(5));
                    c.setContra(rs.getString(6));
                    c.setFechaUltimoPago(null);
                    c.setAdmin(true);

                    administradores.add(c);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return administradores;
    }
	
}

