package data;

import entidades.*;
import java.sql.*;

public class DataCliente {
    public Cliente getByMailandPass(Cliente c) {
        Cliente p = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Connection conn = DbConnector.getInstancia().getConn();
            stmt = conn.prepareStatement("SELECT * FROM cliente WHERE mail=? AND contra=?;");
            stmt.setString(1, c.getMail());
            stmt.setString(2, c.getContra());
            rs = stmt.executeQuery();
            if (rs != null && rs.next()) {
                p = new Cliente();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setMail(rs.getString("mail"));
                p.setDni(rs.getString("dni"));
                p.setContra(rs.getString("contra"));
                p.setFechaUltimoPago(rs.getDate("fechaUltimoPago"));
                p.setAdmin(rs.getBoolean(8));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return p;
    }
}