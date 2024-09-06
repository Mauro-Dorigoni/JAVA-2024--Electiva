package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import entidades.*;
import logic.*;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mail = request.getParameter("username");
        String contra = request.getParameter("password");
        Cliente c = new Cliente();
        c.setMail(mail);
        c.setContra(contra);
        Login login = new Login();
        try {
        	Cliente user = login.validate(c);
            if(user == null) {
            	request.setAttribute("messageType", "error");
                request.setAttribute("message", "Usuario no encontrado");
    		    request.getRequestDispatcher("login.jsp").forward(request, response);
    		}
    		else {
    			HttpSession session = request.getSession();
    		    session.setAttribute("userEmail", mail); 
    		    session.setAttribute("userRole", user.isAdmin() ? "admin" : "client");
    		    response.sendRedirect(user.isAdmin() ? "adminDashboard.jsp" : "loginSuccess.jsp");
    		}
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
        
    }
}
