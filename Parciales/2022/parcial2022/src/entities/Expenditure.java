package entities;
import java.util.*;

public class Expenditure {
	private boolean reimbursable;
	private double amount;
	private Date date;
	public boolean isReimbursable() {
		return reimbursable;
	}
	public void setReimbursable(boolean reimbursable) {
		this.reimbursable = reimbursable;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
}
