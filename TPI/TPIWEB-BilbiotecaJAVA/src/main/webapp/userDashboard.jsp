<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Libro> libros = (List<Libro>) request.getAttribute("libros");
    List<Categoria_libro> categorias = (List<Categoria_libro>) request.getAttribute("categorias");
    LinkedList<String> autores = (LinkedList<String>) request.getAttribute("autores");
    String filterBy = (String) request.getAttribute("filterBy");
    String filtro = (String) request.getAttribute("filtro");
    
    StringBuilder librosIds = new StringBuilder();
    for (Libro libro : libros) {
        librosIds.append(libro.getIdLibro()).append(",");
    }
    if (librosIds.length() > 0) librosIds.setLength(librosIds.length() - 1);
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaUser.css">
    <link rel="stylesheet" href="assets/CSS/filterSearch.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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

        <div class="search-bar">
		    <form action="<%=request.getContextPath()%>/searchLibros" method="get">
		        <div class="input-group">
		            <input type="text" name="query" placeholder="Buscar libros..." value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
		            <button type="submit" class="btn btn-primary">
		                <i class="fas fa-search"></i>
		            </button>
		        </div>
		    </form>
		</div>

<div class="filter-sort">
    <form id="filterForm" action="<%=request.getContextPath()%>/filterLibros" method="get">
        <label for="filter">Filtrar por:</label>
        <select id="filter" name="filterBy" onchange="handleFilterChange()">
            <option value="all" <%= "all".equals(filterBy) ? "selected" : "" %>>Todos</option>
            <option value="category" <%= "category".equals(filterBy) ? "selected" : "" %>>Categoría</option>
            <option value="autor" <%= "autor".equals(filterBy) ? "selected" : "" %>>Autor</option>
        </select>

        <div id="categoryFilter" style="display: <%= "category".equals(filterBy) ? "block" : "none" %>;">
            <label for="category">Categoría:</label>
            <select id="category" name="category">
                <% for (Categoria_libro categoria : categorias) { %>
                    <option value="<%= categoria.getNombre_categoria() %>" <%= categoria.getNombre_categoria().equals(filtro) ? "selected" : "" %>><%= categoria.getNombre_categoria() %></option>
                <% } %>
            </select>
        </div>

        <div id="authorFilter" style="display: <%= "autor".equals(filterBy) ? "block" : "none" %>;">
            <label for="author">Autor:</label>
            <select id="author" name="author">
                <% for (String autor : autores) { %>
                    <option value="<%= autor %>" <%= autor.equals(filtro) ? "selected" : "" %>><%= autor %></option>
                <% } %>
            </select>
        </div>

        <input type="submit" id="botonFiltro" value="Filtrar">
    </form>

    <form id="sortForm" action="<%=request.getContextPath()%>/orderLibros" method="post">
        <input type="hidden" id="hiddenFilterBy" name="filterBy" value="<%= filterBy %>" />
        <input type="hidden" id="hiddenCategory" name="category" value="<%= request.getParameter("category") %>" />
        <input type="hidden" id="hiddenAuthor" name="author" value="<%= request.getParameter("author") %>" />
        <input type="hidden" name="librosIds" value="<%= librosIds.toString() %>" />
        <label for="sort">Ordenar por:</label>
        <select id="sort" name="sortBy" onchange="document.getElementById('sortForm').submit()">
            <option value="title">Título</option>
            <option value="categoria">Categoría</option>
            <option value="puntaje">Puntaje</option>
        </select>
    </form>
</div>
    </div>

    <div class="main-content">
        <div class="card-container">
            <% for(Libro libro : libros) { %>
            <div class="card">
                <img src="assets/libros/<%= libro.getIdPhoto() %>.jpg" alt="Imagen de <%= libro.getTitulo() %>">
                <div class="card-content">
                    <h5><%= libro.getTitulo() %></h5>
                    <p>Categoría: <%= libro.getCategoria().getNombre_categoria() %></p>
                    <p>Puntaje: <%= libro.getPuntaje() %></p>
                </div>
                <form action="<%=request.getContextPath()%>/libroDetail" method="get">
				    <input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
				    <input type="hidden" name="action" value="user">
				    <button type="submit" class="detalle">Detalles</button>
				</form>
                <form action="<%=request.getContextPath()%>/verifyPrestamo" method="post">
				    <input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
				    <input type="hidden" name="userEmail" value="<%= userEmail %>">
				    <button type="submit" class="prestamo">Sacar a Préstamo</button>
				</form>
            </div>
            <% } %>
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

        $('#modalCloseButton, #modalFooterCloseButton').click(function() {
            $('#messageModal').modal('hide');
            // Enviar el formulario oculto para redirigir
            $('#redirectForm').submit();
        });
    });
</script>
    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>

    <script>
    window.onload = function() {
        var sortBy = "<%= request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "" %>";
        if (sortBy) {
            document.getElementById('sort').value = sortBy;
        }
    }
    function handleFilterChange() {
        var filterBy = document.getElementById('filter').value;
        var categoryFilter = document.getElementById('categoryFilter');
        var authorFilter = document.getElementById('authorFilter');
        
        if (filterBy === 'category') {
            categoryFilter.style.display = 'block';
            authorFilter.style.display = 'none';
        } else if (filterBy === 'autor') {
            categoryFilter.style.display = 'none';
            authorFilter.style.display = 'block';
        } else {
            categoryFilter.style.display = 'none';
            authorFilter.style.display = 'none';
        }
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        // Actualiza los valores ocultos en el formulario de ordenamiento con los valores del formulario de filtrado
        var filterBy = document.getElementById('filter').value;
        var category = document.getElementById('category').value;
        var author = document.getElementById('author').value;

        document.getElementById('hiddenFilterBy').value = filterBy;
        document.getElementById('hiddenCategory').value = category;
        document.getElementById('hiddenAuthor').value = author; 
    });
    
    </script>
</body>
</html>