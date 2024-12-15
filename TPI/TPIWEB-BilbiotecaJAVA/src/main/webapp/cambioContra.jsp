<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.*" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.*" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Cliente cliente = (Cliente) request.getAttribute("cliente");
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambio de Contraseña</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        html, body {
		    height: 100%;
		    margin: 0;
		    display: flex;
		    flex-direction: column;
		}
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            min-height: 100vh;
		    display: flex;
		    flex-direction: column;
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
	
	    .form button.detalle:hover {
	        background-color: #f8f9fa;
	    }
	
	    /* Estilo del botón Sacar a Préstamo */
	    .form button.prestamo {
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
			  .form-group {
		        margin-bottom: 15px;
		    }
		
		    .form-buttons {
		        display: flex;
		        justify-content: space-between;
		    }
		
		    .btn-primary, .btn-secondary {
		        width: 48%;
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
        <jsp:include page="userOptions.jsp">
		    <jsp:param name="userEmail" value="<%= userEmail %>" />
		</jsp:include>
    </div>

    <!-- Menu row -->
    <div class="menu-row">
         <jsp:include page="hamburguerMenu.jsp">
		    <jsp:param name="userEmail" value="<%= userEmail %>" />
		</jsp:include>
        <div class="menu-title">
	        Cambio de Contraseña
	    </div>
    </div>

<div class="main-content">
    <div id="login">
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="login-form" class="form" action="<%=request.getContextPath()%>/changePass" method="post">
                            <h3 class="text-center text-info">Cambio de Contraseña</h3>
                            <input type="hidden" id="userEmail" name="userEmail" value="<%=userEmail%>">
                            <div class="form-group">
                                <label for="curpassword" class="text-info">Contraseña Actual</label>
                                <input type="password" name="curpassword" id="curpassword" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="newpassword" class="text-info">Nueva Contraseña</label>
                                <input type="password" name="newpassword" id="newpassword" class="form-control">
                            </div>
                            <div class="form-group d-flex justify-content-between align-items-center">
                                <button type="button" class="btn btn-secondary" onclick="window.history.back()">Volver</button>
                                <input type="submit" name="submit" class="btn btn-custom btn-md" width=48% value="Cambiar">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
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
	            <form id="redirectForm" action="<%=request.getContextPath()%>/listLibros" method="get" style="display: none;">
				    <input type="hidden" name="actionLibro" value="userDashboard">
				</form>
                <%
                    String messageType = (String) request.getAttribute("messageType");
                    if (messageType != null && messageType.equals("success")) {
                    	session.invalidate();
                %>
                <!-- Si es un éxito, muestra el botón que redirige a login.jsp -->
                <button type="button" class="btn btn-primary" id="acceptButton" onclick="window.location.href='<%= request.getContextPath() %>/login.jsp'">Acepto</button>
                <%
                    } else {
                %>
                <!-- Si no es éxito, muestra el botón de cerrar -->
                <button type="button" class="btn btn-secondary" id="modalFooterCloseButton">Volver</button>
                <%
                    }
                %>
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
    <div class="footer" style="position: fixed">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>