package entities.ejercicio2;

import java.util.LinkedList;

public class Tecnico {
	private String nombre;
	private String apellido;
	private LinkedList<Tarea> tareas;
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public LinkedList<Tarea> getTareas() {
		return tareas;
	}
	public void setTareas(LinkedList<Tarea> tareas) {
		this.tareas = tareas;
	}
	
	public double getHsTareasTerminadas() {
		double hsTareasTerminadas = 0.0;
		for (Tarea tarea : tareas) {
			if(tarea.isTerminada()) {
				hsTareasTerminadas = hsTareasTerminadas + tarea.getDuracionHs();
			}
		}
		return hsTareasTerminadas;
	}
	
}
