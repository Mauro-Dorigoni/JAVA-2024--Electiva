<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entidades.Categoria_libro" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    Categoria_libro categoria = (Categoria_libro) request.getAttribute("categoria");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle Categoria</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaUser.css">
    <link rel="stylesheet" href="assets/CSS/detailUser.css">
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
        <div class="menu-title">
		        Detalle Categoria
		 </div>
    </div>

    <div class="main-content">
		<div class="detail-container">
              <img src="assets/categorias/<%= categoria.getIdPhoto() %>" alt="Imagen de <%= categoria.getIdPhoto() %>">
              <div class="detail-content">
                  <h5><%= categoria.getNombre_categoria() %></h5>
                  <p>ID: <%= categoria.getIdCategoria() %></p>
                  <div class="description" style="text-align:left">
                      <p><%= categoria.getDescripcion_apliada() %></p>
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
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>