package entities.ejercicio2;

public class Tarea {
	private String nombre;
	private String descripcion;
	private double duracionHs;
	private boolean terminada;
	
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
	public double getDuracionHs() {
		return duracionHs;
	}
	public void setDuracionHs(double duracionHs) {
		this.duracionHs = duracionHs;
	}
	public boolean isTerminada() {
		return terminada;
	}
	public void setTerminada(boolean terminada) {
		this.terminada = terminada;
	}
	
}
