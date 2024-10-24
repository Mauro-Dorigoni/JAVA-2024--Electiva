package data;

import entidades.*;
import java.sql.*;
import java.time.*;
import java.util.LinkedList;

public class DataCliente {
	
	public LinkedList<Cliente> getAll() throws AppException{
        Statement stmt = null;
        ResultSet rs = null;
        LinkedList<Cliente> clientes = new LinkedList<>();
        try {
            stmt = DbConnector.getInstancia().getConn().createStatement();
            rs = stmt.executeQuery("select * from cliente where fechaBaja is null;");

            if (rs != null) {
                while (rs.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setId(rs.getInt(1));
                    cliente.setNombre(rs.getString(2));
                    cliente.setApellido(rs.getString(3));
                    cliente.setMail(rs.getString(4));
                    cliente.setDni(rs.getString(5));
                    cliente.setFechaUltimoPago(rs.getObject(7, LocalDate.class));
                    cliente.setAdmin(rs.getBoolean(8));
                    clientes.add(cliente);
                }
            }

        } catch (SQLException e) {
            throw new AppException("Error: no se pudo recuperar los clientes");
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
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
        }
        return clientes;
    }
	
	public Cliente getOne(Cliente c) throws AppException{
        Cliente p = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Connection conn = DbConnector.getInstancia().getConn();
            stmt = conn.prepareStatement("SELECT * FROM cliente WHERE id=? and fechaBaja IS NULL;");
            stmt.setInt(1, c.getId());
            rs = stmt.executeQuery();
            if (rs != null && rs.next()) {
                p = new Cliente();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setMail(rs.getString("mail"));
                p.setDni(rs.getString("dni"));
                p.setContra(rs.getString("contra"));
                p.setFechaUltimoPago(rs.getObject("fechaUltimoPago",LocalDate.class));
                p.setAdmin(rs.getBoolean(8));
            }
        } catch (SQLException e) {
        	throw new AppException("Error: no se pudo verificar la existencia del usuario id: "+c.getId());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
        }
        return p;
    }
	
	
	public Cliente getByMail(Cliente c) throws AppException{
        Cliente p = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Connection conn = DbConnector.getInstancia().getConn();
            stmt = conn.prepareStatement("SELECT * FROM cliente WHERE mail=? and fechaBaja IS NULL;");
            stmt.setString(1, c.getMail());
            rs = stmt.executeQuery();
            if (rs != null && rs.next()) {
                p = new Cliente();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setApellido(rs.getString("apellido"));
                p.setMail(rs.getString("mail"));
                p.setDni(rs.getString("dni"));
                p.setContra(rs.getString("contra"));
                p.setFechaUltimoPago(rs.getObject("fechaUltimoPago",LocalDate.class));
                p.setAdmin(rs.getBoolean(8));
            }
        } catch (SQLException e) {
        	throw new AppException("Error: no se pudo verificar la existencia del usuario con mail: "+c.getMail());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
        }
        return p;
    }
	public Cliente getByMailandPass(Cliente c) throws AppException{
        Cliente p = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Connection conn = DbConnector.getInstancia().getConn();
            stmt = conn.prepareStatement("SELECT * FROM cliente WHERE mail=? AND contra=? and fechaBaja IS NULL;");
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
                p.setFechaUltimoPago(rs.getObject("fechaUltimoPago",LocalDate.class));
                p.setAdmin(rs.getBoolean(8));
            }
        } catch (SQLException e) {
        	throw new AppException("Error: no se pudo recuperar el usuario con mail: "+c.getMail());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
        }
        return p;
    }
	
	public void add (Cliente c) throws AppException{
		PreparedStatement stmt= null;
		ResultSet keyResultSet=null;
		try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"insert into cliente (nombre, apellido, mail, dni, contra, isAdmin) values (?,?,?,?,?,?);",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, c.getNombre());
			stmt.setString(2, c.getApellido());
			stmt.setString(3, c.getMail());
			stmt.setString(4, c.getDni());
			stmt.setString(5, c.getContra());
			stmt.setBoolean(6, false);

			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                c.setId(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo register el usuario con mail: "+c.getMail());
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
        }
	}
	
	public void updatePago(Cliente c) throws AppException{
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE cliente SET fechaUltimoPago =? WHERE id=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setObject(1, c.getFechaUltimoPago());
			stmt.setInt(2,c.getId());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                c.setId(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo registrar el pago de Cliente ID: "+c.getId());
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
           }
    }
	
	public void updatePassword(Cliente c) throws AppException {
		PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE cliente SET contra =? WHERE id=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setObject(1, c.getContra());
			stmt.setInt(2,c.getId());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                c.setId(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo actualizar la contraseña de Cliente ID: "+c.getId());
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
           }
	}
	
	public void bajaLogica(Cliente c) throws AppException{
		PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE cliente SET fechaBaja =? WHERE id=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setObject(1, LocalDate.now());
			stmt.setInt(2,c.getId());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                c.setId(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo dar de baja la cuenta del cliente Cliente ID: "+c.getId());
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
           }
	}
}