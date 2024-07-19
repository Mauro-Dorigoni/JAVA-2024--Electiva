package entidades;

public class categoria_libro {
	private int idCategoria;
	private String nombre_categoria;
	private String descripcion_apliada;
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
		return descripcion_apliada;
	}
	public void setDescripcion_apliada(String descripcion_apliada) {
		this.descripcion_apliada = descripcion_apliada;
	}
}
