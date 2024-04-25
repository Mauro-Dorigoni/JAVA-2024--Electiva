package ui;
import java.util.Scanner;
import java.util.LinkedList;
import entidades.*;

public class Ejercicio5b {

	public static void main(String[] args) {
		LinkedList<Empleado> empleados = new LinkedList<>();
		boolean b=true;
		int i=0;
		int j;
		String aux;
		Scanner lector = new Scanner(System.in);
		while (b && i<20) {
			System.out.println("Desea ingresar un nuevo empleado? s/n");
			aux = lector.nextLine();
			if (aux.equals("s")) {
				System.out.println("Se trata de un Administrativo (a) o de un Vendedor (v). a/v");
				String opt = lector.nextLine();
				if(opt.equals("a")) {
					empleados.add(new Administrativo());
					System.out.println("Ingrse el DNI");
					empleados.getLast().setDni(Integer.parseInt(lector.nextLine()));
					System.out.println("Ingrse el Nombre");
					empleados.getLast().setNombre(lector.nextLine());
					System.out.println("Ingrse el Apellido");
					empleados.getLast().setApellido(lector.nextLine());
					System.out.println("Ingrse el Sueldo Base");
					empleados.getLast().setSueldoBase(Float.parseFloat(lector.nextLine()));
					empleados.getLast().setEmail("x@xx.com");
					System.out.println("Ingrese las horas Extra");
					((Administrativo)empleados.getLast()).setHsExtra(Integer.parseInt(lector.nextLine()));
					System.out.println("Ingrese las horas del mes");
					((Administrativo)empleados.getLast()).setHsMes(Integer.parseInt(lector.nextLine()));
					i++;
				}
				if(opt.equals("v")) {
					empleados.add(new Vendedor());
					System.out.println("Ingrse el DNI");
					empleados.getLast().setDni(Integer.parseInt(lector.nextLine()));
					System.out.println("Ingrse el Nombre");
					empleados.getLast().setNombre(lector.nextLine());
					System.out.println("Ingrse el Apellido");
					empleados.getLast().setApellido(lector.nextLine());
					System.out.println("Ingrse el Sueldo Base");
					empleados.getLast().setSueldoBase(Float.parseFloat(lector.nextLine()));
					empleados.getLast().setEmail("x@xx.com");
					System.out.println("Ingrese el porcentaje de comision");
					((Vendedor)empleados.getLast()).setPorcComision(Float.parseFloat(lector.nextLine()));
					System.out.println("Ingrese el total de Ventas");
					((Vendedor)empleados.getLast()).setTotalVentas(Integer.parseInt(lector.nextLine()));
					i++;
				}

			}
			if (aux.equals("n")) {
				b=false;
			}
		}
		for (Empleado empleado : empleados) {
			System.out.println(empleado.getDetalle());
		}
		lector.close();
	}
}
