package entities;

import java.util.LinkedList;

public class Service {
	private String name;
	private double cost;
	private LinkedList<Event> events;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getCost() {
		return cost;
	}
	public void setCost(double cost) {
		this.cost = cost;
	}
	public LinkedList<Event> getEvents() {
		return events;
	}
	public void setEvents(LinkedList<Event> events) {
		this.events = events;
	}
	
}
