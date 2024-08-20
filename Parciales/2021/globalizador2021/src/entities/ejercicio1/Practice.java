package entities.ejercicio1;

import java.util.LinkedList;

public abstract class Practice {
	private String name;
	private double cost;
	private LinkedList<Pet> pets;
	private LinkedList<Medicine> medicines;
	
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
	public LinkedList<Pet> getPets() {
		return pets;
	}
	public void setPets(LinkedList<Pet> pets) {
		this.pets = pets;
	}
	public LinkedList<Medicine> getMedicines() {
		return medicines;
	}
	public void setMedicines(LinkedList<Medicine> medicines) {
		this.medicines = medicines;
	}
	public abstract double getPracticeBill(boolean hasMonthlyPass);
	
}
