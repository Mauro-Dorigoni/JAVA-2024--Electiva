package entities.ejercicio1;
import java.time.*;
import java.util.LinkedList;

public class Treatment extends Service {
	private double basePrice;
	private LocalDateTime usage;
	private LinkedList<Consumable> consumables;
	public double getBasePrice() {
		return basePrice;
	}
	public void setBasePrice(double basePrice) {
		this.basePrice = basePrice;
	}
	public LocalDateTime getUsage() {
		return usage;
	}
	public void setUsage(LocalDateTime usage) {
		this.usage = usage;
	}
	public LinkedList<Consumable> getConsumables() {
		return consumables;
	}
	public void setConsumables(LinkedList<Consumable> consumables) {
		this.consumables = consumables;
	}
	public void addConsumable(Consumable consumable) {
		this.consumables.add(consumable);
	}
	public double getServicePrice() {
		double consumablePrice = 0.0;
		for (Consumable consumable : consumables) {
			consumablePrice = consumablePrice + consumable.getCurrentPrice(LocalDateTime.now());
		}
		return consumablePrice + getBasePrice();
	}
}
