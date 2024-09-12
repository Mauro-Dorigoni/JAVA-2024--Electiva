package data;
import entidades.*;
import java.util.LinkedList;
import java.sql.*;
import java.time.*;

public class DataEjemplar {

	public void save(Ejemplar ej) throws AppException{
		PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"insert into ejemplar(idLibro, nroEdicion, fechaEdicion, cantPaginas, editorial) values(?,?,?,?,?)",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setInt(1, ej.getLibro().getIdLibro());
			stmt.setInt(2, ej.getNroEdicion());
			stmt.setObject(3, ej.getFechaEdicion());
			stmt.setInt(4, ej.getCantPaginas());
			stmt.setString(5, ej.getEditorial());
			stmt.executeUpdate();

			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                ej.setIdEjemplar(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			e.printStackTrace();
			throw new AppException("Error: no se pudo guardar el Ejemplar");
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	e.printStackTrace();
            	throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
            }
           }
    }
	
	public LinkedList<Ejemplar> getEjemplaresLibres(Libro l) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        LinkedList<Ejemplar> ejemplaresLibres = new LinkedList<>();
		try {
        	stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select e.idEjemplar, e.cantPaginas, e.editorial, e.fechaEdicion, e.nroEdicion, e.idLibro from ejemplar e where e.idEjemplar not in (select eje.idEjemplar from ejemplar eje inner join prestamo pre on eje.idEjemplar=pre.idEjemplar and eje.idLibro=pre.idLibro where pre.estado!=? and eje.idLibro=?) and e.idLibro=? and e.fechaBaja is null;");
			stmt.setString(1, "Devuelto");
        	stmt.setInt(2, l.getIdLibro());
			stmt.setInt(3, l.getIdLibro());
			rs=stmt.executeQuery();
			 if (rs != null) {
	                while (rs.next()) {
	                	Libro libro = new Libro();
	                	Ejemplar ejemplar = new Ejemplar();
	                	libro.setIdLibro(rs.getInt(6));
	                	ejemplar.setLibro(libro);
	                	ejemplar.setIdEjemplar(rs.getInt(1));
	                	ejemplar.setCantPaginas(rs.getInt(2));
	                	ejemplar.setEditorial(rs.getString(3));
	                	ejemplar.setFechaEdicion(rs.getObject(4, LocalDate.class));
	                	ejemplar.setNroEdicion(rs.getInt(5));
	                	ejemplaresLibres.add(ejemplar);
	                }
	            }
		} catch (SQLException e) {
			throw new AppException("Error: no pudieron recuperar ejemplares libres");
		}finally {
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
        return ejemplaresLibres;
	}

}
