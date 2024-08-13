package entities;
import java.util.LinkedList;

public class BuildingSite {
	private int id;
	private String adress;
	private LinkedList<Job> jobs;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAdress() {
		return adress;
	}
	public void setAdress(String adress) {
		this.adress = adress;
	}
	
	public LinkedList<Job> getJobs() {
		return jobs;
	}
	public void setJobs(LinkedList<Job> jobs) {
		this.jobs = jobs;
	}
	
	public double getOveralBudget() {
		double overalBudget = 0.0;
		for (Job job : jobs) {
			overalBudget = overalBudget + job.getOveralCost();
		}
		return overalBudget;
	}
}

