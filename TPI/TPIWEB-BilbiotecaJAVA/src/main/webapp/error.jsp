<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entidades.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%	
	AppException error = (AppException) request.getAttribute("error");
%>   
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/errorPage.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
</head>
<body>
    <!-- Header -->
    <div class="header">
        <a href="<%=request.getContextPath()%>/index.jsp">
            <img src="assets/logojavabiblioteca.jpg" alt="Logo">
        </a>
        <div class="nav-links">
            <a href="<%=request.getContextPath()%>/login.jsp">Iniciar Sesión</a>
            <a href="<%=request.getContextPath()%>/register.jsp">Registrarse</a>
        </div>
    </div>

    <!-- Error Message -->
    <div class="error-box">
        <h2>we hebben een serieus probleem :(</h2>
        <p><%= error.getMessage() %></p>
        <a href="javascript:history.back()" class="btn-back">Volver Atrás</a>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>