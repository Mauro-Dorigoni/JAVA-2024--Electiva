package entities.ejercicio1;

import java.util.LinkedList;

public class Mesero {
	private String nombreCompleto;
	private double precioPorHora;
	private LinkedList<ServicioCatering> servicios;
	
	public String getNombreCompleto() {
		return nombreCompleto;
	}
	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}
	public double getPrecioPorHora() {
		return precioPorHora;
	}
	public void setPrecioPorHora(double precioPorHora) {
		this.precioPorHora = precioPorHora;
	}
	public LinkedList<ServicioCatering> getServicios() {
		return servicios;
	}
	public void setServicios(LinkedList<ServicioCatering> servicios) {
		this.servicios = servicios;
	}
	public double getCostoMesero(double hsTrabajadas) {
		return this.precioPorHora*hsTrabajadas;
	}
	
}
