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
import java.util.Arrays;
import java.util.stream.Collectors;

@WebServlet("/orderLibros")
public class OrderLibroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderLibroServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String sortBy = request.getParameter("sortBy");
		 String librosIdsParam = request.getParameter("librosIds");
		 String[] librosIdsArray = librosIdsParam != null ? librosIdsParam.split(",") : new String[0];
		 List<Integer> librosIds = Arrays.stream(librosIdsArray).map(Integer::parseInt).collect(Collectors.toList());
		 LinkedList<Libro> libros = new LinkedList<>();
		 CRUD_libro cl = new CRUD_libro();
		 CRUD_categoria_libro cc = new CRUD_categoria_libro();
		 String filtro = new String();
		 try {
			 for (Integer idLibro : librosIds) {
				Libro libro = new Libro();
				libro.setIdLibro(idLibro);
				libro = cl.getOne(libro);
				libros.add(libro);
				}
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
			 LinkedList<Libro> librosAutor = cl.getAll();
			 LinkedList<String> autores = new LinkedList<>();
			    for(Libro libro : librosAutor){
			    	if(!autores.contains(libro.getAutor())){
			    		autores.add(libro.getAutor());
			    	}
			    }
			  LinkedList<Categoria_libro> categorias = cc.getAll();
			  String filterBy = request.getParameter("filterBy");
		      String category = request.getParameter("category");
		      String author = request.getParameter("author");
		      switch (filterBy) {
              case "category":
                  filtro = category;
                  break;
              case "autor":
                  filtro = author;
                  break;
              default:
                  filtro = "Todos";
                  break;
              }
		        request.setAttribute("filterBy", filterBy);
		        request.setAttribute("filtro", filtro);  
		        request.setAttribute("autores", autores);
			    request.setAttribute("categorias", categorias);
			 	request.setAttribute("libros", libros);
			    request.getRequestDispatcher("/userDashboard.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		 
	}

}
