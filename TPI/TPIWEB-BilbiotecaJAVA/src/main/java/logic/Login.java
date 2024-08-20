package logic;

import entidades.*;
import data.*;

public class Login {
    private DataCliente dc;

    public Login() {
        dc = new DataCliente();
    }

    public Cliente validate(Cliente c) {
        return dc.getByMailandPass(c);
    }
}