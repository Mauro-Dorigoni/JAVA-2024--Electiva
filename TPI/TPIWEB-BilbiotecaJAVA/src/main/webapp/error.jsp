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
    <style>
        body {
            background-color: #f8f9fa;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #e08b72;
        }

        .header img {
            height: 50px;
        }

        .nav-links {
            margin-left: auto;
        }

        .nav-links a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-weight: bold;
        }

        .nav-links a:hover {
            text-decoration: underline;
        }

        .error-box {
            position: absolute;
            top: 100px; /* Just below the header */
            left: 20px;
            background-color: #f8d7da;
            color: #721c24;
            border: 2px solid #f5c6cb;
            padding: 40px;
            border-radius: 10px;
            width: 80%; /* Larger width to make the message bigger */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            font-size: 1.5rem; /* Larger font size */
        }

        .error-box h2 {
            font-size: 2.5rem; /* Increase size of the title */
            margin-bottom: 20px;
        }

        .error-box p {
            margin-bottom: 30px;
        }

        .btn-back {
            display: inline-block;
            background-color: #e08b72;
            color: white;
            padding: 15px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 1.25rem; /* Larger font for the button */
        }

        .btn-back:hover {
            background-color: #d06455;
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
    </style>
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