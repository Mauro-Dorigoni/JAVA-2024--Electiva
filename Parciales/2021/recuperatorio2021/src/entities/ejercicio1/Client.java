package entities.ejercicio1;

import java.util.LinkedList;

public class Client {
	private String firstName;
	private String lastName;
	private LinkedList<Service> services;
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public LinkedList<Service> getServices() {
		return services;
	}
	public void setServices(LinkedList<Service> services) {
		this.services = services;
	}
	public void addService(Service service) {
		this.services.add(service);
	}
	public double getServiceBill() {
		double serviceBill = 0.0;
		for (Service service : services) {
			serviceBill = serviceBill + service.getServicePrice();
		}
		return serviceBill;
	}
	
	
}
