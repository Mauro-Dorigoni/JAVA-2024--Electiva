package ui;
import data.*;
import entidades.*;
import java.time.*;

public class PruebaEstadoPrestamo {

	public PruebaEstadoPrestamo() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		Cliente cliente = new Cliente();
		cliente.setId(2);
		Libro libro = new Libro();
		libro.setIdLibro(7);
		Ejemplar ejemplar = new Ejemplar();
		ejemplar.setIdEjemplar(2);
		ejemplar.setLibro(libro);
		
		Prestamo prestamo = new Prestamo();
		prestamo.setCliente(cliente);
		prestamo.setEjemplar(ejemplar);
		prestamo.setFechaRealizacion(LocalDate.parse("2024-09-11"));
		prestamo.setEstado(EstadoPrestamo.PENDIENTE_DEVOLUCION);
		
		DataPrestamo dp = new DataPrestamo();
		try {
			dp.update(prestamo);
		} catch (AppException e) {
			e.printStackTrace();
		}
	}

}
