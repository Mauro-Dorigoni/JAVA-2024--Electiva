package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import logic.ControladorPrestamo;
import logic.ControladorReview;

import java.io.IOException;
import java.time.LocalDate;

import entidades.AppException;
import entidades.Cliente;
import entidades.Ejemplar;
import entidades.EstadoPrestamo;
import entidades.Libro;
import entidades.Prestamo;
import entidades.Review;

@WebServlet("/registerReview")
public class RegisterReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public RegisterReviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Seguridad
		try {
			HttpSession session = request.getSession();
			String userEmail = (String) session.getAttribute("userEmail");
		    if(userEmail == null) {
			    request.getRequestDispatcher("index.jsp").forward(request, response);
		        return;
		    }
		} catch (Exception e) {
			AppException ae = new AppException("Error: Error de autenticacion");
			request.setAttribute("error", ae);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		ControladorPrestamo cp = new ControladorPrestamo();
		ControladorReview cr = new ControladorReview();
		try {
			LocalDate fechaPrestamo = LocalDate.parse(request.getParameter("fechaPrestamo"));
			Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
			Integer idEjemplar = Integer.parseInt(request.getParameter("idEjemplar"));
			Integer idLibro = Integer.parseInt(request.getParameter("idLibro"));
			Integer puntaje = Integer.parseInt(request.getParameter("puntaje"));
			String descripcion = request.getParameter("descripcion");
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
			if(prestamo.getEstado()!=EstadoPrestamo.DEVUELTO) {
				AppException e = new AppException("El prestamo no fue devueto");
				request.setAttribute("error", e);
				request.getRequestDispatcher("error.jsp").forward(request, response);
			}
			Review review = new Review();
			review.setPuntaje(puntaje);
			review.setDescripcion(descripcion);
			review.setPrestamo(prestamo);
			cr.save(review);
			review = cr.getbyPrestamo(prestamo);
			request.setAttribute("review", review);
			request.setAttribute("messageType", "success");
            request.setAttribute("message", "Reseña registrada con exito");
			request.getRequestDispatcher("detalleReview.jsp").forward(request, response);
			
			
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
