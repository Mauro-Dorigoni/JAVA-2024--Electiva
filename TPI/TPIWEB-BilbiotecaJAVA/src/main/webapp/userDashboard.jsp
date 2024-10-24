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
    
    StringBuilder librosIds = new StringBuilder();
    for (Libro libro : libros) {
        librosIds.append(libro.getIdLibro()).append(",");
    }
    if (librosIds.length() > 0) librosIds.setLength(librosIds.length() - 1);
    
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
            z-index: 1000;
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

        .hamburger-menu:hover .dropdown-menu, .dropdown-menu:hover {
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
        .input-group {
		    display: flex;
		    align-items: center;
		}
		
		.input-group input {
		    flex: 1; /* Ocupa todo el espacio disponible */
		    padding: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    border-top-right-radius: 0; /* Elimina el radio en la esquina superior derecha */
		    border-bottom-right-radius: 0; /* Elimina el radio en la esquina inferior derecha */
		}
		
		.input-group button {
		    background-color: #e08b72; /* Cambia el color según el diseño */
		    border: 1px solid #e08b72;
		    border-radius: 5px;
		    border-top-left-radius: 0; /* Elimina el radio en la esquina superior izquierda */
		    border-bottom-left-radius: 0; /* Elimina el radio en la esquina inferior izquierda */
		    padding: 10px;
		    cursor: pointer;
		}
		
		.input-group button i {
		    color: white; /* Cambia el color del ícono según el diseño */
		    font-size: 1rem;
		}
		.input-group button:hover {
		    background-color: #d07a5a; /* Color al pasar el ratón sobre el botón */
		    border-color: #d07a5a; /* Asegura que el borde también cambie de color */
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
        justify-content: flex-start;
        gap: 20px;
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
        <a href="#" onclick="document.getElementById('logoForm').submit();">
            <img src="assets/logojavabiblioteca.jpg" alt="Logo">
        </a>
        <form id="logoForm" class="hidden-form" action="<%=request.getContextPath()%>/listLibros" method="GET">
            <input type="hidden" name="actionLibro" value="userDashboard">
            <!-- Puedes agregar más campos ocultos aquí si es necesario -->
        </form>
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
                <a href="<%= request.getContextPath() %>/userPrestamos?userEmail=<%= userEmail %>">Mis préstamos</a>
                <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=pagos">Mis pagos</a>
                <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=contra">Cambiar Contraseña</a>
                <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=baja">Baja Cuenta</a>
                <a href="#">Mis reseñas</a>
                
            </div>
        </div>

        <div class="search-bar">
		    <form action="<%=request.getContextPath()%>/searchLibros" method="get">
		        <div class="input-group">
		            <input type="text" name="query" placeholder="Buscar libros..." value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
		            <button type="submit" class="btn btn-primary">
		                <i class="fas fa-search"></i>
		            </button>
		        </div>
		    </form>
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

    <form id="sortForm" action="<%=request.getContextPath()%>/orderLibros" method="post">
        <input type="hidden" id="hiddenFilterBy" name="filterBy" value="<%= filterBy %>" />
        <input type="hidden" id="hiddenCategory" name="category" value="<%= request.getParameter("category") %>" />
        <input type="hidden" id="hiddenAuthor" name="author" value="<%= request.getParameter("author") %>" />
        <input type="hidden" name="librosIds" value="<%= librosIds.toString() %>" />
        <label for="sort">Ordenar por:</label>
        <select id="sort" name="sortBy" onchange="document.getElementById('sortForm').submit()">
            <option value="title">Título</option>
            <option value="categoria">Categoría</option>
            <option value="puntaje">Puntaje</option>
        </select>
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
				    <input type="hidden" name="action" value="user">
				    <button type="submit" class="detalle">Detalles</button>
				</form>
                <form action="<%=request.getContextPath()%>/verifyPrestamo" method="post">
				    <input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
				    <input type="hidden" name="userEmail" value="<%= userEmail %>">
				    <button type="submit" class="prestamo">Sacar a Préstamo</button>
				</form>
            </div>
            <% } %>
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
	            <form id="redirectForm" action="<%=request.getContextPath()%>/listLibros" method="get" style="display: none;">
				    <input type="hidden" name="actionLibro" value="userDashboard">
				</form>
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

    <script>
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
        
        document.addEventListener('DOMContentLoaded', function() {
            // Actualiza los valores ocultos en el formulario de ordenamiento con los valores del formulario de filtrado
            var filterBy = document.getElementById('filter').value;
            var category = document.getElementById('category').value;
            var author = document.getElementById('author').value;

            document.getElementById('hiddenFilterBy').value = filterBy;
            document.getElementById('hiddenCategory').value = category;
            document.getElementById('hiddenAuthor').value = author;

            // Manejo del menú desplegable
            var hamburgerIcon = document.querySelector('.hamburger-menu');
            var dropdownMenu = document.querySelector('.dropdown-menu');

            hamburgerIcon.addEventListener('click', function() {
                // Alterna la visibilidad del menú desplegable
                if (dropdownMenu.style.display === 'block') {
                    dropdownMenu.style.display = 'none';
                } else {
                    dropdownMenu.style.display = 'block';
                }
            });

            // Opcional: Cierra el menú si se hace clic fuera de él
            document.addEventListener('click', function(event) {
                if (!hamburgerIcon.contains(event.target) && !dropdownMenu.contains(event.target)) {
                    dropdownMenu.style.display = 'none';
                }
            });
        });
        
        
    </script>
</body>
</html>