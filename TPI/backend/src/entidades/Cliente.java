package entidades;

public class Cliente {
	private int idCliente;
	private String nombre;
	private String apellido;
	private String mail;
	private String dni;
	private String contra;
	private String fechaUltimoPago;
	public int getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getDni() {
		return dni;
	}
	public void setDni(String dni) {
		this.dni = dni;
	}
	public String getContra() {
		return contra;
	}
	public void setContra(String contra) {
		this.contra = contra;
	}
	public String getFechaUltimoPago() {
		return fechaUltimoPago;
	}
	public void setFechaUltimoPago(String fechaUltimoPago) {
		this.fechaUltimoPago = fechaUltimoPago;
	}
	
}
