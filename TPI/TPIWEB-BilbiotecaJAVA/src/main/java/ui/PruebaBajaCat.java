package ui;
import entidades.*;
import logic.*;
public class PruebaBajaCat {

	public static void main(String[] args) {
		CRUD_categoria_libro cl = new CRUD_categoria_libro();
		Categoria_libro cat = new Categoria_libro();
		cat.setIdCategoria(23);
		try {
			cl.baja(cat);
		} catch (AppException e) {
			e.printStackTrace();
		}
	}

}
