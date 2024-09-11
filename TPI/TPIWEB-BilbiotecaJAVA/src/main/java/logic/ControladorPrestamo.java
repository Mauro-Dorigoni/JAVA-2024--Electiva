package logic;
import entidades.*;
import data.*;
import java.util.LinkedList;


public class ControladorPrestamo {

	private DataPrestamo dp;
	
	public ControladorPrestamo() {
		dp = new DataPrestamo();
	}
	
	public LinkedList<Prestamo> getAll() throws AppException {
		try {
			return dp.getAll();
		} catch (AppException e) {
			throw e;
		}
	}
	
	public Prestamo getOne(Prestamo p) throws AppException {
		try {
			return dp.getOne(p);
		} catch (AppException e) {
			throw e;
		}
	}
	
	public void save(Prestamo p) throws AppException {
		try {
			dp.save(p);
		} catch (AppException e) {
			throw e;
		}
	}
	
	public void updateState (Prestamo p) throws AppException{
		try {
			dp.update(p);
		} catch (AppException e) {
			throw e;
		}
	}
	
	public String validate(Cliente c, Libro l) throws AppException {
		try {
			if(dp.validateEjemplaresLibres(l)) {
				if(dp.validatePagoCliente(c)) {
					if(dp.validatePrestamosVencidosCliente(c)) {
						if(dp.validatePrestamosActivosCliente(c)) {
							return "Validado";
						}
						else {
							return "Activos";
						}
					}
					else {
						return "Vencidos";
					}
				}
				else {
					return "Pagos";
				}
			}
			else {
				return "Ejemplares";
			}
		} catch (AppException e) {
			throw e;
		}
	}

}
