package entidades;
import java.time.*;

public class Prestamo {
	private LocalDate fechaRealizacion;
	private String estado;
	private Cliente cliente;
	private Ejemplar ejemplar;
	private int idLibro;

	public LocalDate getFechaRealizacion() {
		return fechaRealizacion;
	}
	public void setFechaRealizacion(LocalDate fechaRealizacion) {
		this.fechaRealizacion = fechaRealizacion;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
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
	public int getIdLibro() {
		return idLibro;
	}
	public void setIdLibro(int idLibro) {
		this.idLibro = idLibro;
	}
	
}
