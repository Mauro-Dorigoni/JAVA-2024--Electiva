<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Libro> libros = (List<Libro>) request.getAttribute("libros");
    List<Categoria_libro> categorias = (List<Categoria_libro>) request.getAttribute("categorias");
    LinkedList<String> autores = (LinkedList<String>) request.getAttribute("autores");
    String filterBy = (String) request.getAttribute("filterBy");
    String filtro = (String) request.getAttribute("filtro");
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
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
            min-height: 100vh;
		    display: flex;
		    flex-direction: column;
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

        /* New row under header */
        .menu-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #4FA5BF;
        }

        .hamburger-menu {
            font-size: 1.5rem;
            cursor: pointer;
            color: white;
            position: relative;
        }
        .hamburger-menu i {
            font-size: 1.8rem;
            color: white;
            cursor: pointer;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            background-color: #4FA5BF;
            top: 40px;
            left: 0;
            width: 150px;
            z-index: 1;
            border-radius: 5px;
        }

        .dropdown-menu a {
            color: white;
            padding: 10px;
            display: block;
            text-decoration: none;
            font-weight: bold;
        }

        .dropdown-menu a:hover {
            background-color: #3C7D93;
        }

        .hamburger-menu i:hover + .dropdown-menu, .dropdown-menu:hover {
            display: block;
        }

        .search-bar {
            padding: 8px;
            font-size: 0.9rem;
            width: 1200px; /* Tamaño más pequeño de la barra de búsqueda */
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .search-bar input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
        }

        .filter-sort {
            display: flex;
            align-items: center;
            color: white;
        }

        .filter-sort select {
            margin-left: 20px;
            padding: 5px;
        }

        /* Main content area */
        .main-content {
            margin: 20px;
		    margin-bottom: 100px; /* Espacio extra para evitar superposición con el footer */
		    flex: 1; 
        }

        .card-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }

	    .card {
	        background-color: white;
	        border: 1px solid #ccc;
	        border-radius: 10px;
	        padding: 20px;
	        margin-bottom: 20px;
	        width: calc(25% - 20px); /* Ajustado para hacer las cards más angostas (4 por fila) */
	        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	        display: flex;
	        flex-direction: column;
	        align-items: center;
	    }
	    .card form {
	        width: 100%; /* Asegura que el formulario ocupe todo el ancho de la tarjeta */
	    }
		
	    .card img {
	        height: 150px;
	        width: 100px;
	        object-fit: contain;
	        border-radius: 10px;
	        background-color: #f8f9fa;
	        margin-bottom: 10px;
	    }
	
	    .card-content {
	        text-align: center;
	    }
	
	    .card-content h5 {
	        margin: 0;
	        color: #e08b72;
	        font-weight: bold;
	    }
	
	    .card-content p {
	        margin: 5px 0;
	    }
	
	    /* Estilo de los botones */
	    .card button {
	        padding: 10px;
	        border-radius: 5px;
	        font-weight: bold;
	        cursor: pointer;
	        transition: background-color 0.3s ease;
	        margin: 5px 0;
	        width: 100%; /* Asegura que el botón ocupe todo el ancho de la tarjeta */
	        box-sizing: border-box; 
	    }
	
	    /* Estilo del botón Detalle */
	    .card button.detalle {
	        background-color: white;
	        color: #e08b72;
	        border: 2px solid #e08b72;
	    }
	
	    .card button.detalle:hover {
	        background-color: #f8f9fa;
	    }
	
	    /* Estilo del botón Sacar a Préstamo */
	    .card button.prestamo {
	        background-color: #e08b72;
	        color: white;
	        border: none;
	    }
	
	    .card button.prestamo:hover {
	        background-color: #c76a57;
	    }
	
	        .footer {
	             background-color: #e08b72;
				 padding: 20px;
				 text-align: center;
				 width: 100%;
				 position: relative; 
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

    <!-- Menu row -->
    <div class="menu-row">
        <div class="hamburger-menu">
            <i class="fas fa-bars"></i>
            <div class="dropdown-menu">
                <a href="#">Mis préstamos</a>
                <a href="#">Mis pagos</a>
                <a href="#">Mis reseñas</a>
            </div>
        </div>

        <div class="search-bar">
            <input type="text" placeholder="Buscar libros...">
        </div>

        <div class="filter-sort">
            <form id="filterForm" action="<%=request.getContextPath()%>/filterLibros" method="get">
		        <label for="filter">Filtrar por:</label>
		        <select id="filter" name="filterBy" onchange="handleFilterChange()">
		            <option value="all" <%= "all".equals(filterBy) ? "selected" : "" %>>Todos</option>
		            <option value="category" <%= "category".equals(filterBy) ? "selected" : "" %>>Categoría</option>
		            <option value="autor" <%= "autor".equals(filterBy) ? "selected" : "" %>>Autor</option>
		        </select>
		
		        <div id="categoryFilter" style="display: <%= "category".equals(filterBy) ? "block" : "none" %>;">
		            <label for="category">Categoría:</label>
		            <select id="category" name="category">
		                <% for (Categoria_libro categoria : categorias) { %>
		                    <option value="<%= categoria.getNombre_categoria() %>" <%= categoria.getNombre_categoria().equals(filtro) ? "selected" : "" %>><%= categoria.getNombre_categoria() %></option>
		                <% } %>
		            </select>
		        </div>
		
		        <div id="authorFilter" style="display: <%= "autor".equals(filterBy) ? "block" : "none" %>;">
		            <label for="author">Autor:</label>
		            <select id="author" name="author">
		                <% for (String autor : autores) { %>
		                    <option value="<%= autor %>" <%= autor.equals(filtro) ? "selected" : "" %>><%= autor %></option>
		                <% } %>
		            </select>
		        </div>
		
		        <input type="submit" value="Filtrar">
		    </form>

            <form id="sortForm" action="<%=request.getContextPath()%>/orderLibros" method="get">
			    <label for="sort">Ordenar por:</label>
			    <select id="sort" name="sortBy" onchange="document.getElementById('sortForm').submit()">
			        <option value="title">Título</option>
			        <option value="categoria">Categoría</option>
			        <option value="puntaje">Puntaje</option>
			    </select>
			     <%
			        if (libros != null) {
			            for (int i = 0; i < libros.size(); i++) {
			                Libro libro = libros.get(i);
			    %>
			                <input type="hidden" name="libros[<%=i%>].idLibro" value="<%=libro.getIdLibro()%>" />
			    <%
			            }
			        }
			    %>
			</form>
        </div>
    </div>

    <div class="main-content">
        <div class="card-container">
            <% for(Libro libro : libros) { %>
            <div class="card">
                <img src="assets/libros/<%= libro.getIdPhoto() %>.jpg" alt="Imagen de <%= libro.getTitulo() %>">
                <div class="card-content">
                    <h5><%= libro.getTitulo() %></h5>
                    <p>Categoría: <%= libro.getCategoria().getNombre_categoria() %></p>
                </div>
                <form action="<%=request.getContextPath()%>/libroDetail" method="get">
				    <input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
				    <button type="submit" class="detalle">Detalles</button>
				</form>
                <form action="<%=request.getContextPath()%>/prestamoLibro" method="post">
				    <input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
				    <button type="submit" class="prestamo">Sacar a Préstamo</button>
				</form>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var dropdowns = document.getElementsByClassName('hamburger-menu');
            for (var i = 0; i < dropdowns.length; i++) {
                dropdowns[i].addEventListener('click', function () {
                    var dropdownContent = this.querySelector('.dropdown-menu');
                    if (dropdownContent.style.display === 'block') {
                        dropdownContent.style.display = 'none';
                    } else {
                        dropdownContent.style.display = 'block';
                    }
                });
            }
        });
        window.onload = function() {
            var sortBy = "<%= request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "" %>";
            if (sortBy) {
                document.getElementById('sort').value = sortBy;
            }
        }
        function handleFilterChange() {
            var filterBy = document.getElementById('filter').value;
            var categoryFilter = document.getElementById('categoryFilter');
            var authorFilter = document.getElementById('authorFilter');

            if (filterBy === 'category') {
                categoryFilter.style.display = 'block';
                authorFilter.style.display = 'none';
            } else if (filterBy === 'autor') {
                categoryFilter.style.display = 'none';
                authorFilter.style.display = 'block';
            } else {
                categoryFilter.style.display = 'none';
                authorFilter.style.display = 'none';
            }
        }
    </script>
</body>
</html>