package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedList;

import entidades.*;
import logic.*;

@WebServlet("/verifyPrestamo")
public class VerifyPrestamoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public VerifyPrestamoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		CRUD_libro cl = new CRUD_libro();
		CRUD_ejemplar ce = new CRUD_ejemplar();
		CRUD_Cliente cc = new CRUD_Cliente();
		CRUD_categoria_libro clibro = new CRUD_categoria_libro();
		ControladorPrestamo cp = new ControladorPrestamo();
		
		Cliente cliente = new Cliente();
		cliente.setMail(request.getParameter("userEmail"));
		try {
			cliente = cc.getByMail(cliente);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
		Libro libro = new Libro();
		libro.setIdLibro(Integer.parseInt(request.getParameter("idLibro")));
		try {
			libro = cl.getOne(libro);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
		try {
			String validacion = cp.validate(cliente, libro);
			LinkedList<Libro> librosTodos = cl.getAll(); 
			LinkedList<Categoria_libro> categorias = clibro.getAll();
			LinkedList<String> autores = new LinkedList<>();
		    for(Libro libroT : librosTodos){
		    	if(!autores.contains(libroT.getAutor())){
		    		autores.add(libroT.getAutor());
		    	}
		    }
		    String filterBy = "Todos";
		    String filtro = "Todos";
		    
			if("Validado".equals(validacion)) {
				LinkedList<Ejemplar> ejemplaresLibres = ce.getEjemplaresLibres(libro);
				request.setAttribute("libro", libro);
				request.setAttribute("ejemplares", ejemplaresLibres);
				request.getRequestDispatcher("checkoutPrestamo.jsp").forward(request, response);
			} else if ("Activos".equals(validacion)){
				request.setAttribute("messageType", "error");
                request.setAttribute("message", "Usted tiene 3 prestamos activos y no podra realizar otro hasta devolver alguno");
                request.setAttribute("categorias", categorias);
                request.setAttribute("libros", librosTodos);
                request.setAttribute("opcion", filterBy);
			    request.setAttribute("filtro", filtro);
			    request.setAttribute("autores", autores);
    		    request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
			} else if("Vencidos".equals(validacion)) {
				request.setAttribute("messageType", "error");
                request.setAttribute("message", "Usted tiene prestamos vencidos sin devolver");
                request.setAttribute("categorias", categorias);
                request.setAttribute("libros", librosTodos);
                request.setAttribute("opcion", filterBy);
			    request.setAttribute("filtro", filtro);
			    request.setAttribute("autores", autores);
    		    request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
			} else if("Pagos".equals(validacion)) {
				request.setAttribute("messageType", "error");
                request.setAttribute("message", "Usted debe al menos 2 meses de abono a la biblioteca");
                request.setAttribute("categorias", categorias);
                request.setAttribute("libros", librosTodos);
                request.setAttribute("opcion", filterBy);
			    request.setAttribute("filtro", filtro);
			    request.setAttribute("autores", autores);
    		    request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
			} else if("Ejemplares".equals(validacion)) {
				request.setAttribute("messageType", "error");
                request.setAttribute("message", "No hay ejemplares disponibles del libro: "+libro.getTitulo()+". Lo sentimos");
                request.setAttribute("categorias", categorias);
                request.setAttribute("libros", librosTodos);
                request.setAttribute("opcion", filterBy);
			    request.setAttribute("filtro", filtro);
			    request.setAttribute("autores", autores);
    		    request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
			}
				
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
	}

}
