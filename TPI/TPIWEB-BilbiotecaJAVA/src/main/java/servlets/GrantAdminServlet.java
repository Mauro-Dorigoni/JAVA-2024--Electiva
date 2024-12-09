package servlets;

import jakarta.servlet.ServletException;
import entidades.*;
import logic.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.LinkedList;

@WebServlet("/grantAdmin")
public class GrantAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GrantAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

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
		CRUD_Cliente cc = new CRUD_Cliente();
		Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
		Cliente c = new Cliente();
		c.setId(idCliente);
		try {
			cc.grantAdmin(c);
			LinkedList<Cliente> clientes = cc.getAll();
			request.setAttribute("clientes", clientes);
			request.setAttribute("messageType", "success");
            request.setAttribute("message", "Permisos otorgados con exito");
            request.getRequestDispatcher("otorgarPermisos.jsp").forward(request, response);
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
