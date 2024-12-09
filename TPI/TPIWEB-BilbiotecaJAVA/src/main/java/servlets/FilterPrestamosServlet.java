package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import entidades.*;
import logic.*;
import java.util.LinkedList;
import java.util.stream.Collectors;

@WebServlet("/filterPrestamos")
public class FilterPrestamosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public FilterPrestamosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Seguridad
		try {
			HttpSession session = request.getSession();
			String userEmail = (String) session.getAttribute("userEmail");
		    String userRole = (String) session.getAttribute("userRole");
		    if(userEmail == null || !userRole.equals("admin")) {
			    request.getRequestDispatcher("index.jsp").forward(request, response);
		        return;
		    }
		} catch (Exception e) {
			AppException ae = new AppException("Error: Error de autenticacion");
			request.setAttribute("error", ae);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		EstadoPrestamo estadoFilter = EstadoPrestamo.valueOf(request.getParameter("estadoFilter"));
		LinkedList<Prestamo> prestamosFiltrados = new LinkedList<>();
		ControladorPrestamo cp = new ControladorPrestamo();
		try {
			LinkedList<Prestamo> prestamos = cp.getAll();
			if (estadoFilter == null) {
	            prestamosFiltrados = prestamos; 
	        } else {
	            prestamosFiltrados = prestamos.stream()
	                .filter(prestamo -> prestamo.getEstado().equals(estadoFilter))
	                .collect(Collectors.toCollection(LinkedList::new));
	        }
			request.setAttribute("prestamos", prestamosFiltrados);
			request.getRequestDispatcher("listarPrestamos.jsp").forward(request, response);
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
