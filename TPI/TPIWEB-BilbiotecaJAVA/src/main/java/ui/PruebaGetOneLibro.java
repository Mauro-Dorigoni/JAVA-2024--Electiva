package ui;
import entidades.*;
import logic.*;
import java.util.*;

public class PruebaGetOneLibro {

	public PruebaGetOneLibro() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) throws AppException {
		CRUD_libro cl = new CRUD_libro();
		LinkedList<Libro> libros = new LinkedList<>();
		for (int i = 7; i < 22; i++) {
			Libro l = new Libro();
			l.setIdLibro(i);
			libros.add(cl.getOne(l));
		}
		for (Libro libro : libros) {
			System.out.println("Libro: "+libro.getTitulo()+" Categoria: "+libro.getCategoria().getNombre_categoria());
		}
	}

}
