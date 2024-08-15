package entities.ejercicio2;
import java.time.*;

public class Pago {
	private double importe;
	private LocalDate fechaPago;
	
	public double getImporte() {
		return importe;
	}
	public void setImporte(double importe) {
		this.importe = importe;
	}
	public LocalDate getFechaPago() {
		return fechaPago;
	}
	public void setFechaPago(LocalDate fechaPago) {
		this.fechaPago = fechaPago;
	}
	
	

}
