<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entidades.Categoria_libro" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
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
    <title>Detalle Categoria</title>
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
	    .detail-container {
            display: flex;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            align-items: flex-start; /* Align items to the top */
        }

        .detail-container img {
            width: 60%; /* Imagen ligeramente más pequeña */
            max-width: 500px;
            height: auto;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 20px; /* Espacio entre imagen y contenido */
        }

        .detail-content {
            display: flex;
            flex-direction: column;
            justify-content: center; /* Centro verticalmente el contenido */
            flex-grow: 1;
        }

        .detail-content h5 {
            margin: 0;
            color: #e08b72;
            font-size: 3rem; /* Nombre en grande */
            font-weight: bold;
        }

        .detail-content p {
            margin: 5px 0;
            color: #6c757d;
             /* ID en gris */
            font-size: 20px;
        }

        .detail-content .description {
            margin-top: 20px;
            text-align: center; /* Centramos el texto de la descripción */
            color: black;
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
	        .menu-title {
			    flex: 1;
			    text-align: center;
			    color: white;
			    font-size: 1.5rem;
			    font-weight: bold;
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
                <a href="<%= request.getContextPath() %>/listClienteReviews?userEmail=<%= userEmail %>">Mis reseñas</a>
            </div>
        </div>
        <div class="menu-title">
		        Detalle Categoria
		 </div>
    </div>

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


<script>
        $(document).ready(function() {
            var messageType = '<%= request.getAttribute("messageType") != null ? request.getAttribute("messageType") : "" %>';
            if (messageType) {
                $('#messageModal').modal('show');
            }

            $('#modalCloseButton, #modalFooterCloseButton').click(function() {
                $('#messageModal').modal('hide');
                window.location.href = '<%=request.getContextPath()%>/adminDashboard.jsp';
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
        });
        
        function toggleResenias() {
            var content = document.getElementById("resenias-content");
            var arrow = document.getElementById("arrow");

            if (content.style.display === "none") {
                content.style.display = "block";
                arrow.innerHTML = "&#9650;";  // Cambia la flecha hacia arriba
            } else {
                content.style.display = "none";
                arrow.innerHTML = "&#9660;";  // Cambia la flecha hacia abajo
            }
        }
    </script>
</body>
</html>