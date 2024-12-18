<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.*" %>
<%@ page import="java.util.LinkedList" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Review review = (Review) request.getAttribute("review");

    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle Reseña</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaUser.css">
    <link rel="stylesheet" href="assets/CSS/detailUser.css">
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
		        Detalle Reseña
		 </div>
    </div>
<% if (review.getFechaReview() == null) { %>
    <p>Pasaron cosas</p>
<% } else { %>
    <div class="main-content">
        <div class="detail-container">
            <div class="detail-content">
                <h5>Reseña de Libro: <%= review.getPrestamo().getEjemplar().getLibro().getTitulo() %></h5>
                <div class="info-row">
                    <p>ID: <%= review.getIdReview() %></p>
                    <p>Puntaje: <%= review.getPuntaje() + "/5" %></p>
                    <p>Estado: <%= review.getEstado_review() %></p>
                    <p>Fecha: <%= review.getFechaReview() %></p>

                    <% if (review.getEstado_review() != EstadoReviewEnum.PENDIENTE_REVISION) { %>
                        <% if (review.getAdministrativo() != null) { %>
                            <p>ID Admin Moderador: <%= review.getAdministrativo().getId() %></p>
                        <% } else { %>
                            <p>ID Admin Moderador: No asignado</p>
                        <% } %>
                        
                        <% if (review.getEstado_review() == EstadoReviewEnum.RECHAZADA) { %>
                            <% if (review.getObservacion_rechazo() != null) { %>
                                <p>Motivo Rechazo: <%= review.getObservacion_rechazo() %></p>
                            <% } else { %>
                                <p>Motivo Rechazo: No proporcionado</p>
                            <% } %>
                        <% } %>
                    <% } %>
                    
                    <p>Reseña: <%= review.getDescripcion() %></p>
                </div>
            </div>
        </div>
    </div>
<% } %>

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