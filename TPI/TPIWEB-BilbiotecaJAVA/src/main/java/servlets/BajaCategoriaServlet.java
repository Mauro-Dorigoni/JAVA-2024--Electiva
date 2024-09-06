package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
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
		CRUD_categoria_libro cl = new CRUD_categoria_libro();
	    Categoria_libro cat = new Categoria_libro();
	    LinkedList<Categoria_libro> cats = new LinkedList<>();
	    cat.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
	    try {
	    	cl.baja(cat);
		    request.setAttribute("messageType", "success");
		    request.setAttribute("message", "Categoría eliminada con éxito.");
		    cats.add(cat);
		    request.setAttribute("categorias", cats);
		    
		    request.getRequestDispatcher("bajaCategoria.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}


}
