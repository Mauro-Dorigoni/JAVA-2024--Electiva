package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.*;
import entidades.*;
import logic.*;
import java.util.LinkedList;

@WebServlet("/registerPago")
public class RegisterPagoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public RegisterPagoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CRUD_Cliente cc = new CRUD_Cliente();
		Cliente cliente = new Cliente();
		cliente.setId(Integer.parseInt(request.getParameter("idCliente")));
		cliente.setFechaUltimoPago(LocalDate.parse(request.getParameter("fechaPago")));
		try {
			cc.updatePago(cliente);
			LinkedList<Cliente> clientes = cc.getAll();
			request.setAttribute("clientes", clientes);
			request.setAttribute("messageType", "success");
            request.setAttribute("message", "Pago registrado con exito");
            request.getRequestDispatcher("registroPago.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
