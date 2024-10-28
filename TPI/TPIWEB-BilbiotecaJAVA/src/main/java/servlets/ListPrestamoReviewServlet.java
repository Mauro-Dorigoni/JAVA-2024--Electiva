package servlets;

import jakarta.servlet.ServletException;
import entidades.*;
import logic.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/listPrestamoReview")
public class ListPrestamoReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ListPrestamoReviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ControladorReview cr = new ControladorReview();
		try {
			LocalDate fechaPrestamo = LocalDate.parse(request.getParameter("fechaPrestamo"));
			Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
			Integer idEjemplar = Integer.parseInt(request.getParameter("idEjemplar"));
			Integer idLibro = Integer.parseInt(request.getParameter("idLibro"));
			Libro libro = new Libro();
			libro.setIdLibro(idLibro);
			Ejemplar ejemplar = new Ejemplar();
			ejemplar.setLibro(libro);
			ejemplar.setIdEjemplar(idEjemplar);
			Cliente cliente = new Cliente();
			cliente.setId(idCliente);
			Prestamo prestamo = new Prestamo();
			prestamo.setFechaRealizacion(fechaPrestamo);
			prestamo.setEjemplar(ejemplar);
			prestamo.setCliente(cliente);
			Review review = cr.getbyPrestamo(prestamo);
			request.setAttribute("review", review);
			request.getRequestDispatcher("detalleReview.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
