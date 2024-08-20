package entities.ejercicio1;

import java.util.LinkedList;

public class Medicine {
	private double cost;
	private LinkedList<Practice> practices;
	
	public double getCost() {
		return cost;
	}
	public void setCost(double cost) {
		this.cost = cost;
	}
	public LinkedList<Practice> getPractices() {
		return practices;
	}
	public void setPractices(LinkedList<Practice> practices) {
		this.practices = practices;
	}
	
}
