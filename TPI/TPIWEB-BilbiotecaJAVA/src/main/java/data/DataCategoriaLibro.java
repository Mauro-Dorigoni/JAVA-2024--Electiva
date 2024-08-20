package data;

import entidades.*;
import java.util.LinkedList;
import java.sql.*;

public class DataCategoriaLibro {

    public LinkedList<Categoria_libro> getAll() {
        Statement stmt = null;
        ResultSet rs = null;
        LinkedList<Categoria_libro> cats = new LinkedList<>();

        try {
            stmt = DbConnector.getInstancia().getConn().createStatement();
            rs = stmt.executeQuery("select * from categoria_libro");

            if (rs != null) {
                while (rs.next()) {
                    Categoria_libro c = new Categoria_libro();
                    c.setIdCategoria(rs.getInt(1));
                    c.setNombre_categoria(rs.getString(2));
                    c.setDescripcion_apliada(rs.getString(3));

                    cats.add(c);
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
        return cats;
    }
    
    public LinkedList<Categoria_libro> getByDatos(Categoria_libro c) {
    	PreparedStatement stmt = null;
        ResultSet rs = null;
        LinkedList<Categoria_libro> cats = new LinkedList<>();
        
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select * from categoria_libro where idCategoria = ? OR LOWER(nombre_categoria) like ? OR LOWER(descripcion_ampliada) like ?"
					);
			stmt.setString(1, Integer.toString(c.getIdCategoria()));
			stmt.setString(2, c.getNombre_categoria().toLowerCase());
			stmt.setString(3, "%"+c.getDescripcion_apliada().toLowerCase()+"%");
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    Categoria_libro cat = new Categoria_libro();
                    cat.setIdCategoria(rs.getInt(1));
                    cat.setNombre_categoria(rs.getString(2));
                    cat.setDescripcion_apliada(rs.getString(3));

                    cats.add(cat);
                }
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
		
		return cats;
        
    }
    
    public void save(Categoria_libro c) {
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"insert into categoria_libro(nombre_categoria, descripcion_ampliada) values(?,?)",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, c.getNombre_categoria());
			stmt.setString(2, c.getDescripcion_apliada());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                c.setIdCategoria(keyResultSet.getInt(1));
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
    
    public void modify_desc(Categoria_libro c) {
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE categoria_libros SET descripcion_ampliada=? WHERE idCategoria=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, c.getDescripcion_apliada());
			stmt.setString(2, Integer.toString(c.getIdCategoria()));
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                c.setIdCategoria(keyResultSet.getInt(1));
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
}
