package entidades;
import java.time.*;

public class Ejemplar extends Libro {
	private int idEjemplar;
	private int nroEdicion;
	private String fechaEdicion;
	private int cantPaginas;
	private String editorial;
	private LocalDate fechaBaja;
	
	public int getIdEjemplar() {
		return idEjemplar;
	}
	public void setIdEjemplar(int idEjemplar) {
		this.idEjemplar = idEjemplar;
	}
	public int getNroEdicion() {
		return nroEdicion;
	}
	public void setNroEdicion(int nroEdicion) {
		this.nroEdicion = nroEdicion;
	}
	public String getFechaEdicion() {
		return fechaEdicion;
	}
	public void setFechaEdicion(String fechaEdicion) {
		this.fechaEdicion = fechaEdicion;
	}
	public int getCantPaginas() {
		return cantPaginas;
	}
	public void setCantPaginas(int cantPaginas) {
		this.cantPaginas = cantPaginas;
	}
	public String getEditorial() {
		return editorial;
	}
	public void setEditorial(String editorial) {
		this.editorial = editorial;
	}
	public LocalDate getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(LocalDate fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
}
