package ui;

import entidades.*;
import data.*;
import logic.*;
import java.util.LinkedList;
import java.time.LocalDate;
import java.util.*;

public class PrestamosReviews {

	public PrestamosReviews() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		Cliente cliente = new Cliente(); cliente.setId(2); 
		ControladorPrestamo cp =new ControladorPrestamo(); 
		DataReview dr = new DataReview();
		
		try { 
			LinkedList<Prestamo> prestamos = cp.getPrestamosCliente(cliente); 
		for (Prestamo prestamo : prestamos) {
			Review r = dr.getByPrestamo(prestamo);
			if(prestamo.getReview().getFechaReview()==null) {System.out.println("esta vacia");} 
		  else
		  {System.out.println("Esta llena");} } } 
		catch (Exception e) {
		  e.printStackTrace(); }
		  
		/*
		 * Libro libro = new Libro(); libro.setIdLibro(7); Ejemplar ejemplar = new
		 * Ejemplar(); ejemplar.setLibro(libro); ejemplar.setIdEjemplar(2); Prestamo
		 * prestamo = new Prestamo();
		 * prestamo.setFechaRealizacion(LocalDate.parse("2024-10-11"));
		 * prestamo.setCliente(cliente); prestamo.setEjemplar(ejemplar);
		 */
		 
	}

}
