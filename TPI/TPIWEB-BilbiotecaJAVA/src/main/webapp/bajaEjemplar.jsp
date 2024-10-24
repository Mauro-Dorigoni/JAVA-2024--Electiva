<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="entidades.*" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }
    LinkedList<Libro> libros = (LinkedList<Libro>) request.getAttribute("libros");
    LinkedList<Ejemplar> ejemplares = (LinkedList<Ejemplar>) request.getAttribute("ejemplares");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Baja de Ejemplar</title>
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

        .footer {
            background-color: #e08b72;
            padding: 20px;
            text-align: center;
            position: relative;
            width: 100%;
            bottom: 0;
            box-sizing: border-box;
        }

        .footer p {
            color: white;
            font-weight: bold;
            margin: 0;
        }
        .sidebar .active {
        background-color: #3C7D93;
        text-decoration: underline;
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
            <a href="#" class="dropdown-btn active">Ejemplares</a>
            <div class="dropdown-container">
                <a href="#">Listado</a>
                <a href="#" onclick="setActionAndSubmitLibros('ejemplares'); return false;">Nuevo Ejemplar</a>
                <a href="#">Modificar Ejemplar</a>
                <a href="#">Baja Ejemplar</a>
            </div>
            <a href="#" class="dropdown-btn">Prestamos</a>
            <div class="dropdown-container">
                <form id="listadoPrestamosForm" action="<%=request.getContextPath()%>/listPrestamos" method="get" style="display: none;">
                </form>
                <a href="#" onclick="document.getElementById('listadoPrestamosForm').submit(); return false;">Registrar Estado</a>
            </div>
            <a href="#" class="dropdown-btn">Pagos</a>
            <div class="dropdown-container">
                <form id="listadoClientesForm" action="<%=request.getContextPath()%>/listClientes" method="get" style="display: none;">
                </form>
                <a href="#" onclick="document.getElementById('listadoClientesForm').submit(); return false;">Registrar pago</a>
            </div>
            <a href="#" class="dropdown-btn">Reseñas</a>
            <div class="dropdown-container">
                <a href="#">Moderacion</a>
            </div>
            <div class="dropdown-container">
                <a href="#">Listado</a>
            </div>
        </div>

        <!-- Main Content -->
		<div class="main-content">
		    <div class="form-container">
		        <h1>Baja de Ejemplar</h1>
		        <form action="<%=request.getContextPath()%>/bajaEjemplar" method="POST">
		            <!-- Selección de Libro -->
		            <div class="form-group">
		                <label for="libro">Libro:</label>
		                <select id="libro" name="libro" required onchange="filtrarEjemplares()">
		                    <option value="">Seleccione un libro</option>
		                    <% for(Libro libro : libros) { %>
		                        <option value="<%= libro.getIdLibro() %>"><%= libro.getTitulo() %></option>
		                    <% } %>
		                </select>
		            </div>
		
		            <!-- Selección de Ejemplar (se cargará dinámicamente) -->
		            <div class="form-group">
		                <label for="ejemplar">Ejemplar:</label>
		                <select id="ejemplar" name="ejemplar" required onchange="mostrarDatosEjemplar()">
		                    <option value="">Seleccione un ejemplar</option>
		                </select>
		            </div>
		            <div class="form-group">
		                <input data-mdb-ripple-init class="btn btn-custom btn-block btn-md" type="submit" value="DAR DE BAJA EJEMPLAR"/>
		            </div>
		        </form>
		    </div>
		</div>
		
		<!-- Pasar los datos de ejemplares y libros a JavaScript -->
		<script>
		    // Lista de todos los ejemplares con sus datos
		    var ejemplares = [
		        <% for(Ejemplar ejemplar : ejemplares) { %>
		            {
		                idEjemplar: "<%= ejemplar.getIdEjemplar() %>",
		                libroId: "<%= ejemplar.getLibro().getIdLibro() %>",
		                editorial: "<%= ejemplar.getEditorial() %>",
		                numeroEdicion: "<%= ejemplar.getNroEdicion() %>",
		                fechaEdicion: "<%= ejemplar.getFechaEdicion() %>",
		                paginas: "<%= ejemplar.getCantPaginas() %>"
		            },
		        <% } %>
		    ];
		</script>

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

    <script>
        var dropdown = document.getElementsByClassName("dropdown-btn");
        var i;

        for (i = 0; i < dropdown.length; i++) {
            dropdown[i].addEventListener("click", function() {
                // Primero, cerrar todos los dropdowns
                for (var j = 0; j < dropdown.length; j++) {
                    if (dropdown[j] !== this) {
                        dropdown[j].classList.remove("active");
                        dropdown[j].nextElementSibling.style.display = "none";
                    }
                }

                // Alternar el estado del dropdown actual
                this.classList.toggle("active");
                var dropdownContent = this.nextElementSibling;
                if (dropdownContent.style.display === "block") {
                    dropdownContent.style.display = "none";
                } else {
                    dropdownContent.style.display = "block";
                }
            });
        }
        function setActionAndSubmit(actionValue) {
            document.getElementById('action').value = actionValue;
            document.getElementById('listadoCategoriasForm').submit();
        }
        
     // Función para filtrar los ejemplares por el libro seleccionado
        function filtrarEjemplares() {
            var libroId = document.getElementById("libro").value;
            var ejemplarSelect = document.getElementById("ejemplar");

            // Limpiar el select de ejemplares antes de rellenarlo de nuevo
            ejemplarSelect.innerHTML = '<option value="">Seleccione un ejemplar</option>';

            // Filtrar los ejemplares que correspondan al libro seleccionado
            var ejemplaresFiltrados = ejemplares.filter(function(ejemplar) {
                return ejemplar.libroId === libroId;
            });

            // Añadir al select los ejemplares filtrados
            ejemplaresFiltrados.forEach(function(ejemplar) {
                var option = document.createElement("option");
                option.value = ejemplar.idEjemplar;
                option.text = "ID: " + ejemplar.idEjemplar;
                ejemplarSelect.appendChild(option);
            });
        }

        // Función para completar los campos del ejemplar seleccionado
        function mostrarDatosEjemplar() {
            var ejemplarId = document.getElementById("ejemplar").value;

            // Buscar el ejemplar seleccionado
            var ejemplarSeleccionado = ejemplares.find(function(ejemplar) {
                return ejemplar.idEjemplar === ejemplarId;
            });

            // Rellenar los campos del formulario con los datos del ejemplar
            if (ejemplarSeleccionado) {
                document.getElementById("editorial").value = ejemplarSeleccionado.editorial;
                document.getElementById("numeroEdicion").value = ejemplarSeleccionado.numeroEdicion;
                document.getElementById("fechaEdicion").value = ejemplarSeleccionado.fechaEdicion;
                document.getElementById("paginas").value = ejemplarSeleccionado.paginas;
            } else {
                // Limpiar los campos si no se selecciona un ejemplar válido
                document.getElementById("editorial").value = '';
                document.getElementById("numeroEdicion").value = '';
                document.getElementById("fechaEdicion").value = '';
                document.getElementById("paginas").value = '';
            }
        }

        
    </script>
</body>
</html>