<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.LinkedList" %>
<%@ page import="entidades.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }

   LinkedList<Review> reviews = (LinkedList<Review>) request.getAttribute("reviews");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Moderacion de Categorias</title>
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
            <a href="#" class="dropdown-btn">Categorías</a>
            <div class="dropdown-container">
               	<form id="listadoCategoriasForm" action="<%=request.getContextPath()%>/listCategorias" method="get" style="display: none;">
					<input type="hidden" id="action" name="action" value="">
				</form>
                <a href="#" onclick="setActionAndSubmit('listado'); return false;">Listado</a>
			    <a href="<%=request.getContextPath()%>/altaCategoria.jsp">Nueva Categoria</a>
			    <a href="#" onclick="setActionAndSubmit('modificar'); return false;">Modificar Categoria</a>
			    <a href="#" onclick="setActionAndSubmit('baja'); return false;">Baja Categoria</a>
            </div>
            <a href="#" class="dropdown-btn">Libros</a>
            <div class="dropdown-container">
                <form id="listadoLibrosForm" action="<%=request.getContextPath()%>/listLibros?action=user" method="get" style="display: none;">
                	<input type="hidden" id="actionLibro" name="actionLibro" value="">
            	</form>
	            <script>
	                function setActionAndSubmitLibros(actionValue) {
	                	document.getElementById('actionLibro').value = actionValue;
	                    document.getElementById('listadoLibrosForm').submit();
	                }
	            </script>
                <a href="#" onclick="setActionAndSubmitLibros('listado'); return false;">Listado</a>
                <a href="#" onclick="setActionAndSubmit('altaLibro'); return false;">Nuevo Libro</a>
                <a href="#" onclick="setActionAndSubmitLibros('modificar'); return false;">Modificar Libro</a>
                <a href="#" onclick="setActionAndSubmitLibros('baja'); return false;">Baja Libro</a>
            </div>
            <a href="#" class="dropdown-btn">Ejemplares</a>
            <div class="dropdown-container">
                <form id="listadoEjemplaresForm" action="<%=request.getContextPath()%>/listEjemplares" method="get" style="display: none;">
                	<input type="hidden" id="actionEjemplares" name="actionEjemplares" value="">
            	</form>
            	<script>
	                function setActionAndSubmitEjemplares(actionValue) {
	                	document.getElementById('actionEjemplares').value = actionValue;
	                    document.getElementById('listadoEjemplaresForm').submit();
	                }
	            </script>
                <a href="#" onclick="setActionAndSubmitEjemplares('listado'); return false;">Listado</a>
                <a href="#" onclick="setActionAndSubmitLibros('ejemplares'); return false;">Nuevo Ejemplar</a>
                <a href="#" onclick="setActionAndSubmitEjemplares('modificar'); return false;">Modificar Ejemplar</a>
                <a href="#" onclick="setActionAndSubmitEjemplares('baja'); return false;">Baja Ejemplar</a>
            </div>
            <a href="#" class="dropdown-btn">Prestamos</a>
            <div class="dropdown-container">
                <form id="listadoPrestamosForm" action="<%=request.getContextPath()%>/listPrestamos" method="get" style="display: none;">
                </form>
                <a href="#" onclick="document.getElementById('listadoPrestamosForm').submit(); return false;">Registrar Estado</a>
            </div>
            <a href="#" class="dropdown-btn">Clientes</a>
            <div class="dropdown-container">
                <form id="listadoClientesForm" action="<%=request.getContextPath()%>/listClientes" method="get" style="display: none;">
                	<input type="hidden" name="action" id="actionInput">
                </form>
                <a href="#" onclick="setActionAndSubmitClientes('privilegios'); return false;">Otorgar Privilegios</a>
    			<a href="#" onclick="setActionAndSubmitClientes('pago'); return false;">Registrar pago</a>
                <a href="#" onclick="setActionAndSubmitLibros('userDashboard'); return false;">Vista Usuario</a>
	            <script>
				    function setActionAndSubmitClientes(actionValue) {
				        document.getElementById('actionInput').value = actionValue;
				        document.getElementById('listadoClientesForm').submit();
				    }
				</script>
            </div>
            <a href="#" class="dropdown-btn active">Reseñas</a>
            <div class="dropdown-container">
                <a href="<%=request.getContextPath()%>/listReviewsPendientes">Moderacion</a>
            </div>
        </div>

        <!-- Main Content -->
<div class="main-content">
    <div class="card-container">
        <% if (reviews.isEmpty()) { %>
            <div class="card">
                <div class="card-content">
                    <p>No hay reseñas pendientes de moderación</p>
                </div>
            </div>
        <% } %>
        <% for (Review review : reviews) { %>
            <div class="card">
                <div class="card-content">
                    <h5>Libro: <%= review.getPrestamo().getEjemplar().getLibro().getTitulo() %></h5>
                    <h5>Por: <%= review.getPrestamo().getCliente().getNombre() + " " + review.getPrestamo().getCliente().getApellido() %></h5>
                    <p>ID: <%= review.getIdReview() %></p>
                    <p>Puntaje: <%= review.getPuntaje() + "/5" %></p>
                    <p>Contenido: <%= review.getDescripcion() %></p>
                </div>

                <!-- Botones en bloque -->
                <div class="d-flex flex-column">
                    <!-- Botón para aceptar la reseña -->
                    <form action="<%=request.getContextPath()%>/publishReview" method="get" class="mb-2">
                        <input type="hidden" name="idReview" value="<%= review.getIdReview() %>">
                        <input type="hidden" name="mailAdmin" value="<%= userEmail %>">
                        <button type="submit" class="btn btn-success btn-block">Publicar</button>
                    </form>

                    <!-- Botón para abrir el modal de rechazo -->
                    <button type="button" class="btn btn-danger btn-block" style="background-color: #6c757d" data-toggle="modal" data-target="#modalRechazo-<%= review.getIdReview() %>">
                        Rechazar
                    </button>
                </div>

                <!-- Modal para el motivo de rechazo -->
                <div class="modal fade" id="modalRechazo-<%= review.getIdReview() %>" tabindex="-1" role="dialog" aria-labelledby="modalLabel-<%= review.getIdReview() %>" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalLabel-<%= review.getIdReview() %>">Motivo de Rechazo</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <!-- Formulario dentro del modal para enviar el rechazo -->
                                <form action="<%=request.getContextPath()%>/rejectReview" method="post">
                                    <input type="hidden" name="idReview" value="<%= review.getIdReview() %>">
                                    <input type="hidden" name="mailAdmin" value="<%= userEmail %>">
                                    <div class="form-group">
                                        <label for="motivoRechazo-<%= review.getIdReview() %>">Motivo:</label>
                                        <textarea id="motivoRechazo-<%= review.getIdReview() %>" name="motivoRechazo" class="form-control" placeholder="Escribe el motivo del rechazo..." rows="3" required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-danger">Enviar rechazo</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</div>
</div>
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLabel">
                    <%= request.getAttribute("messageType") != null && request.getAttribute("messageType").equals("success") ? "Éxito" : "Error" %>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
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
    });
</script>
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
        function setActionAndSubmit(actionValue) {
            document.getElementById('action').value = actionValue;
            document.getElementById('listadoCategoriasForm').submit();
        }
    </script>
</body>
</html>