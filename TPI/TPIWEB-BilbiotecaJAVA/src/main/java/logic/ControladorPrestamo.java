package logic;
import entidades.*;
import data.*;
import java.util.LinkedList;


public class ControladorPrestamo {

	private DataPrestamo dp;
	private DataReview dr;
	
	public ControladorPrestamo() {
		dp = new DataPrestamo();
		dr = new DataReview();
	}
	
	public LinkedList<Prestamo> getAll() throws AppException {
		try {
			LinkedList<Prestamo> prestamos = dp.getAll();
			for (Prestamo prestamo : prestamos) {
				prestamo.setReview(dr.getByPrestamo(prestamo));
			}
			return prestamos;
		} catch (AppException e) {
			throw e;
		}
	}
	
	public Prestamo getOne(Prestamo p) throws AppException {
		try {
			Prestamo prestamo = dp.getOne(p);
			prestamo.setReview(dr.getByPrestamo(prestamo));
			return prestamo;
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
	
	public ValidarPrestamoEnum validate(Cliente c, Libro l) throws AppException {
		try {
			if(dp.validateEjemplaresLibres(l)) {
				if(dp.validatePagoCliente(c)) {
					if(dp.validatePrestamosVencidosCliente(c)) {
						if(dp.validatePrestamosActivosCliente(c)) {
							return ValidarPrestamoEnum.Validado;
						}
						else {
							return ValidarPrestamoEnum.Activos;
						}
					}
					else {
						return ValidarPrestamoEnum.Vencidos;
					}
				}
				else {
					return ValidarPrestamoEnum.Pagos;
				}
			}
			else {
				return ValidarPrestamoEnum.Ejemplares;
			}
		} catch (AppException e) {
			throw e;
		}
	}
	
	public LinkedList<Prestamo> getPrestamosCliente(Cliente c) throws AppException {
		try {
			LinkedList<Prestamo> prestamos = dp.getPrestamosCliente(c);
			for (Prestamo prestamo : prestamos) {
				prestamo.setReview(dr.getByPrestamo(prestamo));
			}
			return prestamos;
		} catch (AppException e) {
			throw e;
		}
	}

}
