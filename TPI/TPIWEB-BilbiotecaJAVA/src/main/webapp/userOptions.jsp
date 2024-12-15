<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<% String userEmail = request.getParameter("userEmail"); %>

<link rel="stylesheet" href="assets/CSS/userOptions.css">

<div class="nav-links">
    <div class="user-icon">
        <span class="welcome-message">Bienvenido <%= userEmail %></span>
        <i class="fas fa-user" id="user-icon"></i> 
        <div class="user-dropdown-menu" id="user-dropdown-menu" style="display: none;">
            <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=pagos">Mis pagos</a>
            <a href="<%= request.getContextPath() %>/userPrestamos?userEmail=<%= userEmail %>">Mis préstamos</a>
            <a href="<%= request.getContextPath() %>/listClienteReviews?userEmail=<%=userEmail %>">Mis reseñas</a>
            <hr>
            <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=contra">Cambiar Contraseña</a>
            <a href="<%= request.getContextPath() %>/userDetail?userEmail=<%= userEmail %>&action=baja">Baja Cuenta</a>
            <hr>
            <a href="<%= request.getContextPath() %>/logout">Logout</a>
        </div>
    </div>
</div>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    // Selecciona el ícono y el menú desplegable
    var userIcon = document.getElementById('user-icon');
    var dropdownMenu = document.getElementById('user-dropdown-menu');

    // Maneja el clic en el ícono del usuario
    userIcon.addEventListener('click', function (event) {
        event.stopPropagation(); // Evita que el clic cierre el menú inmediatamente
        // Alterna la visibilidad del menú
        if (dropdownMenu.style.display === 'none') {
            dropdownMenu.style.display = 'block'; // Muestra el menú
        } else {
            dropdownMenu.style.display = 'none'; // Oculta el menú
        }
    });

    // Cierra el menú si se hace clic fuera de él
    document.addEventListener('click', function (event) {
        if (!dropdownMenu.contains(event.target) && !userIcon.contains(event.target)) {
            dropdownMenu.style.display = 'none'; // Oculta el menú
        }
    });
});
</script>