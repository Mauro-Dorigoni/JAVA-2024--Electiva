<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Categoria_libro" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }
    List<Categoria_libro> categorias = (List<Categoria_libro>) request.getAttribute("categorias");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Alta de Libro</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaAdmin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>

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
            text-align: center; /* Centrar el título */
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
		    text-overflow: ellipsis; /* Añade puntos suspensivos si el texto es demasiado largo */
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
		            <div class="form-container">
		                <h1>Alta de Libro</h1>
		                <form action="<%=request.getContextPath()%>/registerLibro" method="POST" enctype="multipart/form-data">
		                    <div class="form-group">
		                        <label for="titulo">Título:</label>
		                        <input type="text" id="titulo" name="titulo" required>
		                    </div>
		                    <div class="form-group">
		                        <label for="autor">Autor:</label>
		                        <input type="text" id="autor" name="autor" required>
		                    </div>
		                    <div class="form-group">
		                        <label for="isbn">ISBN:</label>
		                        <input type="text" id="isbn" name="isbn" required>
		                    </div>
		                    <div class="form-group">
		                        <label for="sumario">Sumario:</label>
		                        <textarea id="sumario" name="sumario" rows="5" required></textarea>
		                    </div>
		                    <div class="form-group">
		                        <label for="foto">Foto:</label>
		                        <input type="file" id="foto" name="foto" accept="image/*" required>
		                    </div>
		                    <div class="form-group">
		                        <label for="categoria">Categoría:</label>
		                        <select id="categoria" name="categoria" required>
		                            <option value="">Seleccione una categoría</option>
		                            <% for(Categoria_libro categoria : categorias) { %>
		                                <option value="<%= categoria.getIdCategoria() %>"><%= categoria.getNombre_categoria() %></option>
		                            <% } %>
		                        </select>
		                    </div>
		                    <div class="form-group">
                        		<input data-mdb-ripple-init class="btn btn-custom btn-block btn-md" type="submit" value="REGISTRAR LIBRO"/>
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

    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>

</body>
</html>