package ui;
import data.*;
import entidades.*;
import java.util.LinkedList;

public class PruebaEjemplaresLibres {

	public PruebaEjemplaresLibres() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		DataPrestamo dp = new DataPrestamo();
		DataEjemplar de = new DataEjemplar();
		Libro l = new Libro();
		l.setIdLibro(7);
		try {
			if(dp.validateEjemplaresLibres(l)) {
				LinkedList<Ejemplar> ejemplareslibres = de.getEjemplaresLibres(l);
				if(ejemplareslibres.isEmpty()) {System.out.println("Fail");}
				else {
				for (Ejemplar ejemplar : ejemplareslibres) {
					System.out.println(ejemplar.getEditorial());
				}}
			}
			else {System.out.println("no exito");}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
