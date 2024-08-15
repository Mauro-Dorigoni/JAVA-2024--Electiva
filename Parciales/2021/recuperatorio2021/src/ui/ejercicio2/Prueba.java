package ui.ejercicio2;
import java.util.LinkedList;
import java.time.*;
import entities.ejercicio2.*;

public class Prueba {

	public static void main(String[] args) {
		LinkedList<Pago> pagos = new LinkedList<>(); 
		Pago p1 = new Pago();
		p1.setImporte(1000);
		pagos.add(p1);
		
		Pago p2 = new Pago();
		p2.setImporte(500);
		p2.setFechaPago(LocalDate.now());
		pagos.add(p2);
		
		Pago p3 = new Pago();
		p3.setImporte(750);
		pagos.add(p3);
		
		Cliente c = new Cliente();
		System.out.println(c.getTotal(pagos));

	}

}
