package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.*;
import java.util.LinkedList;
import logic.*;

@WebServlet("/libroBaja")
public class BajaLibroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BajaLibroServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_libro cl = new CRUD_libro();
		Libro libro = new Libro();
		libro.setIdLibro(Integer.parseInt(request.getParameter("idLibro")));
		try {
			cl.delete(libro);
			LinkedList<Libro> libs = cl.getAll();
			request.setAttribute("messageType", "success");
		    request.setAttribute("message", "Libro eliminado con éxito.");
		    request.setAttribute("libros", libs);
		    request.getRequestDispatcher("bajaLibro.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
