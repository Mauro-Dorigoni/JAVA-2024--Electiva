package entities.ejercicio2;

import java.util.LinkedList;

public class Alumno {
	private String nombre;
	private String apellido;
	private String legajo;
	private LinkedList<Double> notasExamen;
	private LinkedList<Double> notasTp;
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
	public String getLegajo() {
		return legajo;
	}
	public void setLegajo(String legajo) {
		this.legajo = legajo;
	}
	public LinkedList<Double> getNotasExamen() {
		return notasExamen;
	}
	public void setNotasExamen(LinkedList<Double> notasExamen) {
		this.notasExamen = notasExamen;
	}
	public LinkedList<Double> getNotasTp() {
		return notasTp;
	}
	public void setNotasTp(LinkedList<Double> notasTp) {
		this.notasTp = notasTp;
	}
	public String getCondiciion() {
		double avgExamen = 0.0;
		double avgTp = 0.0;
		
		for (Double notaE : notasExamen) {
			avgExamen = avgExamen + notaE;
		}
		avgExamen = avgExamen/this.getNotasExamen().size();
		
		for (Double notaT : notasTp) {
			avgTp = avgTp + notaT;
		}
		avgTp = avgTp/this.getNotasTp().size();
		
		if(avgExamen < 6.0) {return "Libre";}
		else {
			if(avgTp < 6.0) {return "Regular";}
			
			else return "Aprobado";
		}
		
	}
}
