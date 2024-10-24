package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.*;
import logic.*;
import java.util.*;

@WebServlet("/listLibros")
public class ListLibrosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListLibrosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
//El GET de este Servlet es utilizado a lo largo de la aplicacion multiples veces, siendo llamado desde distintas partes del frontend para recuperar el listado de libros
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Controladores necesarios
		CRUD_libro cl = new CRUD_libro();
		CRUD_categoria_libro cc = new CRUD_categoria_libro();
		try {
			//recupero todos los libros y los envio en la respuesta
			LinkedList<Libro> libros = cl.getAll();
			request.setAttribute("libros", libros);
			
			//recupero indicador de que parte del frontend vino la request
			String action = request.getParameter("actionLibro");
			
			//segun que parte del frontend vino la request, redirijo a donde sea necesario
			if("listado".equals(action)) {request.getRequestDispatcher("listarLibros.jsp").forward(request, response);}
			else if ("modificar".equals(action)) {request.getRequestDispatcher("modificarLibros.jsp").forward(request, response);}
			else if ("baja".equals(action)) {request.getRequestDispatcher("bajaLibro.jsp").forward(request, response);}
			else if ("ejemplares".equals(action)) {request.getRequestDispatcher("altaEjemplar.jsp").forward(request, response);}
			else if ("userDashboard".equals(action)) {
				try {
					//en la vista de usuario, necesito tambien todas las categorias, todos los autores y el filtro y orden predeterminados en la respuesta
					LinkedList<Categoria_libro> categorias = cc.getAll();
					request.setAttribute("categorias", categorias);
					LinkedList<String> autores = new LinkedList<>();
				    for(Libro libro : libros){
				    	if(!autores.contains(libro.getAutor())){
				    		autores.add(libro.getAutor());
				    	}
				    }
				    String filterBy = "Todos";
				    String filtro = "Todos";
				    request.setAttribute("opcion", filterBy);
				    request.setAttribute("filtro", filtro);
				    request.setAttribute("autores", autores);
					request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
				} catch (AppException e) {
					request.setAttribute("error", e);
					request.getRequestDispatcher("error.jsp").forward(request, response);
				}
			}} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
