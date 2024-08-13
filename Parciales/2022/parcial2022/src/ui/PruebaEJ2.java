package ui;
import entities.*;
import java.util.*;

public class PruebaEJ2 {

	public static void main(String[] args) {
		LinkedList<Expenditure> lista = new LinkedList<>();
		
		Expenditure e1 = new Expenditure();
		e1.setAmount(1000);
		e1.setReimbursable(true);
		lista.add(e1);
		
		Expenditure e2 = new Expenditure();
		e2.setAmount(1000);
		e2.setReimbursable(false);
		lista.add(e2);
		
		ClaseEj2 logica = new ClaseEj2();
		System.out.println("Hay que devolver:"+logica.getReinbursement(lista, 50));
	}

}
