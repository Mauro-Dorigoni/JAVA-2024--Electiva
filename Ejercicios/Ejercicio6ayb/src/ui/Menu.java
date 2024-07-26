package ui;

import java.util.Scanner;
import java.time.LocalDateTime;  
import java.time.format.DateTimeFormatter;   

import entidades.*;
import logica.*;

public class Menu {
	Scanner s = null;
	LogicaProducto l = new LogicaProducto();

	
	public void start() {
		s = new Scanner(System.in);
		System.out.println("Bienvenido ");
		System.out.println();
		
		String command;
		do {
			command=getCommand();
			executeCommand(command);
			System.out.println();
			
		}while(!command.equalsIgnoreCase("exit"));
		
		s.close();
	}
	
	private String getCommand() {
		System.out.println("Ingrese el comando según la opción que desee realizar");
		System.out.println("list\t\tlistar todos los productos activos");
		System.out.println("search\t\tbuscar por id"); //solo debe devolver 1
		System.out.println("new\t\tcrear un nuevo producto");
		System.out.println("update\t\tbusca por id y actualizar datos");
		System.out.println("deleteF\t\tbaja fisica por id");
		System.out.println("deleteL\t\tbaja logica por id");
		System.out.println();
		System.out.print("comando: ");
		return s.nextLine();
	}
	
	private void executeCommand(String command) {
		switch (command) {
		case "list":
			System.out.println(l.getAll());
			break;
		case "search":
			System.out.println("Ingrese id producto: ");
			int id = Integer.parseInt(s.nextLine());
			Product pn = l.buscaxId(id);
			System.out.println(pn);
			break;
		case "new":
			Product p = new Product();
			System.out.println("Ingrese nombre producto: ");
			p.setNombre(s.nextLine());
			System.out.println("Ingrese descripcion producto: ");
			p.setDescripcion(s.nextLine());
			System.out.println("Ingrese precio producto: ");
			p.setPrecio(Float.parseFloat(s.nextLine()));
			System.out.println("Ingrese stock producto: ");
			p.setStock(Integer.parseInt(s.nextLine()));
			System.out.println("Tiene envio incluido? 0-No, 1-Si: ");
			if(s.nextLine() == "1") {
				p.setEnvio(true);
			}
			else { 
				p.setEnvio(false);	
			}
			l.save(p);
			break;
		case "update":
			System.out.println("Ingrese id producto: ");
			int id2 = Integer.parseInt(s.nextLine());
			Product p2 = l.buscaxId(id2);
			System.out.println(p2);
			System.out.println("Nuevos valores: ");
			System.out.println("Ingrese nombre producto: ");
			p2.setNombre(s.nextLine());
			System.out.println("Ingrese descripcion producto: ");
			p2.setDescripcion(s.nextLine());
			System.out.println("Ingrese precio producto: ");
			p2.setPrecio(Float.parseFloat(s.nextLine()));
			System.out.println("Ingrese stock producto: ");
			p2.setStock(Integer.parseInt(s.nextLine()));
			System.out.println("Tiene envio incluido? 0-No, 1-Si: ");
			if(s.nextLine() == "1") {
				p2.setEnvio(true);
			}
			else { 
				p2.setEnvio(false);	
			}
			l.update(p2);
			break;
		case "deleteF":
			System.out.println("Ingrese id producto: ");
			l.borrar(Integer.parseInt(s.nextLine()));
			break;
		case "deleteL":
			System.out.println("Ingrese id producto: ");
			int id3 = Integer.parseInt(s.nextLine());
			l.borrarLogico(id3);
			break;
		default:
			break;
		}
	}


}
