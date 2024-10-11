package entidades;
import java.time.*;

public class Prestamo {
	private LocalDate fechaRealizacion;
	private EstadoPrestamo estado;
	private Cliente cliente;
	private Ejemplar ejemplar;

	public LocalDate getFechaRealizacion() {
		return fechaRealizacion;
	}
	public void setFechaRealizacion(LocalDate fechaRealizacion) {
		this.fechaRealizacion = fechaRealizacion;
	}
	public EstadoPrestamo getEstado() {
		return estado;
	}
	public void setEstado(EstadoPrestamo estado) {
		this.estado = estado;
	}
	public Cliente getCliente() {
		return cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	public Ejemplar getEjemplar() {
		return ejemplar;
	}
	public void setEjemplar(Ejemplar ejemplar) {
		this.ejemplar = ejemplar;
	}
	
}
