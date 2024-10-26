package logic;
import java.util.LinkedList;
import data.*;
import entidades.*;

public class CRUD_libro {
	private DataLibro dl;
	private DataReview dr;
	public CRUD_libro() {
        dl = new DataLibro();  
        dr = new DataReview();
    }
	public void save(Libro l) throws AppException{
		try {
			dl.save(l);
		} catch (AppException e) {
			throw e;
		}
	}
	public LinkedList<Libro> getAll() throws AppException{
		try {
			LinkedList<Libro>libros = dl.getAll();
			for (Libro libro : libros) {
				libro.setReviews(dr.getByLibro(libro));
				libro.setPuntaje();
			}
			return libros;
		} catch (AppException e) {
			throw e;
		}
	}
	public Libro getOne(Libro l) throws AppException{
		try {
			Libro libro = dl.getOne(l);
			libro.setReviews(dr.getByLibro(libro));
			libro.setPuntaje();
			return libro;
		} catch (AppException e) {
			throw e;
		}

	}
	public void update(Libro l) throws AppException{
		try {
			dl.update(l);
		} catch (AppException e) {
			throw e;
		}
	}
	public void delete (Libro l) throws AppException{
		try {
			dl.deleteLogic(l);
		} catch (AppException e) {
			throw e;
		}
	}
	public LinkedList<Libro> search (Libro l) throws AppException{
		try {
			LinkedList<Libro> libros = dl.search(l);
			for (Libro libro2 : libros) {
				libro2.setReviews(dr.getByLibro(libro2));
				libro2.setPuntaje();
			}
			return libros;
		} catch (AppException e) {
			throw e;
		}
	}
}
