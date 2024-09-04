package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.Categoria_libro;
import logic.CRUD_categoria_libro;
import java.util.LinkedList;

@WebServlet("/listCategorias")
public class ListCategoriasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_categoria_libro cl = new CRUD_categoria_libro();
		LinkedList<Categoria_libro> categorias = new LinkedList<>();
		categorias = cl.getAll();
		request.setAttribute("categorias", categorias);
		String action = request.getParameter("action");
		if("listado".equals(action)) {request.getRequestDispatcher("listarCategorias.jsp").forward(request, response);}
		else if("modificar".equals(action)) {request.getRequestDispatcher("modificarCategorias.jsp").forward(request, response);}
		else if("baja".equals(action)) {request.getRequestDispatcher("bajaCategoria.jsp").forward(request, response);}
		else if("altaLibro".equals(action)) {request.getRequestDispatcher("altaLibro.jsp").forward(request, response);}
	}

}
