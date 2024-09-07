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

}
