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
    List<Libro> libros = (List<Libro>) request.getAttribute("libros");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Listado de Libros</title>
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

        .sidebar {
            width: 250px;
            background-color: #4FA5BF;
            padding-top: 20px;
            display: flex;
            flex-direction: column;
            height: calc(100vh - 100px); /* Height minus header */
            position: fixed;
            top: 100px; /* Start sidebar just below the header */
            left: 0;
            bottom: 0;
        }

        .sidebar a {
            color: white;
            padding: 20px;
            font-size: 1.25rem;
            text-decoration: none;
            display: block;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #3C7D93; /* Darker shade of #4FA5BF */
            text-decoration: underline; /* Subrayado al hacer hover */
        }
        .sidebar .active {
	        background-color: #3C7D93;
	        text-decoration: underline;
	    }

        .dropdown-container {
            display: none;
            background-color: #3C7D93; /* Slightly darker for dropdown */
            padding-left: 20px;
        }

        .dropdown-container a {
            padding: 10px 20px;
            font-size: 1rem;
        }

        .dropdown-container a:hover {
            text-decoration: underline; /* Subrayado al hacer hover en los subitems */
        }

        .sidebar .dropdown-btn {
            cursor: pointer;
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
        <div class="sidebar">
			<a href="#" class="dropdown-btn active">Categorías</a>
            <div class="dropdown-container">
               	<form id="listadoCategoriasForm" action="<%=request.getContextPath()%>/listCategorias" method="get" style="display: none;">
					<input type="hidden" id="action" name="action" value="">
				</form>
                <a href="#" onclick="setActionAndSubmit('listado'); return false;">Listado</a>
			    <a href="<%=request.getContextPath()%>/altaCategoria.jsp">Nueva Categoria</a>
			    <a href="#" onclick="setActionAndSubmit('modificar'); return false;">Modificar Categoria</a>
			    <a href="#" onclick="setActionAndSubmit('baja'); return false;">Baja Categoria</a>
            </div>
      		<script>
			    function setActionAndSubmit(actionValue) {
			        document.getElementById('action').value = actionValue;
			        document.getElementById('listadoCategoriasForm').submit();
			    }
			</script>
            <a href="#" class="dropdown-btn">Libros</a>
            <div class="dropdown-container">
                <a href="#">Listado</a>
                <a href="#">Nuevo Libro</a>
                <a href="#">Modificar Libro</a>
                <a href="#">Baja Libro</a>
            </div>
            <a href="#" class="dropdown-btn">Ejemplares</a>
            <div class="dropdown-container">
                <a href="#">Listado</a>
                <a href="#">Nueva Ejemplar</a>
                <a href="#">Modificar Ejemplar</a>
                <a href="#">Baja Ejemplar</a>
            </div>
            <a href="#" class="dropdown-btn">Pagos</a>
            <div class="dropdown-container">
                <a href="#">Registrar pago</a>
            </div>
            <a href="#" class="dropdown-btn">Reseñas</a>
            <div class="dropdown-container">
                <a href="#">Moderacion</a>
            </div>
            <div class="dropdown-container">
                <a href="#">Listado</a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="card-container">
                <% for(Libro libro : libros) { %>
                <div class="card">
                    <img src="assets/libros/<%= libro.getIdPhoto() %>.jpg" alt="Imagen de <%= libro.getTitulo() %>">
                    <div class="card-content">
                        <h5><%= libro.getTitulo() %></h5>
                        <p>ID: <%= libro.getIdLibro() %> </p>
                        <p>Categoria: <%= libro.getCategoria().getNombre_categoria() %></p>
                    </div>
                    <form action="<%=request.getContextPath()%>/libroDetail" method="get">
                        <input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
                        <button type="submit">Detalles</button>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var dropdowns = document.getElementsByClassName('dropdown-btn');
            for (var i = 0; i < dropdowns.length; i++) {
                dropdowns[i].addEventListener('click', function () {
                    this.classList.toggle('active');
                    var dropdownContent = this.nextElementSibling;
                    if (dropdownContent.style.display === 'block') {
                        dropdownContent.style.display = 'none';
                    } else {
                        dropdownContent.style.display = 'block';
                    }
                });
            }
        });
    </script>
</body>
</html>