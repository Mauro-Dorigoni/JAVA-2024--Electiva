package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.LinkedList;

import entidades.*;
import logic.*;

@WebServlet("/modifyEjemplar")
public class EjemplarModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public EjemplarModifyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

//recibo los nuevos datos de un ejemplar existente y lo actualizo en la BD. Devuelvo un mensaje de exito en la misma pagina de la cual fueron enviados los datos
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Declaro los controladores necesarios
		CRUD_ejemplar ce = new CRUD_ejemplar();
		try {
			//Recupero los datos y armo el objeto Ejemplar a modificar
			Ejemplar ejemplar = new Ejemplar();
			Libro libro = new Libro();
			libro.setIdLibro(Integer.parseInt(request.getParameter("libro")));
			ejemplar.setLibro(libro);
			ejemplar.setIdEjemplar(Integer.parseInt(request.getParameter("ejemplar")));
			ejemplar.setCantPaginas(Integer.parseInt(request.getParameter("paginas")));
			ejemplar.setEditorial(request.getParameter("editorial"));
			ejemplar.setNroEdicion(Integer.parseInt(request.getParameter("numeroEdicion")));
			ejemplar.setFechaEdicion(LocalDate.parse(request.getParameter("fechaEdicion")));
			
			//actualizo con los nuevos datos en la BD
			ce.update(ejemplar);
			
			//como vuelvo a la misma pagina, necesito todos los ejemplares y los libros de estos
			LinkedList<Ejemplar> ejemplares = ce.getAll();
			LinkedList<Libro> librosM = new LinkedList<>();
			for (Ejemplar ejem : ejemplares) {
				if (!librosM.contains(ejem.getLibro())){
					librosM.add(ejem.getLibro());
				}
			}
			request.setAttribute("ejemplares", ejemplares);
			request.setAttribute("libros", librosM);
			request.setAttribute("messageType", "success");
		    request.setAttribute("message", "Ejemplar modificado con éxito.");
			request.getRequestDispatcher("modificarEjemplar.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
