package entities.ejercicio2;
import java.util.*;

public class Cliente {
	public double getTotal(LinkedList<Pago> pagos) {
		double total = 0.0;
		for (Pago pago : pagos) {
			if(Objects.isNull(pago.getFechaPago())) {
				total = total + pago.getImporte();
			}
		}
		return total;
	}
}
