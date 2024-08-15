package ui.ejercicio1;

import java.util.LinkedList;
import java.time.*;
import entities.ejercicio1.*;

public class Prueba1 {
	public static void main(String[] args) {
		LinkedList<Consumable> consumables = new LinkedList<>();
		Consumable c1 = new Consumable();
		c1.setName("Aceite");
		consumables.add(c1);
		Consumable c2 = new Consumable();
		c2.setName("Piedra");
		consumables.add(c2);
		
		LinkedList<Service> servicios = new LinkedList<>();
		Treatment t = new Treatment();
		t.setName("masaje con aceite y piedras calientes");
		t.setBasePrice(10.0);
		t.setUsage(LocalDateTime.now());
		t.setConsumables(consumables);
		servicios.add(t);
		
		FacilityUsage f = new FacilityUsage();
		f.setName("Pileta");
		f.setMonthlyPrice(10.0);
		servicios.add(f);
		
		LinkedList<Client> clients = new LinkedList<>();
		Client c = new Client();
		c.setFirstName("Mateo");
		c.setLastName("Tosello");
		c.setServices(servicios);
		clients.add(c);
		
		t.setClients(clients);
		f.setClients(clients);
		
		
		System.out.println(c.getServiceBill());
		
		
		

	}

}
