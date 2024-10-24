package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.*;
import logic.*;

@WebServlet("/userDetail")
public class UserDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UserDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    //Los detalles del cliente son necesitados para multiples paginas del frontend
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_Cliente cl = new CRUD_Cliente();
		Cliente cliente = new Cliente();
		cliente.setMail(request.getParameter("userEmail"));
		String action = request.getParameter("action");
		try {
			cliente = cl.getByMail(cliente);
			request.setAttribute("cliente", cliente);
			//dependiendo del parametro de entrada, redirijo a la pagina necesaria
			switch (action) {
			case "pagos":
				request.getRequestDispatcher("misPagos.jsp").forward(request, response);
				break;
			case "contra":
				request.getRequestDispatcher("cambioContra.jsp").forward(request, response);
				break;
			case "baja":
				request.getRequestDispatcher("bajaUsuario.jsp").forward(request, response);
				break;
			default:
				break;
			}
			request.getRequestDispatcher("misPagos.jsp").forward(request, response);
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
