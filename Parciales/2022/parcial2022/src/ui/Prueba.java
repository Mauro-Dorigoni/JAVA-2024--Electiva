package ui;
import java.util.LinkedList;

import entities.*;

public class Prueba {

	public static void main(String[] args) {
		LinkedList<Job> bjobs = new LinkedList<>(); 
		
		Contratist c = new Contratist();
		c.setFirstName("Mauro");
		c.setLastName("Dorigoni");
		c.setSsn(1122);
		c.setHourlyRate(2.0);
		
		WorkType wt = new WorkType();
		wt.setDescription("worktype");
		wt.setName("WT");
		wt.setQuantityRate(2.0);
		wt.setWorkUnit("unidad");
		
		HourlyRatedJob hjob = new HourlyRatedJob();
		hjob.setId(1);
		hjob.setName("Hourly");
		hjob.setEstimatedHours(2.0);
		hjob.setInsuranceCost(2.0);
		hjob.setDescription("El de las horas");
		hjob.setJobContratist(c);
		hjob.setJobWorkType(wt);
		bjobs.add(hjob);
		
		QuantityRatedJob qjob = new QuantityRatedJob();
		qjob.setId(2);
		qjob.setName("Quantity");
		qjob.setEstimatedHours(2.0);
		qjob.setInsuranceCost(2.0);
		qjob.setDescription("El de las cantidades");
		qjob.setQuantity(2.0);
		qjob.setJobWorkType(wt);
		bjobs.add(qjob);
		
		FixedPriceJob fjob = new FixedPriceJob();
		fjob.setId(3);
		fjob.setName("fixed");
		fjob.setEstimatedHours(2.0);
		fjob.setInsuranceCost(2.0);
		fjob.setDescription("El fijo");
		fjob.setAgreedBudget(2.0);
		fjob.setJobWorkType(wt);
		bjobs.add(fjob);
		
		BuildingSite bs = new BuildingSite();
		bs.setAdress("Pasaje Coffin");
		bs.setId(1);
		bs.setJobs(bjobs);
		
		System.out.println("El costo total es:"+bs.getOveralBudget());
	}

}
