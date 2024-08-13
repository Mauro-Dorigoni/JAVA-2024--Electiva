package entities;

import java.util.LinkedList;

public class Menu {
	private String name;
	private double unitCost;
	private int quantity;
	private LinkedList<Catering> caterings;
	
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
	public LinkedList<Catering> getCaterings() {
		return caterings;
	}
	public void setCaterings(LinkedList<Catering> caterings) {
		this.caterings = caterings;
	}
	
}
