package entities.ejercicio1;

import java.util.LinkedList;

public class ExternalPractice extends Practice {
	private String providerName;
	private double discountPercentageForMonthlyPass;
	
	public String getProviderName() {
		return providerName;
	}
	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}
	public double getDiscountPercentageForMonthlyPass() {
		return discountPercentageForMonthlyPass;
	}
	public void setDiscountPercentageForMonthlyPass(double discountPercentageForMonthlyPass) {
		this.discountPercentageForMonthlyPass = discountPercentageForMonthlyPass;
	}
	
	public double getPracticeBill(boolean hasMonthlyPass) {
		double pCost = this.getCost();
		if(hasMonthlyPass) {pCost = pCost - pCost*discountPercentageForMonthlyPass/100;}
		double medCost = 0.0;
		for (Medicine medicine : this.getMedicines()) {
			medCost = medCost + medicine.getCost();
		}
		return pCost + medCost;
	}
}
