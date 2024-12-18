<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.*" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.*" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    LinkedList<Prestamo> prestamos = (LinkedList<Prestamo>) request.getAttribute("prestamos");
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis prestamos</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaUser.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

</head>
<body>
    <!-- Header -->
    <div class="header">
        <a href="#" onclick="document.getElementById('logoForm').submit();">
            <img src="assets/logojavabiblioteca.jpg" alt="Logo">
        </a>
        <form id="logoForm" class="hidden-form" action="<%=request.getContextPath()%>/listLibros" method="GET">
            <input type="hidden" name="actionLibro" value="userDashboard">
            <!-- Puedes agregar más campos ocultos aquí si es necesario -->
        </form>
        <jsp:include page="userOptions.jsp">
		    <jsp:param name="userEmail" value="<%= userEmail %>" />
		</jsp:include>
    </div>

    <!-- Menu row -->
    <div class="menu-row">
        <jsp:include page="hamburguerMenu.jsp">
		    <jsp:param name="userEmail" value="<%= userEmail %>" />
		</jsp:include>
        <div class="menu-title">
	        Mis préstamos
	    </div>
    </div>

<div class="main-content">
    <% if (prestamos != null && !prestamos.isEmpty()) { %>
        <div class="card-container">
            <% for (Prestamo prestamo : prestamos) { %>
                <div class="card horizontal-card">
                    <div class="card-image">
                        <img src="assets/libros/<%= prestamo.getEjemplar().getLibro().getIdPhoto() %>.jpg" alt="Imagen del libro">
                    </div>
                    <div class="card-content">
                        <h5><%= prestamo.getEjemplar().getLibro().getTitulo() %></h5>
                        <p>ID del ejemplar: <%= prestamo.getEjemplar().getIdEjemplar() %></p>
                        <p>Fecha de realización: <%= prestamo.getFechaRealizacion().toString() %></p>
                        <p>Estado actual: <%= prestamo.getEstado().name() %></p>
						<%if (prestamo.getEstado()==EstadoPrestamo.DEVUELTO){ %>
	                        <% if (prestamo.getReview().getFechaReview() == null) { %>
	                            <!-- Botón para dejar reseña -->
	                            <form action="<%=request.getContextPath()%>/newReview" method="post">
	                                <input type="hidden" name="fechaPrestamo" value="<%= prestamo.getFechaRealizacion() %>">
	                                <input type="hidden" name="idEjemplar" value="<%= prestamo.getEjemplar().getIdEjemplar() %>">
	                                <input type="hidden" name="idCliente" value="<%= prestamo.getCliente().getId() %>">
	                                <input type="hidden" name="idLibro" value="<%= prestamo.getEjemplar().getLibro().getIdLibro() %>">
	                               <button type="submit" class="prestamo">Dejar una Reseña</button>
	                            </form>
	                        <% } else { %>
	                            <!-- Botón para ver reseña -->
	                            <form action="<%=request.getContextPath()%>/listPrestamoReview" method="get">
	                                <input type="hidden" name="fechaPrestamo" value="<%= prestamo.getFechaRealizacion() %>">
	                                <input type="hidden" name="idEjemplar" value="<%= prestamo.getEjemplar().getIdEjemplar() %>">
	                                <input type="hidden" name="idCliente" value="<%= prestamo.getCliente().getId() %>">
	                                <input type="hidden" name="idLibro" value="<%= prestamo.getEjemplar().getLibro().getIdLibro() %>">
	                                <button type="submit" class="detalle">Detalle Reseña</button>
	                            </form>
	                        <% } %>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <p>No tienes préstamos registrados. ¡Qué esperas, a leer!</p>
    <% } %>
</div>
  	
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLabel">
                    <%= request.getAttribute("messageType") != null && request.getAttribute("messageType").equals("success") ? "Éxito" : "Error" %>
                </h5>
                <button type="button" class="close" id="modalCloseButton" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
            </div>
            <div class="modal-footer">
	            <form id="redirectForm" action="<%=request.getContextPath()%>/listLibros" method="get" style="display: none;">
				    <input type="hidden" name="actionLibro" value="userDashboard">
				</form>
                <button type="button" class="btn btn-secondary" id="modalFooterCloseButton">Cerrar</button>
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

        $('#modalCloseButton, #modalFooterCloseButton').click(function() {
            $('#messageModal').modal('hide');
            // Enviar el formulario oculto para redirigir
            $('#redirectForm').submit();
        });
    });
</script>
    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>