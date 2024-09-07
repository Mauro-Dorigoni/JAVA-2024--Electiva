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

}
