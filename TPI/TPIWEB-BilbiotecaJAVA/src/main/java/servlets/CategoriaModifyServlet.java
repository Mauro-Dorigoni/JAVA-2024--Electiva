package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import logic.CRUD_categoria_libro;

import java.io.IOException;

import entidades.*;

@WebServlet("/categoriaModify")
public class CategoriaModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoriaModifyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Seguridad
		try {
			HttpSession session = request.getSession();
			String userEmail = (String) session.getAttribute("userEmail");
		    String userRole = (String) session.getAttribute("userRole");
		    if(userEmail == null || !userRole.equals("admin")) {
			    request.getRequestDispatcher("index.jsp").forward(request, response);
		        return;
		    }
		} catch (Exception e) {
			AppException ae = new AppException("Error: Error de autenticacion");
			request.setAttribute("error", ae);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		CRUD_categoria_libro cl = new CRUD_categoria_libro();
		Categoria_libro cat = new Categoria_libro();
		int id = Integer.parseInt(request.getParameter("idCategoria"));
		cat.setIdCategoria(id);
        try {
        	cat.setIdCategoria(id);
    		cat = cl.getOne(cat);
    		request.setAttribute("categoria", cat);
            request.getRequestDispatcher("modificarCategoria.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    CRUD_categoria_libro cl = new CRUD_categoria_libro();
	    Categoria_libro cat = new Categoria_libro();
	    cat.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
	    cat.setNombre_categoria(request.getParameter("nombre"));
	    cat.setDescripcion_apliada(request.getParameter("descripcion"));

	    try {
	    	cl.modify_desc(cat);

		    // Establece los atributos para el mensaje
		    request.setAttribute("messageType", "success");
		    request.setAttribute("message", "Categoría modificada con éxito.");
		    request.setAttribute("categoria", cat);
		    
		    // Redirige a la misma página JSP para mostrar el mensaje
		    request.getRequestDispatcher("modificarCategoria.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}


}
