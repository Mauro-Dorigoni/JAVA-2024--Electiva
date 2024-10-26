package entidades;
import java.time.*;

public class Review{
	private int idReview;
	private LocalDate fechaReview;
	private int puntaje;
	private String descripcion;
	private Prestamo prestamo;
	private EstadoReviewEnum estado_review;
	private Cliente administrativo;
	private String observacion_rechazo;
	
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
	public EstadoReviewEnum getEstado_review() {
		return estado_review;
	}
	public void setEstado_review(EstadoReviewEnum estado_review) {
		this.estado_review = estado_review;
	}
	public Prestamo getPrestamo() {
		return prestamo;
	}
	public void setPrestamo(Prestamo prestamo) {
		this.prestamo = prestamo;
	}
	public String getObservacion_rechazo() {
		return observacion_rechazo;
	}
	public void setObservacion_rechazo(String observacion_rechazo) {
		this.observacion_rechazo = observacion_rechazo;
	}
	
}
