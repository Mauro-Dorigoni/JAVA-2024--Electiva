package primerEjemplo;

import java.util.Iterator;
import java.util.Scanner;

public class Principal {

	public static void main(String[] args) {
		System.out.println("Primer Ejemplo");
		Integer n;
		String texto;
		Scanner lector = new Scanner(System.in);
		//extracted(lector);
		iterar(lector);
		lector.close();
	}

	private static void iterar(Scanner lector) {
		String[] palabras = new String[3];
		for (int i = 0; i < palabras.length; i++) {
			System.out.println("Ingrese la palabra: "+(i+1));
			palabras[i]=lector.nextLine();
		}
		for (String palabra : palabras) {
			System.out.println(palabra);
		}
		
	}
	
	private static void extracted(Scanner lector) {
		Integer n;
		String texto;
		System.out.println("Ingrese un texto: ");
		texto=lector.nextLine();
		System.out.println("Ingrese un numero: ");
		n=Integer.parseInt(lector.nextLine());
		System.out.println("Texto: "+texto);
		System.out.println("numero: "+n);

		if (n>10) {
			System.out.println("too big");
		} else {
			System.out.println("too smol");

		}
	}

}
