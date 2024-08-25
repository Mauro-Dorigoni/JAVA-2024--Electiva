package entidades;
import java.time.*;

public class Review extends Prestamo{
	private int idReview;
	private LocalDate fechaReview;
	private int puntaje;
	private String descripcion;
	private String estado_review;
	private Cliente administrativo;
	
	public LocalDate getFechaReview() {
		return fechaReview;
	}
	public void setFechaReview(LocalDate fechaReview) {
		this.fechaReview = fechaReview;
	}
	public Cliente getAdministrativo() {
		return administrativo;
	}
	public void setAdministrativo(Cliente administrativo) {
		this.administrativo = administrativo;
	}
	public int getIdReview() {
		return idReview;
	}
	public void setIdReview(int idReview) {
		this.idReview = idReview;
	}

	public int getPuntaje() {
		return puntaje;
	}
	public void setPuntaje(int puntaje) {
		this.puntaje = puntaje;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getEstado_review() {
		return estado_review;
	}
	public void setEstado_review(String estado_review) {
		this.estado_review = estado_review;
	}
	
}
