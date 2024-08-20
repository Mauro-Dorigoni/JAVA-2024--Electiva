package ui;
import java.util.*;
import entities.ejercicio2.*;

public class PruebaEj2 {

	public static void main(String[] args) {
		LinkedList<Tarea> tareas = new LinkedList<>();
		Tarea t1 = new Tarea();
		t1.setDuracionHs(5.0);
		t1.setTerminada(true);
		tareas.add(t1);
		Tarea t2 = new Tarea();
		t2.setDuracionHs(50.0);
		t2.setTerminada(false);
		tareas.add(t2);
		Tarea t3 = new Tarea();
		t3.setDuracionHs(10);
		t3.setTerminada(true);
		tareas.add(t3);
		
		Tecnico tecnico = new Tecnico();
		tecnico.setTareas(tareas);
		System.out.println(tecnico.getHsTareasTerminadas());
	}

}
