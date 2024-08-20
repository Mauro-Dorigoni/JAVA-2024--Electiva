package ui;
import entities.ejercicio1.*;
import java.util.*;
import java.time.*;

public class Pruebaej1 {

	public static void main(String[] args) {
		Locacion loc = new Locacion();
		loc.setPrecio(1000);
		
		LinkedList<Invitado> invitados = new LinkedList<>();
		Invitado i1 = new Invitado();
		invitados.add(i1);
		Invitado i2 = new Invitado();
		invitados.add(i2);
		
		LinkedList<Mesero> meseros = new LinkedList<>();
		Mesero m1 = new Mesero();
		m1.setPrecioPorHora(5);
		meseros.add(m1);
		Mesero m2 = new Mesero();
		m2.setPrecioPorHora(10);
		meseros.add(m2);
		
		ServicioCatering catering = new ServicioCatering();
		catering.setPrecioMenuIndividual(100);
		catering.setMeseros(meseros);

		
		EventoFacturadoPorInvitado e = new EventoFacturadoPorInvitado();
		e.setInvitados(invitados);
		e.setLocacionEvento(loc);
		e.setServicioCatering(catering);
		e.setPrecioPorInvitado(500);
		e.setInvitadosMinimo(3);
		System.out.println(e.getPrecioFinal());
		
	}

}
