package data;
import entidades.*;
import java.util.LinkedList;
import java.sql.*;
import java.time.*;

public class DataLibro {
	public void save(Libro l) {
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
