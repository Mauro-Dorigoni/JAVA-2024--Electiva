package logic;
import entidades.*;

import java.util.LinkedList;
import data.*;

public class CRUD_Cliente {
	private DataCliente dc;
	
	public CRUD_Cliente () {
		dc = new DataCliente();
	}
	
	public Cliente getByMail(Cliente c) throws AppException{
		try {
			return dc.getByMail(c);
		} catch (AppException e) {
			throw e;
		}
	}
	public void registrarCliente (Cliente c) throws AppException{
		try {
			dc.add(c);
		} catch (AppException e) {
			throw e;
		}
	}
	public LinkedList<Cliente> getAll() throws AppException{
		try {
			return dc.getAll();
		} catch (AppException e) {
			throw e;
		}
	}
	public Cliente getOne(Cliente c) throws AppException {
		try {
			return dc.getOne(c);
		} catch (AppException e) {
			throw e;
		}
	}
	public void updatePago(Cliente c) throws AppException {
		try {
			dc.updatePago(c);
		} catch (AppException e) {
			throw e;
		}
	}
	public void updatePass(Cliente c) throws AppException {
		try {
			dc.updatePassword(c);
		} catch (AppException e) {
			throw e;
		}
	}
	public void delete(Cliente c) throws AppException {
		if(c.getId()==1) {
			throw new AppException("Error: no se puede dar de baja la cuenta de admin principal");
		}
		try {
			dc.bajaLogica(c);
		} catch (AppException e) {
			throw e;
		}
	}
	public void grantAdmin (Cliente c) throws AppException{
		try {
			dc.grantAdmin(c);
		} catch (AppException e) {
			throw e;
		}
	}
	
}
