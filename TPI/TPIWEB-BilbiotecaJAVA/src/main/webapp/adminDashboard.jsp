<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.Cliente" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/infoBox.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaAdmin.css">
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

    <!-- Container with Sidebar and Main Content -->
    <div class="container-fluid">
        <!-- Sidebar -->
        
		<jsp:include page="adminSidebar.jsp">
		    <jsp:param name="activeSection" value="" />
		</jsp:include>
        <!-- Main Content -->
        <div class="main-content">
            <div class="info-box">
                <img src="assets/logojavabiblioteca.jpg" alt="Logo">
                <h1>Bienvenido al TPI Lenguaje Programacion JAVA</h1>
                <p>Se trata de un sistema de Biblioteca, donde se pueden registrar préstamos de libros y reseñas de estos.</p>
                <p>Integrantes: Dorigoni Mauro</p>
                <p>Profesores: Meca Adrian, Tabacman Ricardo</p>
            </div>
        </div>
    </div>
    <div class="footer" style="position:fixed">
	    <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
	</div>
</body>
</html>
