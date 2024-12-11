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

        .main-content {
            margin-left: 250px;
            flex-grow: 1;
            padding: 20px;
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
            width: 30%; /* Imagen ligeramente m�s peque�a */
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
            text-align: center; /* Centramos el texto de la descripci�n */
            color: black;
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
        .detail-content h5 {
		    margin: 0;
		    color: #e08b72;
		    font-size: 2.5rem; /* Tama�o aumentado para el nombre de la categor�a */
		    font-weight: bold;
		}

		.detail-content p {
		    margin: 5px 0;
		    color: #6c757d; /* ID en gris */
		    font-size: 1.2rem; /* Tama�o aumentado para el ID */
		}

		.detail-content .description p {
		    margin: 10px 0;
		    font-size: 1.5rem; /* Tama�o aumentado para la descripci�n */
		}
		.detail-content {
		    display: flex;
		    flex-direction: column;
		}
		
		.info-row {
		    display: flex;
		    justify-content: space-between;
		    margin-bottom: 5px; /* Espacio entre las filas */
		}
		
		.info-row p {
		    margin: 0; /* Elimina los m�rgenes por defecto de los p�rrafos */
		    padding: 0;
		    flex: 1; /* Elimina los rellenos por defecto de los p�rrafos */
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
        <div class="nav-links">
            <div class="user-icon">
                <span class="welcome-message">Bienvenido <%= userEmail %></span>
                <a href="#"><i class="fas fa-user"></i></a>
            </div>
        </div>
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
                <p>Categor�a: <%= libro.getCategoria().getNombre_categoria() %></p>
            </div>
            <div class="description" style="text-align:left">
                <p><%= libro.getSumario() %></p>
            </div>
        </div>
            </div>
                    <div class="resenias-section" style="margin-top: 20px; background-color: #fff; border-radius: 10px; padding: 20px; border: 1px solid #ddd;">
		    <h5 style="color: #e08b72; font-size: 3rem; display: flex; justify-content: space-between; align-items: center;font-weight: bold">
		        Rese�as
		        <span id="arrow" style="cursor: pointer;" onclick="toggleResenias()">&#9660;</span>
		    </h5>
		    <div id="resenias-content" style="display:none;">
		        <%
		            if (reviews == null || reviews.isEmpty()) {
		        %>
		            <p>No hay rese�as a�n</p>
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
        </div>

    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnol�gica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>