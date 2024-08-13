package entities;

public class QuantityRatedJob extends Job {
	private double quantity;

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public double getOveralCost() {
		return quantity*(super.getJobWorkType().getQuantityRate()) + super.getInsuranceCost();
	}
}
