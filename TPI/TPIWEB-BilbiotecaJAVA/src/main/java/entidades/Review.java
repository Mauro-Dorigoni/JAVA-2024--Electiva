package entidades;

public class Review extends Prestamo{
	private int idReview;
	private String fechaReview;
	private int puntaje;
	private String descripcion;
	private String estado_review;
	public int getIdReview() {
		return idReview;
	}
	public void setIdReview(int idReview) {
		this.idReview = idReview;
	}
	public String getFechaReview() {
		return fechaReview;
	}
	public void setFechaReview(String fechaReview) {
		this.fechaReview = fechaReview;
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
