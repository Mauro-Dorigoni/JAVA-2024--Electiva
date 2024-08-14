package ui;
import java.util.LinkedList;
import entities.*;

public class PruebaEj2 {

	public static void main(String[] args) {
		BillItem b1 = new BillItem();
		b1.setQuantity(10);
		b1.setUnitPrice(100);
		
		BillItem b2 = new BillItem();
		b2.setQuantity(2);
		b2.setUnitPrice(20);
		
		LinkedList<BillItem> billitems = new LinkedList<>();
		billitems.add(b2);
		billitems.add(b1);
		
		Bill f = new Bill();
		System.out.println(f.getTotal(billitems, true));

	}

}
