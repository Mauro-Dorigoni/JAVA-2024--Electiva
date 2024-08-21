package logic;
import entidades.Cliente;
import data.*;

public class CRUD_Cliente {
	private DataCliente dc;
	
	public CRUD_Cliente () {
		dc = new DataCliente();
	}
	
	public Cliente getByMail(Cliente c) {
		return dc.getByMail(c);
	}
	public void registrarCliente (Cliente c) {
		dc.add(c);
	}
}
