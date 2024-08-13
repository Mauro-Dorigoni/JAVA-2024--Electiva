package entities;

import java.util.LinkedList;

public class Bill {
	public double getTotal(LinkedList<BillItem> items, boolean includeTax) {
		double total = 0.0;
		for (BillItem billItem : items) {
			total = total + billItem.getQuantity()*billItem.getUnitPrice();
		}
		if(includeTax) {return total*1.21;}
		else {return total;}
	}
}
