package ui;
import java.util.Scanner;
import entidades.*;
public class Principal {

	public static void main(String[] args) {
	Empleado[] conjunto = new Empleado[20];
	boolean b=true;
	int i=0;
	int j;
	String aux;
	Scanner lector = new Scanner(System.in);
	while(b && i<20) {
		System.out.println("Desea ingresar un nuevo empleado? s/n");
		aux = lector.nextLine();
		if (aux.equals("s")) {
			System.out.println("Se trata de un Administrativo (a) o de un Vendedor (v). a/v");
			String opt = lector.nextLine();
			if(opt.equals("a")) {
				conjunto[i]=new Administrativo();
				System.out.println("Ingrse el DNI");
				conjunto[i].setDni(Integer.parseInt(lector.nextLine()));
				System.out.println("Ingrse el Nombre");
				conjunto[i].setNombre(lector.nextLine());
				System.out.println("Ingrse el Apellido");
				conjunto[i].setApellido(lector.nextLine());
				System.out.println("Ingrse el Sueldo Base");
				conjunto[i].setSueldoBase(Float.parseFloat(lector.nextLine()));
				conjunto[i].setEmail("x@xx.com");
				System.out.println("Ingrese las horas Extra");
				((Administrativo)conjunto[i]).setHsExtra(Integer.parseInt(lector.nextLine()));
				System.out.println("Ingrese las horas del mes");
				((Administrativo)conjunto[i]).setHsMes(Integer.parseInt(lector.nextLine()));
				i++;
			}
			if(opt.equals("v")) {
				conjunto[i]=new Vendedor();
				System.out.println("Ingrse el DNI");
				conjunto[i].setDni(Integer.parseInt(lector.nextLine()));
				System.out.println("Ingrse el Nombre");
				conjunto[i].setNombre(lector.nextLine());
				System.out.println("Ingrse el Apellido");
				conjunto[i].setApellido(lector.nextLine());
				System.out.println("Ingrse el Sueldo Base");
				conjunto[i].setSueldoBase(Float.parseFloat(lector.nextLine()));
				conjunto[i].setEmail("x@xx.com");
				System.out.println("Ingrese el porcentaje de comision");
				((Vendedor)conjunto[i]).setPorcComision(Float.parseFloat(lector.nextLine()));
				System.out.println("Ingrese el total de Ventas");
				((Vendedor)conjunto[i]).setTotalVentas(Integer.parseInt(lector.nextLine()));
				i++;
			}
		} if(aux.equals("n")) {
			b=false;
		}
	}
	for(j=0; j<i; j++) {
		System.out.println("Empleado nro: "+(j+1));
		System.out.println(conjunto[j].getDetalle());
	}
	lector.close();
	}

}
