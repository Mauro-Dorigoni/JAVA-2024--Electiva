package servlets;

import jakarta.servlet.ServletException;
import logic.*;
import entidades.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.LinkedList;

import org.eclipse.jdt.internal.compiler.ast.CaseStatement;


@WebServlet("/listEjemplares")
public class ListEjemplaresServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ListEjemplaresServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    //El GET de este Servlet se usa multiples veces a lo largo de la aplicacion para devolver todos los ejemplares de la biblioteca
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		//Declaro los Controladores necesarios
		CRUD_ejemplar ce = new CRUD_ejemplar();
		try {
			//recupero el parametro que me indica de que parte del frontend vino la request
			String action = request.getParameter("actionEjemplares");
			
			//recupero todos los ejemplares y los mando en la respuesta
			LinkedList<Ejemplar> ejemplares = ce.getAll();
			request.setAttribute("ejemplares", ejemplares);
			//segun el valor de action, redirijo a distintas partes de la aplicacion
			switch (action) {
			case "listado":
				request.getRequestDispatcher("listarEjemplares.jsp").forward(request, response);
				break;
			case "modificar":
				//para la modificacion, necesito la lista de libros a los que corresponden los ejemplares
				LinkedList<Libro> librosM = new LinkedList<>();
				for (Ejemplar ejemplar : ejemplares) {
					if (!librosM.contains(ejemplar.getLibro())){
						librosM.add(ejemplar.getLibro());
					}
				}
				request.setAttribute("libros", librosM);
				request.getRequestDispatcher("modificarEjemplar.jsp").forward(request, response);
				break;
			case "baja":
				//para la baja, necesito la lista de libros a los que corresponden los ejemplares
				LinkedList<Libro> librosB = new LinkedList<>();
				for (Ejemplar ejemplar : ejemplares) {
					if (!librosB.contains(ejemplar.getLibro())){
						librosB.add(ejemplar.getLibro());
					}
				}
				request.setAttribute("libros", librosB);
				request.getRequestDispatcher("bajaEjemplar.jsp").forward(request, response);
				break;

			default:
				break;
			}
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
