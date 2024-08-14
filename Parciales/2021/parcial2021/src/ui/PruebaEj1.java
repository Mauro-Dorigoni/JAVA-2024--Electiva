package ui;
import java.util.LinkedList;

import entities.*;
import java.time.*;

public class PruebaEj1 {

	public static void main(String[] args) {
		LinkedList<Menu> menus = new LinkedList<>();
		Menu m1 = new Menu();
		m1.setName("pollo a la portuguesa");
		m1.setQuantity(100);
		m1.setUnitCost(300);
		menus.add(m1);
		
		Menu m2 = new Menu();
		m2.setName("Hamburguesa Vegana");
		m2.setQuantity(30);
		m2.setUnitCost(75);
		menus.add(m2);
		
		LinkedList<Service> services = new LinkedList<>();
		Service s1 = new Service();
		s1.setName("servicio de mozos");
		s1.setCost(1500);
		services.add(s1);
		
		Service s2 = new Service();
		s2.setName("Servicio de valet");
		s2.setCost(4000);
		services.add(s2);
		
		Client c = new Client();
		c.setFirstName("Mauro");
		c.setLastName("Dorigoni");
		
		Catering cat = new Catering();
		cat.setCliente(c);
		cat.setFixedCost(40000);
		cat.setLocation("Puerto Norte");
		cat.setMenus(menus);
		cat.setServices(services);
		cat.setEventDate(LocalDateTime.of(LocalDate.now(), LocalTime.now()));
		
		LinkedList<Event> cats= new LinkedList<>();
		cats.add(cat);
		m1.setCaterings(cats);
		m2.setCaterings(cats);
		s1.setEvents(cats);
		s2.setEvents(cats);
		
		System.out.println(cat.getOveralCost());
		
		Equipment e = new Equipment();
		e.setCost(2000);
		e.setType("Sonido amplificado");
		
		Artist a = new Artist();
		a.setHourlyCost(75);
		a.setName("ICarly");
		
		Show show = new Show();
		show.setArtist(a);
		show.setCliente(c);
		show.setDurationHs(5);
		show.setEquipment(e);
		show.setLocation("La rural");
		show.setName("Concierto ICarly");
		show.setServices(services);
		show.setType("Concierto");
		show.setEventDate(LocalDateTime.of(LocalDate.now(), LocalTime.now()));
		
		cats.add(show);
		s1.setEvents(cats);
		s2.setEvents(cats);
		
		System.out.println(show.getOveralCost());
		
		
	}

}
