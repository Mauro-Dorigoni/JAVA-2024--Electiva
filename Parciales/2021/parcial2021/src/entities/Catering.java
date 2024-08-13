package entities;

import java.util.LinkedList;

public class Catering extends Event {
	private double fixedCost;
	private LinkedList<Menu> menus;
	
	public double getFixedCost() {
		return fixedCost;
	}
	public void setFixedCost(double fixedCost) {
		this.fixedCost = fixedCost;
	}
	public LinkedList<Menu> getMenus() {
		return menus;
	}
	public void setMenus(LinkedList<Menu> menus) {
		this.menus = menus;
	}
	public void addMenu(Menu m) {
		this.menus.add(m);
	}
	
	@Override
	public double getOveralCost() {
		double totalCost = this.fixedCost;
		for (Menu menu : menus) {
			totalCost = totalCost + menu.getUnitCost()*menu.getQuantity();		
		}
		return totalCost + super.getOveralCost();
	}
	
}
