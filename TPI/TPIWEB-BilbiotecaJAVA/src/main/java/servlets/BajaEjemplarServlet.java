package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.LinkedList;

import entidades.*;
import logic.*;

@WebServlet("/bajaEjemplar")
public class BajaEjemplarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public BajaEjemplarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	//Recibo el id de un ejemplar y hago una baja logica en la BD. Devuelvo un mensaje de exito en la misma pagina de la cual fueron enviados los datos
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		//Declaro los controladores necesarios
		CRUD_ejemplar ce = new CRUD_ejemplar();
		try {
			//Recupero los datos y armo el objeto Ejemplar a modificar
			Ejemplar ejemplar = new Ejemplar();
			Libro libro = new Libro();
			libro.setIdLibro(Integer.parseInt(request.getParameter("libro")));
			ejemplar.setLibro(libro);
			ejemplar.setIdEjemplar(Integer.parseInt(request.getParameter("ejemplar")));
			
			//realizo la baja logica
			ce.delete(ejemplar);
			
			//como vuelvo a la misma pagina, necesito todos los ejemplares y los libros de estos
			LinkedList<Ejemplar> ejemplares = ce.getAll();
			LinkedList<Libro> librosM = new LinkedList<>();
			for (Ejemplar ejem : ejemplares) {
				if (!librosM.contains(ejem.getLibro())){
					librosM.add(ejem.getLibro());
				}
			}
			request.setAttribute("ejemplares", ejemplares);
			request.setAttribute("libros", librosM);
			request.setAttribute("messageType", "success");
		    request.setAttribute("message", "Ejemplar modificado con éxito.");
			request.getRequestDispatcher("bajaEjemplar.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
