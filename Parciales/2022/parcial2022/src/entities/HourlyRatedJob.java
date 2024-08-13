package entities;

public class HourlyRatedJob extends Job {
	private Contratist jobContratist;

	public Contratist getJobContratist() {
		return jobContratist;
	}

	public void setJobContratist(Contratist jobContratist) {
		this.jobContratist = jobContratist;
	}
	public double getOveralCost() {
		return super.getEstimatedHours()*jobContratist.getHourlyRate() + super.getInsuranceCost();
	}
}
