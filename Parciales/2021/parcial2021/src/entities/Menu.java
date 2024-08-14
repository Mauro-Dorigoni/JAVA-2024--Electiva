package entities;

import java.util.LinkedList;

public class Menu {
	private String name;
	private double unitCost;
	private int quantity;
	private LinkedList<Event> caterings;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getUnitCost() {
		return unitCost;
	}
	public void setUnitCost(double unitCost) {
		this.unitCost = unitCost;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public LinkedList<Event> getCaterings() {
		return caterings;
	}
	public void setCaterings(LinkedList<Event> caterings) {
		this.caterings = caterings;
	}
	
}
