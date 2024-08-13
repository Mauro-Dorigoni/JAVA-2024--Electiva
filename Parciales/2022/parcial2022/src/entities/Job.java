package entities;

public abstract class Job {
	private int id;
	private String name;
	private String description;
	private double estimatedHours;
	private double insuranceCost;
	private BuildingSite jobBuildingSite;
	private WorkType jobWorkType;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getEstimatedHours() {
		return estimatedHours;
	}
	public void setEstimatedHours(double estimatedHours) {
		this.estimatedHours = estimatedHours;
	}
	public double getInsuranceCost() {
		return insuranceCost;
	}
	public void setInsuranceCost(double insuranceCost) {
		this.insuranceCost = insuranceCost;
	}
	public BuildingSite getJobBuildingSite() {
		return jobBuildingSite;
	}
	public void setJobBuildingSite(BuildingSite jobBuildingSite) {
		this.jobBuildingSite = jobBuildingSite;
	}
	public WorkType getJobWorkType() {
		return jobWorkType;
	}
	public void setJobWorkType(WorkType jobWorkType) {
		this.jobWorkType = jobWorkType;
	}
	abstract double getOveralCost();

}
