package entities.ejercicio1;

public class FacilityUsage extends Service {
	private String name;
	private double monthlyPrice;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getMonthlyPrice() {
		return monthlyPrice;
	}
	public void setMonthlyPrice(double monthlyPrice) {
		this.monthlyPrice = monthlyPrice;
	}
	public double getServicePrice() {
		return getMonthlyPrice();
	}
	
}
