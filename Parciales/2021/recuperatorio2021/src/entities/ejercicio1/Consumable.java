package entities.ejercicio1;
import java.time.*;

public class Consumable {
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public double getCurrentPrice(LocalDateTime usage) {
		return 5.0;
	}
}
