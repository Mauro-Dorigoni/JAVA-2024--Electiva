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
import java.util.List;
import java.util.ArrayList;

@WebServlet("/filterLibros")
public class FilterLibrosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public FilterLibrosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_categoria_libro cc = new CRUD_categoria_libro();
		try {
			LinkedList<Categoria_libro> categorias = cc.getAll();
			request.setAttribute("categorias", categorias);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		String filterBy = request.getParameter("filterBy");
        String category = request.getParameter("category");
        String author = request.getParameter("author");
        CRUD_libro cl = new CRUD_libro();
        try {
			LinkedList<Libro> libros = cl.getAll();
			LinkedList<String> autores = new LinkedList<>();
			String filtro = new String();
		    for(Libro libro : libros){
		    	if(!autores.contains(libro.getAutor())){
		    		autores.add(libro.getAutor());
		    	}
		    }
		    request.setAttribute("autores", autores);
			List<Libro> librosFiltrados = new ArrayList<>();
			for (Libro libro : libros) {
	            boolean match = false;
	            switch (filterBy) {
	                case "category":
	                    match = libro.getCategoria().getNombre_categoria().equals(category);
	                    filtro = category;
	                    break;
	                case "autor":
	                    match = libro.getAutor().equals(author);
	                    filtro = author;
	                    break;
	                default:
	                    match = true;
	                    break;
	            }
	            if (match) {
	                librosFiltrados.add(libro);
	            }
	        }
	        request.setAttribute("filterBy", filterBy);
	        request.setAttribute("filtro", filtro);
	        request.setAttribute("libros", librosFiltrados);
	        request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
			
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
