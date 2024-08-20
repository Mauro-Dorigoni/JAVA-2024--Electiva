package entities.ejercicio1;

import java.util.LinkedList;

public class Client {
	private String firstName;
	private String lastName;
	private LinkedList<Pet> pets;
	
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
	public LinkedList<Pet> getPets() {
		return pets;
	}
	public void setPets(LinkedList<Pet> pets) {
		this.pets = pets;
	}
	public double getBill() {
		double bill = 0.0;
		for (Pet pet : pets) {
			bill = bill + pet.getPetPracticesBill();
		}
		return bill;
	}
	
}
