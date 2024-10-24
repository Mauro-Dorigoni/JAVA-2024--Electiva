package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.*;
import logic.*;

@WebServlet("/changePass")
public class ChangePassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ChangePassServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

//Este servlet recibe email, contra actual y contra nueva del cliente, y si se cumple la validacion, actualiza la contra del cliente
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//declaro los controladores necesarios
		CRUD_Cliente cl = new CRUD_Cliente();
		Login l = new Login();
		//recupero los parametros del formulario, contra actual, mail de usuario y nueva contra
		String userEmail = request.getParameter("userEmail");
		String contraActual = request.getParameter("curpassword");
		String contraNueva = request.getParameter("newpassword");
		Cliente cin = new Cliente();
		cin.setMail(userEmail);
		cin.setContra(contraActual);
		try {
			//valido que la contra sea correcta
			Cliente c = l.validate(cin);
			if (c==null) {
				//si no es correcta, informo
				request.setAttribute("messageType", "error");
                request.setAttribute("message", "Contraseña incorrecta");
                request.setAttribute("cliente", cin);
                request.getRequestDispatcher("cambioContra.jsp").forward(request, response);
                
			}
			//si es correcta, actualizo contra
			c.setContra(contraNueva);
			cl.updatePass(c);
			request.setAttribute("messageType", "success");
            request.setAttribute("message", "Cambio realizado con exito. Por razones de seguridad, le pediremos que se loguee nuevamente");
            request.setAttribute("cliente", c);
            request.getRequestDispatcher("cambioContra.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
