package data;

import entidades.*;
import java.util.LinkedList;
import java.sql.*;
import java.time.*;

public class DataCategoriaLibro {

    public LinkedList<Categoria_libro> getAll() {
        Statement stmt = null;
        ResultSet rs = null;
        LinkedList<Categoria_libro> cats = new LinkedList<>();

        try {
            stmt = DbConnector.getInstancia().getConn().createStatement();
            rs = stmt.executeQuery("select * from categoria_libro where fechaBaja IS NULL");

            if (rs != null) {
                while (rs.next()) {
                    Categoria_libro c = new Categoria_libro();
                    c.setIdCategoria(rs.getInt(1));
                    c.setNombre_categoria(rs.getString(2));
                    c.setDescripcion_apliada(rs.getString(3));
                    c.setIdPhoto(rs.getString(5));
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
    
    public Categoria_libro getOne(Categoria_libro c) {
    	PreparedStatement stmt = null;
        ResultSet rs = null;
        Categoria_libro cat = new Categoria_libro();
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select * from categoria_libro where idCategoria = ?"
					);
			stmt.setString(1, Integer.toString(c.getIdCategoria()));
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    cat.setIdCategoria(rs.getInt(1));
                    cat.setNombre_categoria(rs.getString(2));
                    cat.setDescripcion_apliada(rs.getString(3));
                    cat.setFechaBaja(rs.getObject("fechaBaja",LocalDate.class));
                    cat.setIdPhoto(rs.getString(5));

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
		
		return cat;
    }
    
    public LinkedList<Categoria_libro> getByDatos(Categoria_libro c) {
    	PreparedStatement stmt = null;
        ResultSet rs = null;
        LinkedList<Categoria_libro> cats = new LinkedList<>();
        
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select * from categoria_libro where (idCategoria = ? OR LOWER(nombre_categoria) like ? OR LOWER(descripcion_ampliada) like ?) and fechaBaja is null");
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
                    cat.setIdPhoto(rs.getString(5));
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
							"insert into categoria_libro(nombre_categoria, descripcion_ampliada, idPhoto) values(?,?,?)",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, c.getNombre_categoria());
			stmt.setString(2, c.getDescripcion_apliada());
			stmt.setString(3, c.getIdPhoto());
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
							"UPDATE categoria_libro SET descripcion_ampliada=? WHERE idCategoria=?",
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
    public void deleteLogic(Categoria_libro c) {
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE categoria_libro SET fechaBaja=? WHERE idCategoria=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setObject(1, LocalDate.now());
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
