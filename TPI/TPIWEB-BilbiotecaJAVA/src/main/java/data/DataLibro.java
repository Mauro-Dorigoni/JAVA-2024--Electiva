package data;
import entidades.*;
import java.util.LinkedList;
import java.sql.*;
import java.time.*;

public class DataLibro {
	public LinkedList<Libro> getAll() throws AppException{
        Statement stmt = null;
        ResultSet rs = null;
        LinkedList<Libro> libros = new LinkedList<>();
        try {
            stmt = DbConnector.getInstancia().getConn().createStatement();
            rs = stmt.executeQuery("select * from libro lib inner join categoria_libro cat on lib.idCategoria=cat.idCategoria where lib.fechaBaja IS NULL");

            if (rs != null) {
                while (rs.next()) {
                    Libro l = new Libro();
                    Categoria_libro cat = new Categoria_libro();
                    l.setIdLibro(rs.getInt(1));
                    l.setTitulo(rs.getString(2));
                    l.setAutor(rs.getString(3));
                    l.setISBN(rs.getString(4));
                    l.setSumario(rs.getString(5));
                    l.setIdPhoto(rs.getString(8));
                    cat.setIdCategoria(rs.getInt(9));
                    cat.setNombre_categoria(rs.getString(10));
                    cat.setDescripcion_apliada(rs.getString(11));
                    cat.setIdPhoto(rs.getString(13));
                    l.setCategoria(cat);
                    libros.add(l);
                }
            }

        } catch (SQLException e) {
            throw new AppException("Error: no se pudo recuperar los libros");
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
        return libros;
    }
	public void save(Libro l) throws AppException{
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"insert into libro(titulo, autor, ISBN, sumario, idCategoria,idPhoto) values(?,?,?,?,?,?)",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, l.getTitulo());
			stmt.setString(2, l.getAutor());
			stmt.setString(3, l.getISBN());
			stmt.setString(4, l.getSumario());
			stmt.setInt(5, l.getCategoria().getIdCategoria());
			stmt.setString(6, l.getIdPhoto());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                l.setIdLibro(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo guardar el libro Titulo:"+l.getTitulo());
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
    public Libro getOne(Libro l) throws AppException{
    	PreparedStatement stmt = null;
        ResultSet rs = null;
        Libro libro = new Libro();
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select * from libro lib inner join categoria_libro cat on lib.idCategoria=cat.idCategoria where idLibro = ?"
					);
			stmt.setString(1, Integer.toString(l.getIdLibro()));
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                	Categoria_libro cat = new Categoria_libro();
                    libro.setIdLibro(rs.getInt(1));
                    libro.setTitulo(rs.getString(2));
                    libro.setAutor(rs.getString(3));
                    libro.setISBN(rs.getString(4));
                    libro.setSumario(rs.getString(5));
                    libro.setIdPhoto(rs.getString(8));
                    cat.setIdCategoria(rs.getInt(9));
                    cat.setNombre_categoria(rs.getString(10));
                    cat.setDescripcion_apliada(rs.getString(11));
                    cat.setIdPhoto(rs.getString(13));
                    cat.setFechaBaja(rs.getObject(12,LocalDate.class));
                    if(cat.getFechaBaja()!=null) {cat=null;}
                    libro.setCategoria(cat); 

                }
            }
		} catch (SQLException e) {
			throw new AppException("Error: no se pudo recuperar el libro ID: "+l.getIdLibro());
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
			}
		}
		
		return libro;
    }
    public void update(Libro l) throws AppException{
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE libro SET titulo=?, autor=?,ISBN=?,sumario=?,idCategoria=? WHERE idLibro=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, l.getTitulo());
			stmt.setString(2, l.getAutor());
			stmt.setString(3, l.getISBN());
			stmt.setString(4, l.getSumario());
			stmt.setInt(5, l.getCategoria().getIdCategoria());
			stmt.setString(6, Integer.toString(l.getIdLibro()));
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                l.setIdLibro(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo actualizar el libro ID: "+l.getIdLibro());
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
    public void deleteLogic(Libro l) throws AppException{
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE libro SET fechaBaja=? WHERE idLibro=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setObject(1, LocalDate.now());
			stmt.setString(2, Integer.toString(l.getIdLibro()));
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                l.setIdLibro(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo dar de baja al libro ID: "+l.getIdLibro());
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
    
    public LinkedList<Libro> search(Libro l) throws AppException{
    	PreparedStatement stmt = null;
        ResultSet rs = null;
        LinkedList<Libro> libros = new LinkedList<>();
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select * from libro lib inner join categoria_libro cat on lib.idCategoria=cat.idCategoria where lib.fechaBaja IS NULL AND (LOWER(lib.titulo) like ? OR LOWER(lib.sumario) like ?);"
					);
			stmt.setString(1, "%"+l.getTitulo().toLowerCase()+"%");
			stmt.setString(2, "%"+l.getSumario().toLowerCase()+"%");
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                	Categoria_libro cat = new Categoria_libro();
                	Libro libro = new Libro();
                	libro.setIdLibro(rs.getInt(1));
                    libro.setTitulo(rs.getString(2));
                    libro.setAutor(rs.getString(3));
                    libro.setISBN(rs.getString(4));
                    libro.setSumario(rs.getString(5));
                    libro.setIdPhoto(rs.getString(8));
                    cat.setIdCategoria(rs.getInt(9));
                    cat.setNombre_categoria(rs.getString(10));
                    cat.setDescripcion_apliada(rs.getString(11));
                    cat.setIdPhoto(rs.getString(13));
                    cat.setFechaBaja(rs.getObject(12,LocalDate.class));
                    if(cat.getFechaBaja()!=null) {cat=null;}
                    libro.setCategoria(cat);
                    libros.add(libro);

                }
            }
		} catch (SQLException e) {
			throw new AppException("Error: no se pudo recuperar libros con esos datos");
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
			}
		}
		
		return libros;
    }
   
}
