package servlets;

import jakarta.servlet.ServletException;
import entidades.*;
import logic.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

//Este servlet recibe usuario y contrasena, valida y elimina logicamente este usuario
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		//declaro los controladores necesarios
		CRUD_Cliente cl = new CRUD_Cliente();
		Login l = new Login();
		//recupero los parametros del formulario, contra actual, mail de usuario
		String userEmail = request.getParameter("userEmail");
		String contraActual = request.getParameter("curpassword");
		Cliente cin = new Cliente();
		cin.setMail(userEmail);
		cin.setContra(contraActual);
		try {
			Cliente c = l.validate(cin);
			if (c==null) {
				request.setAttribute("messageType", "error");
                request.setAttribute("message", "Contraseña incorrecta");
                request.setAttribute("cliente", cin);
                request.getRequestDispatcher("bajaUsuario.jsp").forward(request, response);
                
			}
			else {
				cl.delete(c);
				request.setAttribute("messageType", "success");
	            request.setAttribute("message", "Su cuenta se ha dado de baja, se cerrara su sesion");
	            request.setAttribute("cliente", c);
	            request.getRequestDispatcher("bajaUsuario.jsp").forward(request, response);
			}
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
