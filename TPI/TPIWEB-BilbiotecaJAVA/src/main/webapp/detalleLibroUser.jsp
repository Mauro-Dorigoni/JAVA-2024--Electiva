<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.*" %>
<%@ page import="java.util.LinkedList" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Libro libro = (Libro) request.getAttribute("libro");
	LinkedList<Review> reviews = libro.getReviews();
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle Libro</title>
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
		        Detalle Libro
		 </div>
    </div>

    <div class="main-content">
	  <div class="detail-container">
	     <img src="assets/libros/<%= libro.getIdPhoto() %>.jpg" alt="Imagen de <%= libro.getTitulo() %>">
	       <div class="detail-content">
	       		<h5><%= libro.getTitulo() %></h5>
	       <div class="info-row">
	           <p>Autor: <%= libro.getAutor() %></p>
	           <p>ISBN: <%= libro.getISBN() %></p>
	           <p>Puntaje: <%= libro.getPuntaje() %></p>
	       </div>
	       <div class="info-row">
	           <p>ID: <%= libro.getIdLibro() %></p>
	           <p>
		           <form id="categoriaForm" action="categoriaDetail" method="GET" style="display:inline;">
	                    <input type="hidden" name="idCategoria" value="<%= libro.getCategoria().getIdCategoria() %>">
	                    <input type="hidden" name="action" value="user">
	                    <a href="#" onclick="document.getElementById('categoriaForm').submit();" 
	                       style="text-decoration: none; color: #6c757d;font-size: 20px" class="categoria-link">
	                        Categoría: <%= libro.getCategoria().getNombre_categoria() %>
	                    </a>
	                </form>	 
	       </div>
	       <div class="description" style="text-align:left">
	           <p><%= libro.getSumario() %></p>
	       </div>
	   </div>
	  </div>
	  <div style="margin-top: 20px;">
			<form id="validateLoanForm"action="<%=request.getContextPath()%>/verifyPrestamo" method="POST">
				<input type="hidden" name="idLibro" value="<%= libro.getIdLibro() %>">
				<input type="hidden" name="userEmail" value="<%= userEmail %>">
				<input class="btn btn-custom btn-block btn-md" type="submit" value="SACAR A PRESTAMO" style="font-weight: bold; height: 50px;"/>
			</form>
		</div>
	  	<div class="resenias-section" style="margin-top: 20px; background-color: #fff; border-radius: 10px; padding: 20px; border: 1px solid #ddd;">
		    <h5 style="color: #e08b72; font-size: 3rem; display: flex; justify-content: space-between; align-items: center;font-weight: bold">
		        Reseñas
		        <span id="arrow" style="cursor: pointer;" onclick="toggleResenias()">&#9660;</span>
		    </h5>
		    <div id="resenias-content" style="display:none;">
		        <%
		            if (reviews == null || reviews.isEmpty()) {
		        %>
		            <p>No hay reseñas aún</p>
		        <%
		            } else {
		                for (Review review : reviews) {
		        %>
		            <div class="detail-container">
				       <div class="detail-content">
				       <div class="info-row">
				           <p><strong style="color:#e08b72"><%=review.getPrestamo().getCliente().getNombre()+" "+ review.getPrestamo().getCliente().getApellido()+": "%></strong><%=review.getPuntaje()+"/5" %></p>
				           <p><%= review.getDescripcion() %></p>
				       </div>
				   </div>
				  </div>
		        <%
		                }
		            }
		        %>
		    </div>
		</div>
		<script>
		    function toggleResenias() {
		        var reseniasContent = document.getElementById('resenias-content');
		        var arrow = document.getElementById('arrow');
		        
		        if (reseniasContent.style.display === "none" || reseniasContent.style.display === "") {
		            reseniasContent.style.display = "block";
		            arrow.innerHTML = "&#9650;"; // Cambiar la flecha hacia arriba
		        } else {
		            reseniasContent.style.display = "none";
		            arrow.innerHTML = "&#9660;"; // Cambiar la flecha hacia abajo
		        }
		    }
		</script>
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
</body>
</html>