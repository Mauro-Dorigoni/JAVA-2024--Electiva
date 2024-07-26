package logica;
import entidades.*;
import db.*;
import java.util.LinkedList;
import java.sql.*;
import java.time.LocalDateTime;  
import java.time.format.DateTimeFormatter;

public class LogicaProducto {
	public LinkedList<Product> getAll(){
		Statement stmt=null;
		ResultSet rs=null;
		LinkedList<Product> prods = new LinkedList<>();
		
		try {
			stmt= DbConnector.getInstancia().getConn().createStatement();
			rs= stmt.executeQuery("select * from product where disabledOn is null;");
			if(rs!=null) {
				while(rs.next()) {
					Product p = new Product();
					p.setId(rs.getInt("id"));
					p.setNombre(rs.getString("nombre"));
					p.setDescripcion(rs.getString("descripcion"));
					p.setPrecio(rs.getFloat("precio"));
					p.setStock(rs.getInt("stock"));
					p.setEnvio(rs.getBoolean("incluyeEnvio"));
					
					prods.add(p);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		}

		return prods;
	}
	public Product buscaxId(int id) {
		Product p=new Product();
		PreparedStatement stmt=null;
		ResultSet rs=null;
		try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select * from product where id=?"
					);
			stmt.setInt(1,id);
			rs=stmt.executeQuery();
			if(rs!=null && rs.next()) {
				p.setId(rs.getInt("id"));
				p.setNombre(rs.getString("nombre"));
				p.setDescripcion(rs.getString("descripcion"));
				p.setPrecio(rs.getFloat("precio"));
				p.setStock(rs.getInt("stock"));
				p.setEnvio(rs.getBoolean("incluyeEnvio"));
				p.setFechaBaja(rs.getString("disabledOn"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return p;
	}
	
	public void save(Product p) {
		PreparedStatement stmt= null;
		ResultSet keyResultSet=null;
		try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"insert into product (nombre, descripcion, precio, stock, incluyeEnvio, disabledOn) values (?, ?, ?, ?, ?, ?)",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, p.getNombre());
			stmt.setString(2, p.getDescripcion());
			stmt.setFloat(3, p.getPrecio());
			stmt.setInt(4, p.getStock());
			stmt.setBoolean(5, p.isEnvio());
			stmt.setString(6, p.getFechaBaja());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                p.setId(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
            e.printStackTrace();
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	e.printStackTrace();
            }
		}
	}
	public void borrarLogico(int id) {
		PreparedStatement stmt= null;
		ResultSet keyResultSet=null;
		try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE product set disabledOn=? where id=?;",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, java.time.LocalDate.now().toString());
			
			stmt.setInt(2, id);
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();

			
		}  catch (SQLException e) {
            e.printStackTrace();
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	e.printStackTrace();
            }
		}
	}
	
	public void update(Product p) {
		PreparedStatement stmt= null;
		ResultSet keyResultSet=null;
		try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE product set nombre=?, descripcion=?, precio=?, stock=?, incluyeEnvio=? where id=?;",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, p.getNombre());
			stmt.setString(2, p.getDescripcion());
			stmt.setFloat(3, p.getPrecio());
			stmt.setInt(4, p.getStock());
			stmt.setBoolean(5, p.isEnvio());
			stmt.setInt(6, p.getId());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                p.setId(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
            e.printStackTrace();
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	e.printStackTrace();
            }
		}
	}
	
	public void borrar(int id) {
		PreparedStatement stmt= null;
		ResultSet keyResultSet=null;
		try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"DELETE from product where id=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setInt(1, id);
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();

			
		}  catch (SQLException e) {
            e.printStackTrace();
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	e.printStackTrace();
            }
		}
	}
}
