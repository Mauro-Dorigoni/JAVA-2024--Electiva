package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import entidades.*;
import logic.*;

@WebServlet("/libroDetail")
public class LibroDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LibroDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


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
		CRUD_libro cl = new CRUD_libro();
		Libro libro = new Libro();
		libro.setIdLibro(Integer.parseInt(request.getParameter("idLibro")));
		try {
			libro = cl.getOne(libro);
			request.setAttribute("libro", libro);
			if("admin".equals(action)) {request.getRequestDispatcher("detalleLibro.jsp").forward(request, response);}
			else{request.getRequestDispatcher("detalleLibroUser.jsp").forward(request, response);}
	        
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
