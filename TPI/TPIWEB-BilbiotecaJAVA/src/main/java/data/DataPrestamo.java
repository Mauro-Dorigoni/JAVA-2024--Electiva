package data;

import entidades.*;
import logic.*;
import java.util.LinkedList;

import org.apache.tomcat.JarScanType;

import java.sql.*;
import java.time.*;

public class DataPrestamo {

	public DataPrestamo() {
		// TODO Auto-generated constructor stub
	}
	public void save(Prestamo p) throws AppException {
		PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"insert into prestamo(fechaRealizacion, estado, idCliente, idEjemplar, idLibro) values(?,?,?,?,?)",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setObject(1, LocalDate.now());
			stmt.setString(2, "Pendiente Retiro");
			stmt.setInt(3, p.getCliente().getId());
			stmt.setInt(4, p.getEjemplar().getIdEjemplar());
			stmt.setInt(5, p.getEjemplar().getLibro().getIdLibro());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                p.getEjemplar().getLibro().setIdLibro(keyResultSet.getInt(5));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo registrar el Prestamo");
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
	
	public Prestamo getOne(Prestamo p) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        Prestamo prestamo = new Prestamo();
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select p.fechaRealizacion, p.estado, p.idCliente, p.idEjemplar, p.idLibro, c.mail, l.titulo from prestamo p \r\n"
					+ "inner join cliente c on p.idCliente=c.id \r\n"
					+ "inner join ejemplar e on p.idEjemplar=e.idEjemplar and p.idLibro=e.idLibro \r\n"
					+ "inner join libro l on p.idLibro=l.idLibro "
					+ "where p.fechaRealizacion=? and p.idCliente=? and p.idEjemplar=? and p.idLibro=?"
					);
			stmt.setObject(1, p.getFechaRealizacion());
			stmt.setInt(2, p.getCliente().getId());
			stmt.setInt(3, p.getEjemplar().getIdEjemplar());
			stmt.setInt(4, p.getEjemplar().getLibro().getIdLibro());
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                	Cliente cli = new Cliente();
                	cli.setId(rs.getInt(3));
                	cli.setMail(rs.getString(6));
                	Libro lib = new Libro();
                	lib.setIdLibro(rs.getInt(5));
                	lib.setTitulo(rs.getString(7));
                	Ejemplar eje = new Ejemplar();
                	eje.setIdEjemplar(rs.getInt(4));
                	eje.setLibro(lib);
                	prestamo.setFechaRealizacion(rs.getObject(1,LocalDate.class));
                	prestamo.setEstado(rs.getString(2));
                	prestamo.setCliente(cli);
                	prestamo.setEjemplar(eje);

                }
            }
		} catch (SQLException e) {
			throw new AppException("Error: no se pudo recuperar el prestamo deseado");
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
			}
		}
		
		return prestamo;
    }
	
	public LinkedList<Prestamo> getAll() throws AppException{
		 Statement stmt = null;
	        ResultSet rs = null;
	        LinkedList<Prestamo> prestamos = new LinkedList<>();
	        try {
	            stmt = DbConnector.getInstancia().getConn().createStatement();
	            rs = stmt.executeQuery("select p.fechaRealizacion, p.estado, p.idCliente, p.idEjemplar, p.idLibro, c.mail, l.titulo from prestamo p \r\n"
	            		+ "inner join cliente c on p.idCliente=c.id \r\n"
	            		+ "inner join ejemplar e on p.idEjemplar=e.idEjemplar and p.idLibro=e.idLibro \r\n"
	            		+ "inner join libro l on p.idLibro=l.idLibro;");

	            if (rs != null) {
	                while (rs.next()) {
	                	Prestamo prestamo = new Prestamo();
	                	Cliente cli = new Cliente();
	                	cli.setId(rs.getInt(3));
	                	cli.setMail(rs.getString(6));
	                	Libro lib = new Libro();
	                	lib.setIdLibro(rs.getInt(5));
	                	lib.setTitulo(rs.getString(7));
	                	Ejemplar eje = new Ejemplar();
	                	eje.setIdEjemplar(rs.getInt(4));
	                	eje.setLibro(lib);
	                	prestamo.setFechaRealizacion(rs.getObject(1,LocalDate.class));
	                	prestamo.setEstado(rs.getString(2));
	                	prestamo.setCliente(cli);
	                	prestamo.setEjemplar(eje);
	                	prestamos.add(prestamo);
	                }
	            }

	        } catch (SQLException e) {
	            throw new AppException("Error: no se pudo recuperar los prestamos");
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
	        return prestamos;
	    }
	
	public LinkedList<Prestamo> getPrestamosCliente(Cliente c) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        LinkedList<Prestamo> prestamosCliente = new LinkedList<>();
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select p.fechaRealizacion, p.estado, p.idCliente, p.idEjemplar, p.idLibro, c.mail, l.titulo, l.idPhoto from prestamo p \r\n"
					+ "inner join cliente c on p.idCliente=c.id \r\n"
					+ "inner join ejemplar e on p.idEjemplar=e.idEjemplar and p.idLibro=e.idLibro \r\n"
					+ "inner join libro l on p.idLibro=l.idLibro "
					+ "where p.idCliente=?"
					);
			stmt.setInt(1, c.getId());
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                	Prestamo prestamo = new Prestamo();
                	Cliente cli = new Cliente();
                	cli.setId(rs.getInt(3));
                	cli.setMail(rs.getString(6));
                	Libro lib = new Libro();
                	lib.setIdLibro(rs.getInt(5));
                	lib.setTitulo(rs.getString(7));
                	lib.setIdPhoto(rs.getString(8));
                	Ejemplar eje = new Ejemplar();
                	eje.setIdEjemplar(rs.getInt(4));
                	eje.setLibro(lib);
                	prestamo.setFechaRealizacion(rs.getObject(1,LocalDate.class));
                	prestamo.setEstado(rs.getString(2));
                	prestamo.setCliente(cli);
                	prestamo.setEjemplar(eje);
                	prestamosCliente.add(prestamo);

                }
            }
		} catch (SQLException e) {
			throw new AppException("Error: no se pudo recuperar el prestamo deseado");
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
			}
		}
		
		return prestamosCliente;
    }
	
	public void update(Prestamo p) throws AppException{
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE prestamo SET estado=? WHERE fechaRealizacion=? and idCliente=? and idEjemplar=? and idLibro=?",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, p.getEstado());
			stmt.setObject(2, p.getFechaRealizacion());
			stmt.setInt(3, p.getCliente().getId());
			stmt.setInt(4, p.getEjemplar().getIdEjemplar());
			stmt.setInt(5, p.getEjemplar().getLibro().getIdLibro());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
            	p.getEjemplar().getLibro().setIdLibro(p.getEjemplar().getLibro().getIdLibro());
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo actualizar el prestamo requerido");
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
	
	public boolean validatePrestamosActivosCliente(Cliente c) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean validar = false;
        int cantPrestamosActivosCliente = 3;
        try {
        	stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select count(*) from prestamo where idCliente=? and estado=?;"
					);
			stmt.setInt(1, c.getId());
			stmt.setString(2, "Pendiente devolucion");
			rs=stmt.executeQuery();
			 if (rs != null) {
	                while (rs.next()) {
	                	cantPrestamosActivosCliente = rs.getInt(1); 
	                }
	            }
			 if(cantPrestamosActivosCliente > 2) {validar = false;}
			 else {validar=true;}
		} catch (SQLException e) {
			throw new AppException("Error: no se varificar la cantidad de prestamos activos del cliente");
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
        return validar;
	}
	
	public boolean validatePrestamosVencidosCliente(Cliente c) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean validar = false;
        int cantPrestamosActivosCliente = 3;
        try {
        	stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select count(*) from prestamo where idCliente=? and estado=?;"
					);
			stmt.setInt(1, c.getId());
			stmt.setString(2, "Vencido");
			rs=stmt.executeQuery();
			 if (rs != null) {
	                while (rs.next()) {
	                	cantPrestamosActivosCliente = rs.getInt(1); 
	                }
	            }
			 if(cantPrestamosActivosCliente > 1) {validar = false;}
			 else {validar=true;}
		} catch (SQLException e) {
			throw new AppException("Error: no se varificar la cantidad de prestamos vencidos del cliente");
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
        return validar;
	}
	
	public boolean validatePagoCliente(Cliente c) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean validar = false;
        int mesesAtrasoPago = 2;
        try {
        	stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select timestampdiff(month, cli.fechaUltimoPago, curdate()) from cliente cli where id=?;"
					);
			stmt.setInt(1, c.getId());
			rs=stmt.executeQuery();
			 if (rs != null) {
	                while (rs.next()) {
	                	mesesAtrasoPago = rs.getInt(1); 
	                }
	            }
			 if(mesesAtrasoPago > 2) {validar = false;}
			 else {validar=true;}
		} catch (SQLException e) {
			throw new AppException("Error: no pudo varificar la fecha de ultimo pago del cliente");
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
        return validar;
	}
	
	public boolean validateEjemplaresLibres(Libro l) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean validar = false;
        int cantEjemplaresLibres = 0;
        try {
        	stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select count(e.idEjemplar) from ejemplar e where e.idEjemplar not in (select eje.idEjemplar from ejemplar eje inner join prestamo pre on eje.idEjemplar=pre.idEjemplar and eje.idLibro=pre.idLibro where pre.estado!=? and eje.idLibro=?) and e.idLibro=? and e.fechaBaja is null;");
			stmt.setString(1, "Devuelto");
        	stmt.setInt(2, l.getIdLibro());
			stmt.setInt(3, l.getIdLibro());
			rs=stmt.executeQuery();
			 if (rs != null) {
	                while (rs.next()) {
	                	cantEjemplaresLibres = rs.getInt(1); 
	                }
	            }
			 if(cantEjemplaresLibres == 0) {validar = false;}
			 else {validar=true;}
		} catch (SQLException e) {
			throw new AppException("Error: no pudo verificar que existan ejemplares libres");
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
        return validar;
	}
	
	
}
