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
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        html, body {
		    height: 100%;
		}
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
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
		    <jsp:param name="activeSection" value="reviews" />
		</jsp:include> 
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
    <div class="footer" style="position:fixed">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>