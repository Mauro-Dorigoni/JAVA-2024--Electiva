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
    <title>Admin Dashboard - Baja de Libro</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
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
            z-index: 1000;
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
            <div class="card-container">
                <% for(Libro libro : libros) { %>
                <div class="card">
                    <img src="assets/libros/<%= libro.getIdPhoto() %>.jpg" alt="Imagen de <%= libro.getTitulo() %>">
                    <div class="card-content">
                        <h5><%= libro.getTitulo() %></h5>
                        <p>ID: <%= libro.getIdLibro() %> </p>
                        <p>Categoria: <%= libro.getCategoria().getNombre_categoria() %></p>
                    </div>
                    <form action="<%=request.getContextPath()%>/libroBaja" method="get">
                        <input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
                        <button type="submit">Eliminar</button>
                    </form>
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
                <button type="button" class="close" id="modalCloseButton" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
            </div>
            <div class="modal-footer">
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

        // Añadimos el evento click al botón de cerrar del modal
        $('#modalCloseButton, #modalFooterCloseButton').click(function() {
            $('#messageModal').modal('hide'); // Cierra el modal
            window.location.href = '<%=request.getContextPath()%>/adminDashboard.jsp'; // Redirige a adminDashboard.jsp
        });
    });
</script>

    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>