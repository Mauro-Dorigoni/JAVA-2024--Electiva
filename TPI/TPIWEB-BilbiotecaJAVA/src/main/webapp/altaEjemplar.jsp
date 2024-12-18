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
    List<Libro> libros = (List<Libro>) request.getAttribute("libros");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Alta de Ejemplar</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaAdmin.css">
    <link rel="stylesheet" href="assets/CSS/adminForms.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
		    <jsp:param name="activeSection" value="ejemplares" />
		</jsp:include> 
      
		
        <!-- Main Content -->
		<div class="main-content">
		            <div class="form-container">
		                <h1>Alta de Ejemplar</h1>
		                <form action="<%=request.getContextPath()%>/registerEjemplar" method="GET">
		                    <div class="form-group">
		                        <label for="libro">Libro:</label>
		                        <select id="libro" name="libro" required>
		                            <option value="">Seleccione un libro</option>
		                            <% for(Libro libro : libros) { %>
		                                <option value="<%= libro.getIdLibro() %>"><%= libro.getTitulo() %></option>
		                            <% } %>
		                        </select>
		                    </div>
		                    <div class="form-group">
				                <label for="editorial">Editorial:</label>
				                <input type="text" id="editorial" name="editorial" required>
				            </div>
		                    <div class="form-group">
				                <label for="numeroEdicion">Número de Edición:</label>
				                <input type="number" id="numeroEdicion" name="numeroEdicion" required>
				            </div>
				            <div class="form-group">
				                <label for="fechaEdicion">Fecha de Edición:</label>
				                <input type="date" id="fechaEdicion" name="fechaEdicion" required>
				            </div>
				            <div class="form-group">
				                <label for="paginas">Cantidad de Páginas:</label>
				                <input type="number" id="paginas" name="paginas" required>
				            </div>
		                    <div class="form-group">
                        		<input data-mdb-ripple-init class="btn btn-custom btn-block btn-md" type="submit" value="REGISTRAR EJEMPLAR"/>
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