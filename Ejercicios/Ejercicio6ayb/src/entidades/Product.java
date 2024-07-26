package entidades;

public class Product {
	private int id;
	private String nombre;
	private String descripcion;
	private float precio;
	private int stock;
	private boolean envio;
	private String fechaBaja;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public float getPrecio() {
		return precio;
	}
	public void setPrecio(float precio) {
		this.precio = precio;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public boolean isEnvio() {
		return envio;
	}
	public void setEnvio(boolean envio) {
		this.envio = envio;
	}
	public String getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
	
	@Override
	public String toString() {
		return "\nProducto [id= "+id+ " nombre: " +nombre+ " descripcion: "+descripcion+" precio: " +precio+" stock: " +stock+ " envio: "+envio+" fechaBaja: " +fechaBaja+"]";
	}
}
