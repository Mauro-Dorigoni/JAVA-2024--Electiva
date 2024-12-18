<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entidades.Categoria_libro" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }
    Categoria_libro categoria = (Categoria_libro) request.getAttribute("categoria");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Detalle de Categoría</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaAdmin.css">
    <link rel="stylesheet" href="assets/CSS/detallePage.css">
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
		    <jsp:param name="activeSection" value="categorias" />
		</jsp:include> 
		
        <!-- Main Content -->
        <div class="main-content">
            <div class="detail-container">
                <img src="assets/categorias/<%= categoria.getIdPhoto() %>" alt="Imagen de <%= categoria.getIdPhoto() %>">
                <div class="detail-content">
                    <h5><%= categoria.getNombre_categoria() %></h5>
                    <p>ID: <%= categoria.getIdCategoria() %></p>
                    <div class="description" style="text-align:left">
                        <p><%= categoria.getDescripcion_apliada() %></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer" style="position:fixed">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>
