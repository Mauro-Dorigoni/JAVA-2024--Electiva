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

@WebServlet("/listPrestamos")
public class ListPrestamosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ListPrestamosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ControladorPrestamo cp = new ControladorPrestamo();

		try {
			LinkedList<Prestamo> prestamos = cp.getAll();
			request.setAttribute("prestamos", prestamos);
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
