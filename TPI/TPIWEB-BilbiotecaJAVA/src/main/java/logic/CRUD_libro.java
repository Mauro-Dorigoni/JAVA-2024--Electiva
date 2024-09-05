package logic;
import java.util.LinkedList;
import data.*;
import entidades.*;

public class CRUD_libro {
	private DataLibro dl;
	public CRUD_libro() {
        dl = new DataLibro();  
    }
	public void save(Libro l) {
		dl.save(l);
	}
	public LinkedList<Libro> getAll(){
		return dl.getAll();
	}
	public Libro getOne(Libro l) {
		return dl.getOne(l);
	}
	public void update(Libro l) {
		dl.update(l);
	}
	public void delete (Libro l) {
		dl.deleteLogic(l);
	}
}
