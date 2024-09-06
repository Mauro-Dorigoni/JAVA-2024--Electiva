package ui;
import entidades.*;
import logic.*;

public class PruebaLogin {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Cliente c = new Cliente();
		c.setMail("maurodorigonipecas@gmail.com");
		c.setContra("user");
		
		Login login = new Login();
		try {
			Cliente user = login.validate(c);
			
			if(user == null) {
				System.out.println("Usuario incorrecto");
			}
			else {
				if(user.isAdmin()) {System.out.println("es amdin");}
				else {System.out.println("no es admin");}
			}
		} catch (AppException e) {
			e.printStackTrace();
		}

	}

}
