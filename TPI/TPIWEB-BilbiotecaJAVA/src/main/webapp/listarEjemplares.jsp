<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.LinkedList" %>
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
    LinkedList<Ejemplar> ejemplares = (LinkedList<Ejemplar>) request.getAttribute("ejemplares");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Listado de Ejemplares</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/listadosAdmin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <div class="header">
        <a href="<%=request.getContextPath()%>/adminDashboard.jsp">
            <img src="assets/logojavabiblioteca.jpg" alt="Logo">
        </a>
       <jsp:include page="userOptions.jsp">
		    <jsp:param name="userEmail" value="<%= userEmail %>" />
		</jsp:include>
    </div>

    <div class="container-fluid">
        
		<jsp:include page="adminSidebar.jsp">
		    <jsp:param name="activeSection" value="ejemplares" />
		</jsp:include> 
		
        <!-- Main Content -->
        <div class="main-content">
            <div class="card-container">
                <% for(Ejemplar ejemplar : ejemplares) { %>
                <div class="card">
                    <div class="card-content">
                        <h5><%= ejemplar.getLibro().getTitulo() %></h5>
                        <p>ID Libro: <%= ejemplar.getLibro().getIdLibro() %> </p>
                        <p>ID Ejemplar: <%= ejemplar.getIdEjemplar() %></p>
                        <p>Editorial: <%= ejemplar.getEditorial() %></p>
                        <p>Nro Edicion: <%= ejemplar.getNroEdicion() %></p>
                        <p>Fecha Edicion: <%= ejemplar.getFechaEdicion() %></p>
                        <p>Nro Paginas: <%= ejemplar.getCantPaginas() %></p>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>