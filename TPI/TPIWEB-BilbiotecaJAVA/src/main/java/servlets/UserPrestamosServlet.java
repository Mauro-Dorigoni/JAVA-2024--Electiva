package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.LinkedList;
import entidades.*;
import logic.*;

@WebServlet("/userPrestamos")
public class UserPrestamosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public UserPrestamosServlet() {
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
		CRUD_Cliente cc = new CRUD_Cliente();
		ControladorPrestamo cp = new ControladorPrestamo();
		Cliente cliente = new Cliente();
		cliente.setMail(request.getParameter("userEmail"));
		try {
			cliente = cc.getByMail(cliente);
			LinkedList<Prestamo> prestamosCliente = cp.getPrestamosCliente(cliente);
			request.setAttribute("prestamos", prestamosCliente);
			request.getRequestDispatcher("misPrestamos.jsp").forward(request, response);
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
