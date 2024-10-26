package entidades;
import java.time.*;
import java.util.LinkedList;

public class Libro {
	private int idLibro;
	private Categoria_libro categoria;
	private String autor;
	private String ISBN;
	private String sumario;
	private String titulo;
	private LocalDate fechaBaja; 
	private String idPhoto;
	private LinkedList<Review> reviews;
	private double puntaje;
	
	public int getIdLibro() {
		return idLibro;
	}
	public void setIdLibro(int idLibro) {
		this.idLibro = idLibro;
	}

	public Categoria_libro getCategoria() {
		return categoria;
	}
	public void setCategoria(Categoria_libro categoria) {
		this.categoria = categoria;
	}
	public String getAutor() {
		return autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public String getSumario() {
		return sumario;
	}
	public void setSumario(String sumario) {
		this.sumario = sumario;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public LocalDate getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(LocalDate fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
	public String getIdPhoto() {
		return idPhoto;
	}
	public void setIdPhoto(String idPhoto) {
		this.idPhoto = idPhoto;
	}
	public LinkedList<Review> getReviews() {
		return reviews;
	}
	public void setReviews(LinkedList<Review> reviews) {
		this.reviews = reviews;
	}
	public double getPuntaje() {
		return puntaje;
	}
	public void setPuntaje() {
		this.puntaje = reviews.stream()
		                .mapToInt(Review::getPuntaje) // Extrae los puntajes
		                .average()                    // Calcula el promedio
		                .orElse(0.0); 
	}
}
