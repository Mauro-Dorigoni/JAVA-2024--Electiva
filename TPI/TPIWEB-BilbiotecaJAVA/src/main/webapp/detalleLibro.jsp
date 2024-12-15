<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entidades.*" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
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
    <title>Admin Dashboard - Detalle de Libro</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/vistaAdmin.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        .detail-container {
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: left;
            display: flex;
		    flex-direction: row;
		    align-items: flex-start;
		    margin-bottom: 40px; /* Separación con las reseñas */
		    clear: both;
        }

        .detail-container img {
            width: 30%; /* Imagen ligeramente más pequeña */
            max-width: 300px;
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
            font-size: 2rem; /* Nombre en grande */
            font-weight: bold;
        }

        .detail-content p {
            margin: 5px 0;
            color: #6c757d; /* ID en gris */
        }

        .detail-content .description {
            margin-top: 20px;
            text-align: center; /* Centramos el texto de la descripción */
            color: black;
        }

        .detail-content h5 {
		    margin: 0;
		    color: #e08b72;
		    font-size: 2.5rem; /* Tamaño aumentado para el nombre de la categoría */
		    font-weight: bold;
		}

		.detail-content p {
		    margin: 5px 0;
		    color: #6c757d; /* ID en gris */
		    font-size: 1.2rem; /* Tamaño aumentado para el ID */
		}

		.detail-content .description p {
		    margin: 10px 0;
		    font-size: 1.5rem; /* Tamaño aumentado para la descripción */
		}
		.detail-content {
		    display: flex;
		    flex-direction: column;
		}
		
		.resenias-section{
			width: 100%; /* Asegura que ocupe todo el ancho */
		    display: block;
		    margin-top: 20px;
		    background-color: #fff;
		    border-radius: 10px;
		    padding: 20px;
		    border: 1px solid #ddd;
		}
		.info-row {
		    display: flex;
		    justify-content: space-between;
		    margin-bottom: 5px; /* Espacio entre las filas */
		}
		
		.info-row p {
		    margin: 0; /* Elimina los márgenes por defecto de los párrafos */
		    padding: 0;
		    flex: 1; /* Elimina los rellenos por defecto de los párrafos */
		}
		.info-row p:first-child {
		    margin-right: 10	px; /* Espacio entre los elementos en la misma fila */
		}
    </style>
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
		    <jsp:param name="activeSection" value="libros" />
		</jsp:include> 

        <!-- Main Content -->
        <div class="main-content">
            <div class="detail-container">
                <img src="assets/libros/<%= libro.getIdPhoto() %>.jpg" alt="Imagen de <%= libro.getTitulo() %>">
                <div class="detail-content">
		            <h5><%= libro.getTitulo() %></h5>
		            <div class="info-row">
		                <p>Autor: <%= libro.getAutor() %></p>
		                <p>ISBN: <%= libro.getISBN() %></p>
		            </div>
		            <div class="info-row">
		                <p>ID: <%= libro.getIdLibro() %></p>
		                <p>Categoría: <%= libro.getCategoria().getNombre_categoria() %></p>
		            </div>
		            <div class="description" style="text-align:left">
		                <p><%= libro.getSumario() %></p>
		            </div>

		            <div class="resenias-section">
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
</div>

    <!-- Footer -->
    <div class="footer" style="position:fixed">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>