package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import logic.CRUD_categoria_libro;
import java.io.IOException;
import java.util.LinkedList;
import entidades.*;

@WebServlet("/categoriaBaja")
public class BajaCategoriaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BajaCategoriaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
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
		
		CRUD_categoria_libro cl = new CRUD_categoria_libro();
	    Categoria_libro cat = new Categoria_libro();
	    cat.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
	    try {
	    	cl.baja(cat);
		    request.setAttribute("messageType", "success");
		    request.setAttribute("message", "Categoría eliminada con éxito.");
		    LinkedList<Categoria_libro> cats = cl.getAll();		    
		    request.setAttribute("categorias", cats);
		    request.getRequestDispatcher("bajaCategoria.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}


}
