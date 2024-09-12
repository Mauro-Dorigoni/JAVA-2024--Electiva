package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedList;

import entidades.*;
import logic.*;

@WebServlet("/registerPrestamo")
public class RegisterPrestamoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterPrestamoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_Cliente cc = new CRUD_Cliente();
		ControladorPrestamo cp = new ControladorPrestamo();
		
		Cliente cliente = new Cliente();
		cliente.setMail(request.getParameter("userEmail"));
		
		Libro libro = new Libro();
		libro.setIdLibro((Integer.parseInt(request.getParameter("idLibro"))));
		
		Ejemplar ejemplar = new Ejemplar();
		ejemplar.setIdEjemplar(Integer.parseInt(request.getParameter("idEjemplar")));
		ejemplar.setLibro(libro);
	
		try {
			cliente = cc.getByMail(cliente);
			
			Prestamo prestamo = new Prestamo();
			prestamo.setCliente(cliente);
			prestamo.setEjemplar(ejemplar);
			
			cp.save(prestamo);
			
			request.setAttribute("messageType", "success");
            request.setAttribute("message", "Prestamo registrado con éxito. Podra buscar su libro a partir de mañana 9:00 AM - Zeballos 1341");
            
            CRUD_ejemplar ce = new CRUD_ejemplar();
            LinkedList<Ejemplar> ejemplares = ce.getEjemplaresLibres(libro);
            request.setAttribute("ejemplares", ejemplares);
            
            CRUD_libro cl = new CRUD_libro();
            libro = cl.getOne(libro);
            request.setAttribute("libro", libro);
            
            request.getRequestDispatcher("checkoutPrestamo.jsp").forward(request, response);
            
            
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
	}

}
