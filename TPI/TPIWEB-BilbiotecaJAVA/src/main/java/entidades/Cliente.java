package entidades;
import java.time.*;

public class Cliente {
	private int id;
	private String nombre;
	private String apellido;
	private String mail;
	private String dni;
	private String contra;
	private LocalDate fechaUltimoPago;
	private boolean isAdmin;
	private LocalDate fechaBaja;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public LocalDate getFechaUltimoPago() {
		return fechaUltimoPago;
	}
	public void setFechaUltimoPago(LocalDate fechaUltimoPago) {
		this.fechaUltimoPago = fechaUltimoPago;
	}
	public boolean isAdmin() {
		return isAdmin;
	}
	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
	public LocalDate getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(LocalDate fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
	
}
