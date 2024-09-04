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
}
