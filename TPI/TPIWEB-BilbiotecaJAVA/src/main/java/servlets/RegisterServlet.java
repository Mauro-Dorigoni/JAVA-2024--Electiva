package servlets;
import entidades.Cliente;
import logic.CRUD_Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
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
		
		if(cc.getByMail(c)==null) {
			cc.registrarCliente(c);
			response.sendRedirect("loginSuccess.jsp");
		}
		else {
			response.sendRedirect("login.jsp");
		}
	}

}
