package entidades;

public class Vendedor extends Empleado {
	private float porcComision;
	private int totalVentas;
	public float getPorcComision() {
		return porcComision;
	}
	public void setPorcComision(float porcComision) {
		this.porcComision = porcComision;
	}
	public int getTotalVentas() {
		return totalVentas;
	}
	public void setTotalVentas(int totalVentas) {
		this.totalVentas = totalVentas;
	}
	public String getDetalle() {
		float sueldo=this.getSueldoBase()+(porcComision*totalVentas/100);
		return super.getDetalle()+", Sueldo: "+sueldo;
	}
}
