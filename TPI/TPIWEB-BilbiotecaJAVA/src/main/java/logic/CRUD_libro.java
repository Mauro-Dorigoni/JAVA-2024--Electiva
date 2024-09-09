package logic;
import java.util.LinkedList;
import data.*;
import entidades.*;

public class CRUD_libro {
	private DataLibro dl;
	public CRUD_libro() {
        dl = new DataLibro();  
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
			return dl.getAll();
		} catch (AppException e) {
			throw e;
		}
	}
	public Libro getOne(Libro l) throws AppException{
		try {
			return dl.getOne(l);
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
}
