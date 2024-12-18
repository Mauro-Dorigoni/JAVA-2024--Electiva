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

    Libro libro = (Libro) request.getAttribute("libro");
    LinkedList<Ejemplar> ejemplares = (LinkedList<Ejemplar>) request.getAttribute("ejemplares");
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout Prestamo</title>
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
		        Checkout Prestamo
		</div>
    </div>

    <div class="main-content">
	  	 <div class="detail-container">
        <!-- User and Book details -->
        <div class="detail-content">
            <h5>Detalles Prestamo</h5>
            <p>Usuario: <%= userEmail %></p>
            <p>Libro: <%= libro.getTitulo() %></p>
            <p>Fecha máxima de devolución: <%= java.time.LocalDate.now().plusDays(60) %></p>

            <!-- Form to select the ejemplar and confirm loan -->
            <form action="<%= request.getContextPath() %>/registerPrestamo" method="post">
                <input type="hidden" name="userEmail" value="<%= userEmail %>">
            <!-- Campo oculto para enviar el ID del libro -->
            	<input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
                <div class="form-group">
                    <label for="ejemplarSelect"><p>Seleccionar ejemplar:</p></label>
                    <select class="form-control" id="ejemplarSelect" name="idEjemplar" required>
                        <option value="" disabled selected>Seleccione un ejemplar</option>
                        <% for (Ejemplar ej : ejemplares) { %>
                            <option value="<%= ej.getIdEjemplar() %>">
                                ID: <%= ej.getIdEjemplar() %> - Editorial: <%= ej.getEditorial() %> - 
                                Páginas: <%= ej.getCantPaginas() %> - Edición: <%= ej.getNroEdicion() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <!-- Buttons -->
                <button type="submit" class="btn btn-custom btn-block btn-md" style="font-weight:bold">Confirmar Préstamo</button>
                <button type="button" class="btn btn-block btn-md" style="background-color: grey; color: white; font-weight:bold" onclick="window.history.back();">Atrás</button>
            </form>
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
                <button type="button" class="close" id="modalCloseButton" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
            </div>
            <div class="modal-footer">
                <form id="redirectToInicioForm" action="<%=request.getContextPath()%>/listLibros" method="get" style="display: inline;">
                    <input type="hidden" name="actionLibro" value="userDashboard">
                </form>
                <form id="redirectToPrestamosForm" action="<%=request.getContextPath()%>/userPrestamos" method="get" style="display: inline;">
                    <input type="hidden" name="userEmail" value="<%= userEmail %>">
                </form>
                <button type="button" class="btn btn-primary" id="modalInicioButton">Inicio</button>
                <button type="button" class="btn btn-secondary" id="modalPrestamosButton">Mis Préstamos</button>
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
        });

        $('#modalInicioButton').click(function() {
            $('#redirectToInicioForm').submit();
        });

        $('#modalPrestamosButton').click(function() {
            $('#redirectToPrestamosForm').submit();
        });
    });
</script>
    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>

    <script>
 	
    </script>
</body>
</html>