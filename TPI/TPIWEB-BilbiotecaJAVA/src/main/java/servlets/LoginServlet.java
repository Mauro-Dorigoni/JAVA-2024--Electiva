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
        Cliente user = login.validate(c);
        if(user == null) {
        	HttpSession session = request.getSession();
            session.setAttribute("user", mail);
			response.sendRedirect("login.jsp");;
		}
		else {
			if(user.isAdmin()) {response.sendRedirect("loginSuccess.jsp");}
			else {response.sendRedirect("loginSuccess.jsp");}
		}
        
    }
}
