<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.*" %>
<%@ page import="java.util.LinkedList" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Libro libro = (Libro) request.getAttribute("libro");
	LinkedList<Review> reviews = libro.getReviews();
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle Libro</title>
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
	        .categoria-link:hover {
		        text-decoration: underline;
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
         <jsp:include page="hamburguerMenu.jsp">
		    <jsp:param name="userEmail" value="<%= userEmail %>" />
		</jsp:include>
        <div class="menu-title">
		        Detalle Libro
		 </div>
    </div>

    <div class="main-content">
	  <div class="detail-container">
	     <img src="assets/libros/<%= libro.getIdPhoto() %>.jpg" alt="Imagen de <%= libro.getTitulo() %>">
	       <div class="detail-content">
	       		<h5><%= libro.getTitulo() %></h5>
	       <div class="info-row">
	           <p>Autor: <%= libro.getAutor() %></p>
	           <p>ISBN: <%= libro.getISBN() %></p>
	           <p>Puntaje: <%= libro.getPuntaje() %></p>
	       </div>
	       <div class="info-row">
	           <p>ID: <%= libro.getIdLibro() %></p>
	           <p>
		           <form id="categoriaForm" action="categoriaDetail" method="GET" style="display:inline;">
	                    <input type="hidden" name="idCategoria" value="<%= libro.getCategoria().getIdCategoria() %>">
	                    <input type="hidden" name="action" value="user">
	                    <a href="#" onclick="document.getElementById('categoriaForm').submit();" 
	                       style="text-decoration: none; color: #6c757d;font-size: 20px" class="categoria-link">
	                        Categoría: <%= libro.getCategoria().getNombre_categoria() %>
	                    </a>
	                </form>	 
	       </div>
	       <div class="description" style="text-align:left">
	           <p><%= libro.getSumario() %></p>
	       </div>
	   </div>
	  </div>
	  <div style="margin-top: 20px;">
			<form id="validateLoanForm"action="<%=request.getContextPath()%>/verifyPrestamo" method="POST">
				<input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
				<input type="hidden" name="userEmail" value="<%= userEmail %>">
				<input class="btn btn-custom btn-block btn-md" type="submit" value="SACAR A PRESTAMO" style="font-weight: bold; height: 50px;"/>
			</form>
		</div>
	  	<div class="resenias-section" style="margin-top: 20px; background-color: #fff; border-radius: 10px; padding: 20px; border: 1px solid #ddd;">
		    <h5 style="color: #e08b72; font-size: 3rem; display: flex; justify-content: space-between; align-items: center;font-weight: bold">
		        Reseñas
		        <span id="arrow" style="cursor: pointer;" onclick="toggleResenias()">&#9660;</span>
		    </h5>
		    <div id="resenias-content" style="display:none;">
		        <%
		            if (reviews == null || reviews.isEmpty()) {
		        %>
		            <p>No hay reseñas aún</p>
		        <%
		            } else {
		                for (Review review : reviews) {
		        %>
		            <div class="detail-container">
				       <div class="detail-content">
				       <div class="info-row">
				           <p><strong style="color:#e08b72"><%=review.getPrestamo().getCliente().getNombre()+" "+ review.getPrestamo().getCliente().getApellido()+": "%></strong><%=review.getPuntaje()+"/5" %></p>
				           <p><%= review.getDescripcion() %></p>
				       </div>
				   </div>
				  </div>
		        <%
		                }
		            }
		        %>
		    </div>
		</div>
		<script>
		    function toggleResenias() {
		        var reseniasContent = document.getElementById('resenias-content');
		        var arrow = document.getElementById('arrow');
		        
		        if (reseniasContent.style.display === "none" || reseniasContent.style.display === "") {
		            reseniasContent.style.display = "block";
		            arrow.innerHTML = "&#9650;"; // Cambiar la flecha hacia arriba
		        } else {
		            reseniasContent.style.display = "none";
		            arrow.innerHTML = "&#9660;"; // Cambiar la flecha hacia abajo
		        }
		    }
		</script>
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
</body>
</html>