package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.Categoria_libro;
import logic.CRUD_categoria_libro;

@WebServlet("/categoriaDetail")
public class CategoriaDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_categoria_libro cl = new CRUD_categoria_libro();
		Categoria_libro cat = new Categoria_libro();
		int id = Integer.parseInt(request.getParameter("idCategoria"));
		cat.setIdCategoria(id);
		cat = cl.getOne(cat);
		request.setAttribute("categoria", cat);
        request.getRequestDispatcher("detalleCategoria.jsp").forward(request, response);
	}



}