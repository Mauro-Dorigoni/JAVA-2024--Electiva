package entities.ejercicio1;
import java.util.LinkedList;

public class InternalPractice extends Practice {
	private String name;
	private double medicineDiscount;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getMedicineDiscount() {
		return medicineDiscount;
	}
	public void setMedicineDiscount(double medicineDiscount) {
		this.medicineDiscount = medicineDiscount;
	}
	public double getPracticeBill(boolean hasMonthlyDiscount) {
		double medCost = 0.0;
		for (Medicine medicine : this.getMedicines()) {
			medCost = medCost + medicine.getCost();
		}
		if(hasMonthlyDiscount) {medCost = medCost - medCost*this.getMedicineDiscount()/100;}
		return medCost + this.getCost();
	}
	
}
