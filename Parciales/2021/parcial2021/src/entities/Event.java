package entities;
import java.time.*;
import java.util.LinkedList;

public abstract class Event {
	private LocalDateTime eventDate;
	private String location;
	private Client cliente;
	private LinkedList<Service> services;
	
	public LocalDateTime getEventDate() {
		return eventDate;
	}
	public void setEventDate(LocalDateTime eventDate) {
		this.eventDate = eventDate;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public Client getCliente() {
		return cliente;
	}
	public void setCliente(Client cliente) {
		this.cliente = cliente;
	}
	public LinkedList<Service> getServices() {
		return services;
	}
	public void setServices(LinkedList<Service> services) {
		this.services = services;
	}
	public void addService(Service s) {
		this.services.add(s);
	}
	public double getOveralCost() {
		double acum = 0.0;
		for (Service service : services) {
			acum = acum + service.getCost();
		}
		return acum;
	}
}
