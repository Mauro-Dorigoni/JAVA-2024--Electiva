package entities;
import java.util.*;

public class ClaseEj2 {
	public double getReinbursement(LinkedList<Expenditure> expenditures, double reinbursementPercentaje) {
		double amountToReimburse = 0.0;
		for (Expenditure expenditure : expenditures) {
			if(expenditure.isReimbursable()) {
				amountToReimburse = amountToReimburse + expenditure.getAmount()*(reinbursementPercentaje/100);
			}
		}
		return amountToReimburse;
	};
}
