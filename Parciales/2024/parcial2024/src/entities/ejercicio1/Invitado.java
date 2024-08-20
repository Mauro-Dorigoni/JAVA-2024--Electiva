package entities.ejercicio1;

import java.util.LinkedList;

public class Invitado {
	private int id;
	private String nombreCompleto;
	private LinkedList<Evento> eventos;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombreCompleto() {
		return nombreCompleto;
	}
	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}
	public LinkedList<Evento> getEventos() {
		return eventos;
	}
	public void setEventos(LinkedList<Evento> eventos) {
		this.eventos = eventos;
	}
	
}
