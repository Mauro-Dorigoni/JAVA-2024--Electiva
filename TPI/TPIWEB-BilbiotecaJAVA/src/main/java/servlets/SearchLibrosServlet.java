package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedList;
import entidades.*;
import logic.*;

@WebServlet("/searchLibros")
public class SearchLibrosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SearchLibrosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String query = request.getParameter("query");
		CRUD_libro cl = new CRUD_libro();
		CRUD_categoria_libro cc = new CRUD_categoria_libro();
		Libro libABuscar = new Libro();
		libABuscar.setTitulo(query);
		libABuscar.setSumario(query);
		try {
			LinkedList<Libro> libros = cl.search(libABuscar);
			if(libros.isEmpty()) {
				LinkedList<Libro> librosAutor = cl.getAll();
				LinkedList<String> autores = new LinkedList<>();
				    for(Libro libro : librosAutor){
				    	if(!autores.contains(libro.getAutor())){
				    		autores.add(libro.getAutor());
				    	}
				    }
				  LinkedList<Categoria_libro> categorias = cc.getAll();
				  request.setAttribute("messageType", "error");
	              request.setAttribute("message", "No se encontraron libros con estos datos");
	              request.setAttribute("categorias", categorias);
	              String filterBy = "Todos";
				  String filtro = "Todos";
				  request.setAttribute("libros", librosAutor);
				  request.setAttribute("opcion", filterBy);
				  request.setAttribute("filtro", filtro);
				  request.setAttribute("autores", autores);
				  
			}else {
				LinkedList<String> autores = new LinkedList<>();
				LinkedList<Categoria_libro> categorias = new LinkedList<>();
				for (Libro libro : libros) {
					autores.add(libro.getAutor());
					categorias.add(libro.getCategoria());
				}
				request.setAttribute("categorias", categorias);
				request.setAttribute("autores", autores);
				String filterBy = "Todos";
				String filtro = "Todos";
				request.setAttribute("opcion", filterBy);
				request.setAttribute("filtro", filtro);
				request.setAttribute("libros", libros);
			}
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
