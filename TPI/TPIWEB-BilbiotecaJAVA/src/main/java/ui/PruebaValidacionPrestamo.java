package ui;
import entidades.*;
import logic.*;
import data.*;
public class PruebaValidacionPrestamo {

	public PruebaValidacionPrestamo() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		DataPrestamo dataprestamo = new DataPrestamo();
		Cliente cliente = new Cliente();
		cliente.setId(2);
		try {
			if(dataprestamo.validatePrestamosVencidosCliente(cliente)) {System.out.println("No tiene vencidos");}
			else {System.out.println("Tiene Vencidos");}
		} catch (AppException e) {
			e.printStackTrace();
		}
		

	}

}
