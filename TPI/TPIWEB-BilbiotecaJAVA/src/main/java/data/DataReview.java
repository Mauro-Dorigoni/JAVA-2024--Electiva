package data;
import entidades.*;
import java.util.LinkedList;
import java.sql.*;
import java.time.*;

public class DataReview {
	public LinkedList<Review> getAll() throws AppException{
		 Statement stmt = null;
	        ResultSet rs = null;
	        LinkedList<Review> reviews = new LinkedList<>();
	        try {
	            stmt = DbConnector.getInstancia().getConn().createStatement();
	            rs = stmt.executeQuery("select res.idReview, res.fechaReview, res.puntaje, res.descripcion, res.estado, res.fechaRealizacion, res.idCliente, res.idEjemplar, res.idLibro, res.idAdmin, res.motivo_rechazo, pre.estado, c.nombre, c.apellido, c.mail, lib.titulo, adm.nombre, adm.apellido\r\n"
	            		+ "from review res \r\n"
	            		+ "inner join prestamo pre on pre.fechaRealizacion=res.fechaRealizacion and pre.idCliente=res.idCliente and pre.idEjemplar=res.idEjemplar and pre.idLibro=res.idLibro\r\n"
	            		+ "inner join cliente c on c.id=res.idCliente\r\n"
	            		+ "inner join libro lib on lib.idLibro=res.idLibro\r\n"
	            		+ "inner join cliente adm on res.idAdmin=adm.id;");

	            if (rs != null) {
	                while (rs.next()) {
	                    Cliente c = new Cliente();
	                    c.setId(rs.getInt(7));
	                    c.setMail(rs.getString(15));
	                    c.setNombre(rs.getString(13));
	                    c.setApellido(rs.getString(14));
	                    Cliente admin = new Cliente();
	                    admin.setId(rs.getInt(10));
	                    admin.setNombre(rs.getString(17));
	                    admin.setApellido(rs.getString(18));
	                    Libro l = new Libro();
	                    l.setIdLibro(rs.getInt(9));
	                    l.setTitulo(rs.getString(16));
	                    Ejemplar e = new Ejemplar();
	                    e.setIdEjemplar(8);
	                    e.setLibro(l);
	                    Prestamo p = new Prestamo();
	                    p.setCliente(c);
	                    p.setEjemplar(e);
	                    p.setFechaRealizacion(rs.getObject(6,LocalDate.class));
	                    p.setEstado(EstadoPrestamo.valueOf(rs.getString(12)));
	                    Review r = new Review();
	                    r.setIdReview(rs.getInt(1));
	                    r.setFechaReview(rs.getObject(2, LocalDate.class));
	                    r.setPuntaje(rs.getInt(3));
	                    r.setDescripcion(rs.getString(4));
	                    r.setEstado_review(EstadoReviewEnum.valueOf(rs.getString(5)));
	                    r.setObservacion_rechazo(rs.getString(11));
	                    r.setAdministrativo(admin);
	                    r.setPrestamo(p);
	                    reviews.add(r);
	                }
	            }

	        } catch (SQLException e) {
	            throw new AppException("Error: no se pudieron recuperar las reseñas");
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
	        return reviews;
	    }
	
	public void save(Review r) throws AppException {
		PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"insert into review(fechaReview, puntaje, descripcion, estado, fechaRealizacion, idCliente, idEjemplar, idLibro,) values(?,?,?,?,?,?,?,?)",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			
			stmt.setObject(1, LocalDate.now());
			stmt.setInt(2, r.getPuntaje());
			stmt.setString(3, r.getDescripcion());
			stmt.setString(4, EstadoReviewEnum.PENDIENTE_REVISION.name());
			stmt.setObject(5, r.getPrestamo().getFechaRealizacion());
			stmt.setInt(6, r.getPrestamo().getCliente().getId());
			stmt.setInt(7, r.getPrestamo().getEjemplar().getIdEjemplar());
			stmt.setInt(8, r.getPrestamo().getEjemplar().getLibro().getIdLibro());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                r.setIdReview(keyResultSet.getInt(1));
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo registrar la Reseña");
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
	
	public LinkedList<Review> getByLibro(Libro libro) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        LinkedList<Review> reviews = new LinkedList<>();
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select res.idReview, res.fechaReview, res.puntaje, res.descripcion, res.estado, res.fechaRealizacion, res.idCliente, res.idEjemplar, res.idLibro, res.idAdmin, res.motivo_rechazo, pre.estado, c.nombre, c.apellido, c.mail, lib.titulo, adm.nombre, adm.apellido\r\n"
					+ "from review res \r\n"
					+ "inner join prestamo pre on pre.fechaRealizacion=res.fechaRealizacion and pre.idCliente=res.idCliente and pre.idEjemplar=res.idEjemplar and pre.idLibro=res.idLibro\r\n"
					+ "inner join cliente c on c.id=res.idCliente\r\n"
					+ "inner join libro lib on lib.idLibro=res.idLibro\r\n"
					+ "inner join cliente adm on res.idAdmin=adm.id\r\n"
					+ "where res.idLibro=? and res.estado=?"
					);
			stmt.setString(1, Integer.toString(libro.getIdLibro()));
			stmt.setString(2, EstadoReviewEnum.PUBLICADA.name());
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                	Cliente c = new Cliente();
                    c.setId(rs.getInt(7));
                    c.setMail(rs.getString(15));
                    c.setNombre(rs.getString(13));
                    c.setApellido(rs.getString(14));
                    Cliente admin = new Cliente();
                    admin.setId(rs.getInt(10));
                    admin.setNombre(rs.getString(17));
                    admin.setApellido(rs.getString(18));
                    Libro l = new Libro();
                    l.setIdLibro(rs.getInt(9));
                    l.setTitulo(rs.getString(16));
                    Ejemplar e = new Ejemplar();
                    e.setIdEjemplar(8);
                    e.setLibro(l);
                    Prestamo p = new Prestamo();
                    p.setCliente(c);
                    p.setEjemplar(e);
                    p.setFechaRealizacion(rs.getObject(6,LocalDate.class));
                    p.setEstado(EstadoPrestamo.valueOf(rs.getString(12)));
                    Review r = new Review();
                    r.setIdReview(rs.getInt(1));
                    r.setFechaReview(rs.getObject(2, LocalDate.class));
                    r.setPuntaje(rs.getInt(3));
                    r.setDescripcion(rs.getString(4));
                    r.setEstado_review(EstadoReviewEnum.valueOf(rs.getString(5)));
                    r.setObservacion_rechazo(rs.getString(11));
                    r.setAdministrativo(admin);
                    r.setPrestamo(p);
                    reviews.add(r);

                }
            }
		} catch (SQLException e) {
			throw new AppException("Error: no se pieron recuperar las reseñas del libro ID: "+libro.getIdLibro());
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
			}
		}
		
		return reviews;
	    }
	
	public Review getByPrestamo(Prestamo prestamo) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        Review r = new Review();
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select res.idReview, res.fechaReview, res.puntaje, res.descripcion, res.estado, res.fechaRealizacion, res.idCliente, res.idEjemplar, res.idLibro, res.idAdmin, res.motivo_rechazo, pre.estado, c.nombre, c.apellido, c.mail, lib.titulo, adm.nombre, adm.apellido\r\n"
					+ "from review res \r\n"
					+ "inner join prestamo pre on pre.fechaRealizacion=res.fechaRealizacion and pre.idCliente=res.idCliente and pre.idEjemplar=res.idEjemplar and pre.idLibro=res.idLibro\r\n"
					+ "inner join cliente c on c.id=res.idCliente\r\n"
					+ "inner join libro lib on lib.idLibro=res.idLibro\r\n"
					+ "inner join cliente adm on res.idAdmin=adm.id\r\n"
					+ "where res.fechaRealizacion=? and res.idCliente=? and res.idEjemplar=? and res.idLibro=?"
					);
			stmt.setObject(1, prestamo.getFechaRealizacion());
			stmt.setInt(2, prestamo.getCliente().getId());
			stmt.setInt(3, prestamo.getEjemplar().getIdEjemplar());
			stmt.setInt(4, prestamo.getEjemplar().getLibro().getIdLibro());
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                	Cliente c = new Cliente();
                    c.setId(rs.getInt(7));
                    c.setMail(rs.getString(15));
                    c.setNombre(rs.getString(13));
                    c.setApellido(rs.getString(14));
                    Cliente admin = new Cliente();
                    admin.setId(rs.getInt(10));
                    admin.setNombre(rs.getString(17));
                    admin.setApellido(rs.getString(18));
                    Libro l = new Libro();
                    l.setIdLibro(rs.getInt(9));
                    l.setTitulo(rs.getString(16));
                    Ejemplar e = new Ejemplar();
                    e.setIdEjemplar(8);
                    e.setLibro(l);
                    Prestamo p = new Prestamo();
                    p.setCliente(c);
                    p.setEjemplar(e);
                    p.setFechaRealizacion(rs.getObject(6,LocalDate.class));
                    p.setEstado(EstadoPrestamo.valueOf(rs.getString(12)));
                    r.setIdReview(rs.getInt(1));
                    r.setFechaReview(rs.getObject(2, LocalDate.class));
                    r.setPuntaje(rs.getInt(3));
                    r.setDescripcion(rs.getString(4));
                    r.setEstado_review(EstadoReviewEnum.valueOf(rs.getString(5)));
                    r.setObservacion_rechazo(rs.getString(11));
                    r.setAdministrativo(admin);
                    r.setPrestamo(p);
                    

                }
            }
		} catch (SQLException e) {
			throw new AppException("Error: no se pudo recuperar reseña del prestamo");
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
			}
		}
		
		return r;
	    }
	
	public void alterState(Review r) throws AppException{
    	PreparedStatement stmt = null;
    	ResultSet keyResultSet = null;
    	try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"update review set estado=?, idAdmin=?, motivo_rechazo=? where idReview=? and fechaRealizacion=? and idCliente=? and idEjemplar=? and idLibro=?;",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, EstadoReviewEnum.PUBLICADA.name());
			stmt.setInt(2, r.getAdministrativo().getId());
			stmt.setString(3, r.getObservacion_rechazo());
			stmt.setInt(2, r.getIdReview());
			stmt.setObject(3, r.getPrestamo().getFechaRealizacion());
			stmt.setInt(4, r.getPrestamo().getCliente().getId());
			stmt.setInt(5, r.getPrestamo().getEjemplar().getIdEjemplar());
			stmt.setInt(6, r.getPrestamo().getEjemplar().getLibro().getIdLibro());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
            	r.setIdReview(keyResultSet.getInt(1));;
            }

			
		}  catch (SQLException e) {
			throw new AppException("Error: no se pudo modificar la reseña requerida");
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
	
	public LinkedList<Review> getByCliente(Cliente cli) throws AppException{
		PreparedStatement stmt = null;
        ResultSet rs = null;
        LinkedList<Review> reviews = new LinkedList<>();
        try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select res.idReview, res.fechaReview, res.puntaje, res.descripcion, res.estado, res.fechaRealizacion, res.idCliente, res.idEjemplar, res.idLibro, res.idAdmin, res.motivo_rechazo, pre.estado, c.nombre, c.apellido, c.mail, lib.titulo, adm.nombre, adm.apellido\r\n"
					+ "from review res \r\n"
					+ "inner join prestamo pre on pre.fechaRealizacion=res.fechaRealizacion and pre.idCliente=res.idCliente and pre.idEjemplar=res.idEjemplar and pre.idLibro=res.idLibro\r\n"
					+ "inner join cliente c on c.id=res.idCliente\r\n"
					+ "inner join libro lib on lib.idLibro=res.idLibro\r\n"
					+ "inner join cliente adm on res.idAdmin=adm.id\r\n"
					+ "where res.idCliente=?"
					);
			stmt.setString(1, Integer.toString(cli.getId()));
			rs=stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                	Cliente c = new Cliente();
                    c.setId(rs.getInt(7));
                    c.setMail(rs.getString(15));
                    c.setNombre(rs.getString(13));
                    c.setApellido(rs.getString(14));
                    Cliente admin = new Cliente();
                    admin.setId(rs.getInt(10));
                    admin.setNombre(rs.getString(17));
                    admin.setApellido(rs.getString(18));
                    Libro l = new Libro();
                    l.setIdLibro(rs.getInt(9));
                    l.setTitulo(rs.getString(16));
                    Ejemplar e = new Ejemplar();
                    e.setIdEjemplar(8);
                    e.setLibro(l);
                    Prestamo p = new Prestamo();
                    p.setCliente(c);
                    p.setEjemplar(e);
                    p.setFechaRealizacion(rs.getObject(6,LocalDate.class));
                    p.setEstado(EstadoPrestamo.valueOf(rs.getString(12)));
                    Review r = new Review();
                    r.setIdReview(rs.getInt(1));
                    r.setFechaReview(rs.getObject(2, LocalDate.class));
                    r.setPuntaje(rs.getInt(3));
                    r.setDescripcion(rs.getString(4));
                    r.setEstado_review(EstadoReviewEnum.valueOf(rs.getString(5)));
                    r.setObservacion_rechazo(rs.getString(11));
                    r.setAdministrativo(admin);
                    r.setPrestamo(p);
                    reviews.add(r);

                }
            }
		} catch (SQLException e) {
			throw new AppException("Error: no se pieron recuperar las reseñas del cliente ID: "+cli.getId());
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				throw new AppException("Error: no se pudo cerrar la conexion a Base de Datos");
			}
		}
		
		return reviews;
	    }
	
}
	     

