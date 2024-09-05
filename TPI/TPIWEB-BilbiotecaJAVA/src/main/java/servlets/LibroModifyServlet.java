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

@WebServlet("/libroModify")
public class LibroModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LibroModifyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_categoria_libro cc = new CRUD_categoria_libro();
		LinkedList<Categoria_libro> cats = cc.getAll();
		request.setAttribute("categorias", cats);
		CRUD_libro cl = new CRUD_libro();
		Libro libro = new Libro();
		libro.setIdLibro(Integer.parseInt(request.getParameter("idLibro")));
		libro = cl.getOne(libro);
		request.setAttribute("libro", libro);
		request.getRequestDispatcher("modificarLibro.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_libro cl = new CRUD_libro();
		Libro libro = new Libro();
		Categoria_libro cat = new Categoria_libro();
		libro.setIdLibro(Integer.parseInt(request.getParameter("idLibro")));
		libro.setAutor(request.getParameter("autor"));
		libro.setTitulo(request.getParameter("titulo"));
		libro.setSumario(request.getParameter("sumario"));
		libro.setISBN(request.getParameter("isbn"));
		cat.setIdCategoria(Integer.parseInt(request.getParameter("categoria")));
		libro.setCategoria(cat);
		cl.update(libro);
		LinkedList<Categoria_libro> cats = new LinkedList<>();
		cats.add(cat);
		request.setAttribute("messageType", "success");
	    request.setAttribute("message", "Libro modificado con éxito.");
	    request.setAttribute("libro", libro);
	    request.setAttribute("categorias", cats);
	    // Redirige a la misma página JSP para mostrar el mensaje
	    request.getRequestDispatcher("modificarLibro.jsp").forward(request, response);
	}

}
