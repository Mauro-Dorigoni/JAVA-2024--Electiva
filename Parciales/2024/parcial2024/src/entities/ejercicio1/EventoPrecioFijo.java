package entities.ejercicio1;

public class EventoPrecioFijo extends Evento{
	private double precioFijo;

	public double getPrecioFijo() {
		return precioFijo;
	}

	public void setPrecioFijo(double precioFijo) {
		this.precioFijo = precioFijo;
	}
	
	public double getCostoEvento() {
		return this.getPrecioFijo();
	}
}
