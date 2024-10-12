package logic;
import java.util.LinkedList;
import data.*;
import entidades.*;

public class CRUD_ejemplar {
	private DataEjemplar de;

	public CRUD_ejemplar() {
		de = new DataEjemplar();
	}
	
	public void save (Ejemplar ej) throws AppException{
		try {
    		de.save(ej);
		} catch (AppException e) {
			throw e;
		}
	}
	
	public LinkedList<Ejemplar> getAll() throws AppException{
		try {
			return de.getAll();
		} catch (AppException e) {
			throw e;
		}
	}
	
	public void delete(Ejemplar ej) throws AppException{
		try {
			de.deleteLogic(ej);
		} catch (AppException e) {
			throw e;
		}
	}
	
	public LinkedList<Ejemplar> getEjemplaresLibres(Libro l) throws AppException{
		try {
			return de.getEjemplaresLibres(l);
		} catch (AppException e) {
			throw e;
		}
	}
	
	public void update(Ejemplar ej) throws AppException {
		try {
			de.update(ej);
		} catch (AppException e) {
			throw e;
		}
	}

}
