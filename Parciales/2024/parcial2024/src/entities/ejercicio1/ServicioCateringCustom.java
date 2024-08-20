package entities.ejercicio1;

public class ServicioCateringCustom extends ServicioCatering {
	private double precioFijo;

	public double getPrecioFijo() {
		return precioFijo;
	}

	public void setPrecioFijo(double precioFijo) {
		this.precioFijo = precioFijo;
	}
	
	@Override
	public double getCostoCatering(double hsTrabajadas, int cantInvitados) {
		return this.getPrecioFijo();
	}
}
