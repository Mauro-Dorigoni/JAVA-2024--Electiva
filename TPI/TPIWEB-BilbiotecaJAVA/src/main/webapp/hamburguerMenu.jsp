<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<% String userEmail = request.getParameter("userEmail"); %>

<link rel="stylesheet" href="assets/CSS/hamburguerMenu.css">


 <div class="hamburger-menu">
     <i class="fas fa-bars"></i>
     <div class="dropdown-menu">
         <a href="<%= request.getContextPath() %>/userPrestamos?userEmail=<%= userEmail %>">Mis pr�stamos</a>
         <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=pagos">Mis pagos</a>
         <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=contra">Cambiar Contrase�a</a>
         <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=baja">Baja Cuenta</a>
         <a href="<%= request.getContextPath() %>/listClienteReviews?userEmail=<%=userEmail %>">Mis rese�as</a> 
     </div>
 </div>
 <script type="text/javascript">
 	document.addEventListener('DOMContentLoaded', function() {
     // Manejo del men� desplegable
     var hamburgerIcon = document.querySelector('.hamburger-menu');
     var dropdownMenu = document.querySelector('.dropdown-menu');

     hamburgerIcon.addEventListener('click', function() {
         // Alterna la visibilidad del men� desplegable
         if (dropdownMenu.style.display === 'block') {
             dropdownMenu.style.display = 'none';
         } else {
             dropdownMenu.style.display = 'block';
         }
     });

     // Opcional: Cierra el men� si se hace clic fuera de �l
     document.addEventListener('click', function(event) {
         if (!hamburgerIcon.contains(event.target) && !dropdownMenu.contains(event.target)) {
             dropdownMenu.style.display = 'none';
         }
     });
 });
</script>
 