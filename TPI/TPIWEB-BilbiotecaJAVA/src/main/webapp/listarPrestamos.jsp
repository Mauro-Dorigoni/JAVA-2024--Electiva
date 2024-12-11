<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Recuperar la lista de categorías desde el request
    List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("prestamos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Listado de Prestamos</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #e08b72;
            height: 100px;
        }

        .header img {
            height: 50px;
        }

        .nav-links {
            margin-left: auto;
            display: flex;
            align-items: center;
        }

        .nav-links a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-weight: bold;
        }

        .nav-links .user-icon {
            display: flex;
            align-items: center;
        }

        .nav-links .welcome-message {
            color: white;
            font-weight: bold;
        }

        .nav-links i {
            margin-left: 8px;
            font-size: 1.5rem;
        }

        .container-fluid {
            display: flex;
            height: calc(100vh - 100px); /* Full height minus header */
            padding: 0;
            margin: 0;
        }

        .main-content {
            margin-left: 250px;
            flex-grow: 1;
            padding: 20px;
        }

        .card-container {
            display: flex;
            flex-direction: column;
        }

        .card {
            display: flex;
            flex-direction: row;
            align-items: center;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card img {
            height: 100px;
            width: 100px;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 20px;
        }

        .card-content {
            flex-grow: 1;
        }

        .card-content h5 {
            margin: 0;
            color: #e08b72;
            font-weight: bold;
        }

        .card-content p {
            margin: 5px 0;
        }

        .card button {
            background-color: #e08b72;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .card button:hover {
            background-color: #c76a57;
        }

        .footer {
            background-color: #e08b72;
            padding: 20px;
            text-align: center;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

        .footer p {
            color: white;
            font-weight: bold;
            margin: 0;
        }
        .card img {
		    height: 100px;
		    width: 100px;
		    object-fit: contain;
		    border-radius: 10px;
		    margin-right: 20px;
		    background-color: #f8f9fa; /* Fondo blanco o color que prefieras */
		}
		.main-content select {
            border-color: #e08b72;
            border: 2px solid #e08b72;
            border-radius: 4px;
            margin-left: 20px;
            padding: 5px;
        }
        .main-content select:focus {
		    outline: none; /* Elimina el borde predeterminado del navegador */
		    border-color: #e08b72; /* Mantiene el color del borde al estar seleccionado */
		    box-shadow: 0 0 0 2px rgba(224, 139, 114, 0.5); /* Opción para añadir un efecto de sombra suave */
		}
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <a href="<%=request.getContextPath()%>/adminDashboard.jsp">
            <img src="assets/logojavabiblioteca.jpg" alt="Logo">
        </a>
        <div class="nav-links">
            <div class="user-icon">
                <span class="welcome-message">Bienvenido <%= userEmail %></span>
                <a href="#"><i class="fas fa-user"></i></a>
            </div>
        </div>
    </div>

    <div class="container-fluid">
	
	<jsp:include page="adminSidebar.jsp">
		    <jsp:param name="activeSection" value="prestamos" />
		</jsp:include> 
	
        <!-- Main Content -->
	<div class="main-content">
    <!-- Formulario para filtrar préstamos por estado -->
    <form class="filter-form" action="<%=request.getContextPath()%>/filterPrestamos" method="GET">
        <label for="estadoFilter">Filtrar por estado:</label>
        <select name="estadoFilter" onchange="this.form.submit()">
            <option value="">Todos</option>
            <option value="<%=EstadoPrestamo.PENDIENTE_RETIRO %>" <%= request.getParameter("estadoFilter") != null && request.getParameter("estadoFilter").equals("Pendiente Retiro") ? "selected" : "" %>>Pendiente Retiro</option>
            <option value="<%=EstadoPrestamo.PENDIENTE_DEVOLUCION %>" <%= request.getParameter("estadoFilter") != null && request.getParameter("estadoFilter").equals("Pendiente Devolucion") ? "selected" : "" %>>Pendiente Devolucion</option>
            <option value="<%=EstadoPrestamo.VENCIDO %>" <%= request.getParameter("estadoFilter") != null && request.getParameter("estadoFilter").equals("Vencido") ? "selected" : "" %>>Vencido</option>
            <option value="<%=EstadoPrestamo.DEVUELTO %>" <%= request.getParameter("estadoFilter") != null && request.getParameter("estadoFilter").equals("Devuelto") ? "selected" : "" %>>Devuelto</option>
        </select>
    </form>

    <!-- Mostrar los préstamos -->
    <div class="card-container">
        <% 
        String estadoFilter = request.getParameter("estadoFilter");
        if (prestamos != null && !prestamos.isEmpty()) {
            for (Prestamo prestamo : prestamos) {
                if (estadoFilter == null || estadoFilter.isEmpty() || prestamo.getEstado().name().equals(estadoFilter)) {
        %>
        <div class="card">
            <div class="card-content">
                <p>Cliente: <%= prestamo.getCliente().getMail() %> (ID: <%= prestamo.getCliente().getId() %>)</p>
                <p>Libro: <%= prestamo.getEjemplar().getLibro().getTitulo() %> (ID: <%= prestamo.getEjemplar().getLibro().getIdLibro() %>)</p>
                <p>Ejemplar ID: <%= prestamo.getEjemplar().getIdEjemplar() %></p>
                <p>Fecha del Préstamo: <%= prestamo.getFechaRealizacion() %></p>
                <p>Estado: <%= prestamo.getEstado().name() %></p>
            </div>
            <form action="<%=request.getContextPath()%>/changeEstadoPrestamo" method="GET">
                <input type="hidden" name="idCliente" value="<%= prestamo.getCliente().getId() %>">
                <input type="hidden" name="idLibro" value="<%= prestamo.getEjemplar().getLibro().getIdLibro() %>">
                <input type="hidden" name="idEjemplar" value="<%= prestamo.getEjemplar().getIdEjemplar() %>">
                <input type="hidden" name="fechaPrestamo" value="<%= prestamo.getFechaRealizacion() %>">
                <label for="estado">Cambiar estado:</label>
                <select name="estado" onchange="this.form.submit()">
                    <option value="PENDIENTE_RETIRO" <%= prestamo.getEstado().equals(EstadoPrestamo.PENDIENTE_RETIRO) ? "selected" : "" %>>Pendiente Retiro</option>
                    <option value="PENDIENTE_DEVOLUCION" <%= prestamo.getEstado().equals(EstadoPrestamo.PENDIENTE_DEVOLUCION) ? "selected" : "" %>>Pendiente Devolucion</option>
                    <option value="VENCIDO" <%= prestamo.getEstado().equals(EstadoPrestamo.VENCIDO) ? "selected" : "" %>>Vencido</option>
                    <option value="DEVUELTO" <%= prestamo.getEstado().equals(EstadoPrestamo.DEVUELTO) ? "selected" : "" %>>Devuelto</option>
                </select>
            </form>
        </div>
        <% 
                }
            }
        } else {
        %>
        <p>No hay préstamos registrados.</p>
        <% } %>
    </div>
</div>
    </div>
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLabel">
                    <%= request.getAttribute("messageType") != null && request.getAttribute("messageType").equals("success") ? "Éxito" : "Error" %>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        var messageType = '<%= request.getAttribute("messageType") != null ? request.getAttribute("messageType") : "" %>';
        if (messageType) {
            $('#messageModal').modal('show');
        }
    });
</script>
    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>