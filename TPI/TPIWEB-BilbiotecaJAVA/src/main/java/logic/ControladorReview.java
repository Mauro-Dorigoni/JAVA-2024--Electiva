package logic;
import data.*;
import entidades.*;
import java.util.LinkedList;

public class ControladorReview {

	private DataReview dr;
	
	public ControladorReview() {
		dr = new DataReview();
	}
	
	public LinkedList<Review> getAll() throws AppException{
		try {
			return dr.getAll();
		} catch (AppException e) {
			throw e;
		}
	}
	
	public LinkedList<Review> getByLibro(Libro l) throws AppException {
		try {
			return dr.getByLibro(l);
		} catch (AppException e) {
			throw e;
		}
	}
	public Review getbyPrestamo(Prestamo p) throws AppException{
		try {
			return dr.getByPrestamo(p);
		} catch (AppException e) {
			throw e;
		}
	}
	public LinkedList<Review> getByCliente(Cliente c) throws AppException {
		try {
			return dr.getByCliente(c);
		} catch (AppException e) {
			throw e;
		}
	}
	public void save(Review r) throws AppException{
		try {
			dr.save(r);
		} catch (AppException e) {
			throw e;
		}
	}
	public void alterState(Review r) throws AppException {
		try {
			dr.alterState(r);
		} catch (AppException e) {
			throw e;
		}
	}
}
