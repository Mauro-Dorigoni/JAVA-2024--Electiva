package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.*;
import logic.*;
import java.time.LocalDate;

@WebServlet("/newReview")
public class NewReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public NewReviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

//Este es un servlet que actua de intermediario entre el listado de prestamos y el formulario de registro de review
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ControladorPrestamo cp = new ControladorPrestamo();
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
			prestamo = cp.getOne(prestamo);
			request.setAttribute("prestamo", prestamo);
			request.getRequestDispatcher("nuevaReview.jsp").forward(request, response);
			
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
