package logic;

import java.util.LinkedList;
import data.*;
import entidades.*;

public class CRUD_categoria_libro {
    private DataCategoriaLibro dc;
    
    public CRUD_categoria_libro() {
        dc = new DataCategoriaLibro();  
    }
    
    public LinkedList<Categoria_libro> getAll(){
        return dc.getAll();
    }
    public Categoria_libro getOne(Categoria_libro c) {
    	return dc.getOne(c);
    }
    
    public LinkedList<Categoria_libro> getByDatos(Categoria_libro c){
        return dc.getByDatos(c);
    }
    
    public void save(Categoria_libro c) {
    	dc.save(c);
    }
    
    public void modify_desc(Categoria_libro c) {
    	dc.modify_desc(c);
    }
}
