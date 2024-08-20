package entities.ejercicio1;
import java.time.*;
import java.util.LinkedList;

public abstract class Evento {
	private String nombre;
	private LocalDate fecha;
	private double duracion;
	private Locacion locacionEvento;
	private LinkedList<Invitado> invitados;
	private ServicioCatering servicioCatering;
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public LocalDate getFecha() {
		return fecha;
	}
	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
	}
	public double getDuracion() {
		return duracion;
	}
	public void setDuracion(double duracion) {
		this.duracion = duracion;
	}
	public Locacion getLocacionEvento() {
		return locacionEvento;
	}
	public void setLocacionEvento(Locacion locacionEvento) {
		this.locacionEvento = locacionEvento;
	}
	public LinkedList<Invitado> getInvitados() {
		return invitados;
	}
	public void setInvitados(LinkedList<Invitado> invitados) {
		this.invitados = invitados;
	}
	public ServicioCatering getServicioCatering() {
		return servicioCatering;
	}
	public void setServicioCatering(ServicioCatering servicioCatering) {
		this.servicioCatering = servicioCatering;
	}
	abstract public double getCostoEvento();
	
	public double getPrecioFinal() {
		return this.getCostoEvento() + this.getLocacionEvento().getPrecio() + this.getServicioCatering().getCostoCatering(duracion, invitados.size());
	}
	

	
}
