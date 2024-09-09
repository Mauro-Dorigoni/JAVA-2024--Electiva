package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.*;
import logic.*;
import java.util.List;
import java.util.LinkedList;
import java.util.Collections;
import java.util.Comparator;

@WebServlet("/orderLibros")
public class OrderLibrosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public OrderLibrosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String sortBy = request.getParameter("sortBy");
		 CRUD_libro cl = new CRUD_libro();
		 CRUD_categoria_libro cc = new CRUD_categoria_libro();
		 try {
			LinkedList<Categoria_libro> categorias = cc.getAll();
			 List<Libro> libros = cl.getAll();
			 if ("title".equals(sortBy)) {
			        Collections.sort(libros, new Comparator<Libro>() {
			            @Override
			            public int compare(Libro l1, Libro l2) {
			                return l1.getTitulo().compareToIgnoreCase(l2.getTitulo());
			            }
			        });
			    } else if ("categoria".equals(sortBy)) {
			        Collections.sort(libros, new Comparator<Libro>() {
			            @Override
			            public int compare(Libro l1, Libro l2) {
			                return l1.getCategoria().getNombre_categoria().compareToIgnoreCase(l2.getCategoria().getNombre_categoria());
			            }
			        });
				} /*
					 * else if ("puntaje".equals(sortBy)) { Collections.sort(libros, new
					 * Comparator<Libro>() {
					 * 
					 * @Override public int compare(Libro l1, Libro l2) { return
					 * Double.compare(l2.getPuntaje(), l1.getPuntaje()); // Orden descendente } });
					 * }
					 */
			 LinkedList<String> autores = new LinkedList<>();
			    for(Libro libro : libros){
			    	if(!autores.contains(libro.getAutor())){
			    		autores.add(libro.getAutor());
			    	}
			    }
			    request.setAttribute("autores", autores);
			    request.setAttribute("categorias", categorias);
			 	request.setAttribute("libros", libros);
			    request.getRequestDispatcher("/userDashboard.jsp").forward(request, response);
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
