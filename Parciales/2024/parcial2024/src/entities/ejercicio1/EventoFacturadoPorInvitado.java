package entities.ejercicio1;

public class EventoFacturadoPorInvitado extends Evento{
	private double precioPorInvitado;
	private int invitadosMinimo;
	
	public double getPrecioPorInvitado() {
		return precioPorInvitado;
	}
	public void setPrecioPorInvitado(double precioPorInvitado) {
		this.precioPorInvitado = precioPorInvitado;
	}
	public int getInvitadosMinimo() {
		return invitadosMinimo;
	}
	public void setInvitadosMinimo(int invitadosMinimo) {
		this.invitadosMinimo = invitadosMinimo;
	}
	
	public double getCostoEvento() {
		if(this.getInvitados().size() < this.getInvitadosMinimo()) {
			return this.getInvitadosMinimo()*this.precioPorInvitado;
		}
		else return this.getInvitados().size()*this.getPrecioPorInvitado();
	}
	
}
