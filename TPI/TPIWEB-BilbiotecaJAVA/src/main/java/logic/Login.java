package logic;

import entidades.*;
import data.*;

public class Login {
    private DataCliente dc;

    public Login() {
        dc = new DataCliente();
    }

    public Cliente validate(Cliente c) throws AppException{
        try {
        	return dc.getByMailandPass(c);
		} catch (AppException e) {
			throw e;
		}
    }
}