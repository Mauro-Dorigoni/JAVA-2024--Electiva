<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página de Inicio</title>
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

        .main-content {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 100px); /* Adjust height based on header size */
            text-align: center;
        }

        .info-box {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px;
        }

        .info-box h1 {
            color: #e08b72;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <a href="<%=request.getContextPath()%>/index.jsp">
        	<img src="assets/logojavabiblioteca.jpg" alt="Logo">
		</a> <!-- Replace with your logo image path -->
        <div class="nav-links">
            <a href="<%=request.getContextPath()%>/login.jsp">Iniciar Sesión</a>
            <a href="<%=request.getContextPath()%>/register.jsp">Registrarse</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="info-box">
        	<img src="assets/logojavabiblioteca.jpg" alt="Logo">
            <h1>Bienvenido al TPI Lenguaje Programacion JAVA</h1>
            <p>Se trata de un sistema de Biblioteca, donde se pueden registrar prestamos de libros y reseñas de estos.</p>
            <p>Integrantes: Dorigoni Mauro</p>
            <p>Profesores: Meca Adrian, Tabacman Ricardo</p>
        </div>
    </div>
</body>
</html>
