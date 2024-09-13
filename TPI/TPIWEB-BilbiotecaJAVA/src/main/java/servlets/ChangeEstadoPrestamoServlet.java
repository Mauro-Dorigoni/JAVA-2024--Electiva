package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.*;
import logic.*;
import java.time.*;
import java.util.LinkedList;

@WebServlet("/changeEstadoPrestamo")
public class ChangeEstadoPrestamoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ChangeEstadoPrestamoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ControladorPrestamo cp = new ControladorPrestamo();
		Prestamo prestamo = new Prestamo();
		
		Cliente cliente = new Cliente();
		cliente.setId(Integer.parseInt(request.getParameter("idCliente")));
		
		Libro libro = new Libro();
		libro.setIdLibro(Integer.parseInt(request.getParameter("idLibro")));
		
		Ejemplar ejemplar = new Ejemplar();
		ejemplar.setIdEjemplar(Integer.parseInt(request.getParameter("idEjemplar")));
		ejemplar.setLibro(libro);
		
		prestamo.setCliente(cliente);
		prestamo.setEjemplar(ejemplar);
		prestamo.setFechaRealizacion(LocalDate.parse(request.getParameter("fechaPrestamo")));
		
		String nuevoEstado = request.getParameter("estado");
		prestamo.setEstado(nuevoEstado);
		
		try {
			cp.updateState(prestamo);
			LinkedList<Prestamo> prestamos = cp.getAll();
			request.setAttribute("prestamos", prestamos);
			request.setAttribute("messageType", "success");
			request.setAttribute("message", "Cambio de estado modificado con exito");
			request.getRequestDispatcher("listarPrestamos.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
;
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}