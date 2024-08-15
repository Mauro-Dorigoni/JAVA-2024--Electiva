package entities.ejercicio1;

import java.util.LinkedList;

public abstract class Service {
	private String name;
	private LinkedList<Client> clients;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public LinkedList<Client> getClients() {
		return clients;
	}
	public void setClients(LinkedList<Client> clients) {
		this.clients = clients;
	}
	
	public void addClient(Client client) {
		this.clients.add(client);
	}
	abstract public double getServicePrice();
}
