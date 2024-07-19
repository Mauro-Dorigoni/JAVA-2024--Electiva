package entidades;

public class prestamo {
	private String fechaRealizacion;
	private String estado;
	private int idCliente;
	private int idEjemplar;
	private int idLibro;
	public String getFechaRealizacion() {
		return fechaRealizacion;
	}
	public void setFechaRealizacion(String fechaRealizacion) {
		this.fechaRealizacion = fechaRealizacion;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public int getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}
	public int getIdEjemplar() {
		return idEjemplar;
	}
	public void setIdEjemplar(int idEjemplar) {
		this.idEjemplar = idEjemplar;
	}
	public int getIdLibro() {
		return idLibro;
	}
	public void setIdLibro(int idLibro) {
		this.idLibro = idLibro;
	}
	
}
