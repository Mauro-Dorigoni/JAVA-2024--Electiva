<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Categoria_libro" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null || !userRole.equals("admin")) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Recuperar la lista de categor�as desde el request
    List<Categoria_libro> categorias = (List<Categoria_libro>) request.getAttribute("categorias");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Baja de Categoria</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/listadosAdmin.css">
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
		    <jsp:param name="activeSection" value="categorias" />
		</jsp:include> 

        <!-- Main Content -->
        <div class="main-content">
            <div class="card-container">
                <% for(Categoria_libro categoria : categorias) { %>
                <div class="card">
                    <img src="assets/categorias/<%=categoria.getIdPhoto() %>" alt="Imagen de <%= categoria.getNombre_categoria() %>">
                    <div class="card-content">
                        <h5><%= categoria.getNombre_categoria() %></h5>
                        <p>ID: <%= categoria.getIdCategoria() %></p>
                    </div>
                    <form action="<%=request.getContextPath()%>/categoriaBaja" method="get">
                        <input type="hidden" name="idCategoria" value="<%= categoria.getIdCategoria() %>">
                        <button type="submit">Eliminar</button>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
    </div>
<!-- Modal -->
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLabel">
                    <%= request.getAttribute("messageType") != null && request.getAttribute("messageType").equals("success") ? "�xito" : "Error" %>
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

            $('#modalCloseButton, #modalFooterCloseButton').click(function() {
                $('#messageModal').modal('hide');
                window.location.href = '<%=request.getContextPath()%>/adminDashboard.jsp';
            });
        });
    </script>

    <!-- Footer -->
    <div class="footer">
        <p>Todos los derechos reservados Universidad Tecnol�gica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>