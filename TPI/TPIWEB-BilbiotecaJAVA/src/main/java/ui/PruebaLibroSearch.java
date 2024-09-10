package ui;
import entidades.*;
import logic.*;
import java.util.LinkedList;

public class PruebaLibroSearch {

	public PruebaLibroSearch() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		Libro busqueda = new Libro();
		busqueda.setTitulo("harry");
		busqueda.setSumario("harry");
		CRUD_libro cl = new CRUD_libro();
		try {
			LinkedList<Libro> lista = cl.search(busqueda);
			for (Libro libro : lista) {
				System.out.println(libro.getIdLibro());
			}
		} catch (AppException e) {
			e.printStackTrace();
		}
		
	}

}
