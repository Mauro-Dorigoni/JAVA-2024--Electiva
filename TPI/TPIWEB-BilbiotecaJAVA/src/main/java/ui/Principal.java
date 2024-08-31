package ui;

import java.util.LinkedList;
import java.util.Scanner;
import entidades.*;
import logic.*;

public class Principal {

    public static void main(String[] args) {
    	int i;
        Scanner s = new Scanner(System.in);
        CRUD_categoria_libro ctrlCRUDcat = new CRUD_categoria_libro();
        
        Categoria_libro c = new Categoria_libro();
        c.setIdCategoria(2);
        c.setNombre_categoria("Ciencia ficción");
        c.setDescripcion_apliada("qcyo mamita");
        ctrlCRUDcat.save(c);
        LinkedList<Categoria_libro> categorias = ctrlCRUDcat.getAll();
        
        	
        
        for (Categoria_libro categoria : categorias) {
            System.out.println("ID: " + categoria.getIdCategoria());
            System.out.println("Nombre: " + categoria.getNombre_categoria());
            System.out.println("Descripción: " + categoria.getDescripcion_apliada());
            System.out.println("-----------------------");
        }
    }

}
