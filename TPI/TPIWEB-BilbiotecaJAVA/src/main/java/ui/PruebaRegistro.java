package ui;
import entidades.*;
import logic.*;

public class PruebaRegistro {

	public static void main(String[] args) {
		Cliente c = new Cliente();
		c.setMail("camidori@gmail.com");
		
		CRUD_Cliente crid = new CRUD_Cliente();
		
		if(crid.getByMail(c)==null) {
			c.setNombre("Camila");
			c.setApellido("Dorigoni");
			c.setContra("user3");
			c.setDni("39123123");
			crid.registrarCliente(c);
			System.out.println("Hoorraah");}
		if(crid.getByMail(c)!=null) {System.out.println("Ya es cliente");}
	}
	

}
