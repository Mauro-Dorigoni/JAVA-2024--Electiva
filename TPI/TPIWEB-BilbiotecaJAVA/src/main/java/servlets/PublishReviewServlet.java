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
import entidades.EstadoReviewEnum;
import entidades.Review;

@WebServlet("/publishReview")
public class PublishReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PublishReviewServlet() {
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
		ControladorReview cr = new ControladorReview();
		CRUD_Cliente cc = new CRUD_Cliente();
		try {
			String mailAdmin = request.getParameter("mailAdmin");
			Cliente admin = new Cliente();
			admin.setMail(mailAdmin);
			admin = cc.getByMail(admin);
			Integer idReview = Integer.parseInt(request.getParameter("idReview"));
			Review review = new Review();
			review.setIdReview(idReview);
			review = cr.getOne(review);
			review.setAdministrativo(admin);
			review.setEstado_review(EstadoReviewEnum.PUBLICADA);
			review.setObservacion_rechazo(null);
			cr.alterState(review);
			LinkedList<Review> reviews = cr.getPendientes();
			request.setAttribute("messageType", "success");
            request.setAttribute("message", "Se ha publicado la reseña");
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("moderarReviews.jsp").forward(request, response);
			
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
