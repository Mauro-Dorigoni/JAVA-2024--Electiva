package entities.ejercicio1;

import java.util.LinkedList;

public class ServicioCatering {
	private String nombre;
	private String menu;
	private double	precioMenuIndividual;
	private LinkedList<Mesero> meseros;
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public double getPrecioMenuIndividual() {
		return precioMenuIndividual;
	}
	public void setPrecioMenuIndividual(double precioMenuIndividual) {
		this.precioMenuIndividual = precioMenuIndividual;
	}
	public LinkedList<Mesero> getMeseros() {
		return meseros;
	}
	public void setMeseros(LinkedList<Mesero> meseros) {
		this.meseros = meseros;
	}
	public double getCostoMeseros(double hsTrabajadas) {
		double costoMeserosCatering = 0.0;
		for (Mesero mesero : meseros) {
			costoMeserosCatering = costoMeserosCatering + mesero.getCostoMesero(hsTrabajadas);
		}
		return costoMeserosCatering;
	}
	public double getCostoCatering(double hsTrabajadas, int cantInvitados) {
		return this.getPrecioMenuIndividual()*cantInvitados + this.getCostoMeseros(hsTrabajadas);
	}
	
}
