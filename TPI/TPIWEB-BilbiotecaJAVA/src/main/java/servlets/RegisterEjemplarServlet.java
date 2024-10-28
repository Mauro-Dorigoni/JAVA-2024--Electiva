package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.*;
import logic.*;
import java.util.LinkedList;
import java.time.*;


@WebServlet("/registerEjemplar")
public class RegisterEjemplarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RegisterEjemplarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_libro cl = new CRUD_libro();
		Libro libro = new Libro();
		libro.setIdLibro(Integer.parseInt(request.getParameter("libro")));
		Ejemplar ejemplar = new Ejemplar();
		ejemplar.setEditorial(request.getParameter("editorial"));
		ejemplar.setFechaEdicion(LocalDate.parse(request.getParameter("fechaEdicion")));
		ejemplar.setNroEdicion(Integer.parseInt(request.getParameter("numeroEdicion")));
		ejemplar.setCantPaginas(Integer.parseInt(request.getParameter("paginas")));
		ejemplar.setLibro(libro);
		CRUD_ejemplar ce = new CRUD_ejemplar();
		try {
			ce.save(ejemplar);
			LinkedList<Libro> libros = cl.getAll();
			request.setAttribute("libros", libros);
			request.setAttribute("messageType", "success");
            request.setAttribute("message", "Ejemplar registrado con éxito. FechaEdicion="+ejemplar.getFechaEdicion()+"IDLIBRO="+ejemplar.getLibro().getIdLibro()+"editorial="+ejemplar.getEditorial()+"NumeroEdicion="+ejemplar.getNroEdicion()+"paginas="+ejemplar.getCantPaginas());
            request.getRequestDispatcher("altaEjemplar.jsp").forward(request, response);
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
