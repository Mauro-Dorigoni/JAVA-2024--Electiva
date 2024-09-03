package entidades;
import java.time.*;

public class Categoria_libro {
	private int idCategoria;
	private String nombre_categoria;
	private String descripcion_ampliada;
	private LocalDate fechaBaja;
	private String idPhoto;
	public int getIdCategoria() {
		return idCategoria;
	}
	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}
	public String getNombre_categoria() {
		return nombre_categoria;
	}
	public void setNombre_categoria(String nombre_categoria) {
		this.nombre_categoria = nombre_categoria;
	}
	public String getDescripcion_apliada() {
		return descripcion_ampliada;
	}
	public void setDescripcion_apliada(String descripcion_apliada) {
		this.descripcion_ampliada = descripcion_apliada;
	}
	
	@Override
	public String toString() {
		return "\nCategoria [id= "+ idCategoria+", nombre= "+nombre_categoria+", descripcion= "+descripcion_ampliada+"]";
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
}
