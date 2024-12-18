package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import logic.CRUD_Cliente;
import logic.ControladorReview;

import java.io.IOException;
import java.util.LinkedList;

import entidades.AppException;
import entidades.Cliente;
import entidades.Review;

@WebServlet("/listClienteReviews")
public class ListClienteReviewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListClienteReviewsServlet() {
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
		ControladorReview cr = new ControladorReview();
		try {
			String userEmail = request.getParameter("userEmail");
			Cliente c = new Cliente();
			c.setMail(userEmail);
			c = cc.getByMail(c);
			LinkedList<Review> reviews = cr.getByCliente(c);
			request.setAttribute("reviews", reviews);
			request.getRequestDispatcher("listarReviewsUser.jsp").forward(request, response);
			
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
