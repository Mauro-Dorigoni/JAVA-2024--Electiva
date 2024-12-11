package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import entidades.AppException;
import entidades.Categoria_libro;
import logic.CRUD_categoria_libro;

@WebServlet("/categoriaDetail")
public class CategoriaDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Seguridad
		try {
			HttpSession session = request.getSession();
			String userEmail = (String) session.getAttribute("userEmail");
		    if(userEmail == null) {
			    request.getRequestDispatcher("index.jsp").forward(request, response);
		        return;
		    }
		} catch (Exception e) {
			AppException ae = new AppException("Error: Error de autenticacion");
			request.setAttribute("error", ae);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		String action = request.getParameter("action");
		CRUD_categoria_libro cl = new CRUD_categoria_libro();
		Categoria_libro cat = new Categoria_libro();
		int id = Integer.parseInt(request.getParameter("idCategoria"));
		cat.setIdCategoria(id);
        try {
        	cat = cl.getOne(cat);
    		request.setAttribute("categoria", cat);
            if("user".equals(action)) {
            	request.getRequestDispatcher("detalleCategoriaUser.jsp").forward(request, response);
            	
            }else {
            	request.getRequestDispatcher("detalleCategoria.jsp").forward(request, response);
            }	
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
