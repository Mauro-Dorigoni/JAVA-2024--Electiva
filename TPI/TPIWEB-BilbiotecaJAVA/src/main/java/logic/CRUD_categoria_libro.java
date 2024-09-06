package logic;

import java.util.LinkedList;
import data.*;
import entidades.*;

public class CRUD_categoria_libro {
    private DataCategoriaLibro dc;
    
    public CRUD_categoria_libro() {
        dc = new DataCategoriaLibro();  
    }
    
    public LinkedList<Categoria_libro> getAll() throws AppException{
        try {
        	return dc.getAll();
		} catch (AppException e) {
			throw e;
		}
    }
    public Categoria_libro getOne(Categoria_libro c) throws AppException{
    	try {
    		return dc.getOne(c);
		} catch (AppException e) {
			throw e;
		}
    }
    
    public LinkedList<Categoria_libro> getByDatos(Categoria_libro c) throws AppException{
        try {
        	return dc.getByDatos(c);
		} catch (AppException e) {
			throw e;
		}
    }
    
    public void save(Categoria_libro c) throws AppException{
    	try {
    		dc.save(c);
		} catch (AppException e) {
			throw e;
		}
    }
    
    public void modify_desc(Categoria_libro c) throws AppException{
    	try {
    		dc.modify_desc(c);
		} catch (AppException e) {
			throw e;
		}
    }
    public void baja(Categoria_libro c) throws AppException{
    	try {
        	dc.deleteLogic(c);
		} catch (AppException e) {
			throw e;
		}
    }
}
