<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="entidades.*" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Otorgar Permisos</title>
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
            margin-top: 120px;
            margin-left: 250px;
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 20px;
            box-sizing: border-box;
        	padding-bottom: 120px;
        }

        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px;
            width: 100%;
        }

        .form-container h1 {
            color: #e08b72;
            margin-bottom: 30px;
            text-align: center; /* Centrar el t�tulo */
        }

        .form-group label {
            font-weight: bold;
            color: #e08b72; /* Color de los descriptores */
            text-align: left;
            display: block;
        }

        .form-group input[type="text"], .form-group textarea, .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-group input[type="text"]:focus, .form-group textarea:focus, .form-group input[type="file"]:focus {
            border-color: #4FA5BF; /* Resaltado celeste */
            outline: none;
            box-shadow: 0 0 5px #4FA5BF;
        }

        .form-group button[type="submit"] {
            background-color: #e08b72;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-group button[type="submit"]:hover {
            background-color: #c76a57;
        }

        .footer {
            background-color: #e08b72;
            padding: 20px;
            text-align: center;
            position: fixed;
            width: 100%;
            bottom: 0;
            box-sizing: border-box;
        }

        .footer p {
            color: white;
            font-weight: bold;
            margin: 0;
        }

	    .form-container {
	        background-color: white;
	        padding: 30px;
	        border-radius: 2px;
	        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	        max-width: 600px;
	        margin: 20px;
	        width: 100%;
	        border: 2px solid #e08b72;
		}
		.form-group select {
		    width: 100%;
		    padding: 10px;
		    margin-top: 5px;
		    margin-bottom: 15px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    box-sizing: border-box;
		    white-space: nowrap; /* Evita que el texto se corte */
		    overflow: hidden; /* Oculta cualquier desbordamiento de texto */
		    text-overflow: ellipsis; /* A�ade puntos suspensivos si el texto es demasiado largo */
		}
		.form-group select option {
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		.form-group select:focus {
		    border-color: #4FA5BF; /* Resaltado celeste */
		    outline: none;
		    box-shadow: 0 0 5px #4FA5BF;
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
		    <jsp:param name="activeSection" value="clientes" />
		</jsp:include>
        <!-- Main Content -->
		<div class="main-content">
		    <div class="form-container">
		        <h1>Otorgar Permisos</h1>
		        <form action="<%=request.getContextPath()%>/grantAdmin" method="GET">
		            <div class="form-group">
		                <label for="cliente">Cliente:</label>
		                <select id="cliente" name="idCliente">
		                    <option value="">Seleccione un cliente</option>
		                    <% for(Cliente cliente : clientes) { %>
		                        <option value="<%= cliente.getId() %>"> <%= cliente.getId() %> - <%= cliente.getMail() %> (<%= cliente.isAdmin() ? "Admin" : "User" %>)
		                        </option>
		                    <% } %>
		                </select>
		            </div>
		            <div class="form-group">
		                <input class="btn btn-custom btn-block btn-md" type="submit" value="Otorgar Admin"/>
		            </div>
		        </form>
		    </div>
		</div>
	</div>
    
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLabel">
                    <%= request.getAttribute("messageType") != null && request.getAttribute("messageType").equals("success") ? "�xito" : "Error" %>
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

    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnol�gica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>