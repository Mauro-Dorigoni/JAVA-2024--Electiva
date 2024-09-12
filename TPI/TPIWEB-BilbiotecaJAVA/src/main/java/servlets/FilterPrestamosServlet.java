package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
		String estadoFilter = request.getParameter("estadoFilter");
		LinkedList<Prestamo> prestamosFiltrados = new LinkedList();
		ControladorPrestamo cp = new ControladorPrestamo();
		try {
			LinkedList<Prestamo> prestamos = cp.getAll();
			if (estadoFilter == null || estadoFilter.isEmpty()) {
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
