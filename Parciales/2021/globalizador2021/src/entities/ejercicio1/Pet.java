package entities.ejercicio1;

import java.util.LinkedList;

public class Pet {
	private String name;
	private boolean hasMonthlyPass;
	private LinkedList<Practice> practices;
	
	public LinkedList<Practice> getPractices() {
		return practices;
	}
	public void setPractices(LinkedList<Practice> practices) {
		this.practices = practices;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isHasMonthlyPass() {
		return hasMonthlyPass;
	}
	public void setHasMonthlyPass(boolean hasMonthlyPass) {
		this.hasMonthlyPass = hasMonthlyPass;
	}
	public double getPetPracticesBill() {
		double petPracticesBill = 0.0;
		for (Practice practice : practices) {
			petPracticesBill = petPracticesBill + practice.getPracticeBill(hasMonthlyPass);
		}
		return petPracticesBill;
	}
}
