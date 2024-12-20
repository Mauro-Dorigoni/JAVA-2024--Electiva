package servlets;
import entidades.*;
import logic.CRUD_Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cliente c = new Cliente();
		String nombre = request.getParameter("firstName");
		String apellido = request.getParameter("lastName");
		String email = request.getParameter("emailAddress");
		String dni = request.getParameter("dni");
		String contra = request.getParameter("form3Example4c");
		c.setNombre(nombre);
		c.setApellido(apellido);
		c.setMail(email);
		c.setDni(dni);
		c.setContra(contra);
		
		CRUD_Cliente cc = new CRUD_Cliente();
		try {
			if(cc.getByMail(c)==null) {
				cc.registrarCliente(c);
				request.setAttribute("messageType", "success");
	            request.setAttribute("message", "Cliente registrado con éxito.");
			}
			else {
				request.setAttribute("messageType", "error");
	            request.setAttribute("message", "Ese mail ya se encuentra registrado.");
			}
			request.getRequestDispatcher("register.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}

	}
}
