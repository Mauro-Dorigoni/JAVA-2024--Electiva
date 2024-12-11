<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<link rel="stylesheet" href="assets/CSS/adminSidebar.css">
<div class="sidebar">
    <!-- Categorías -->
    <a href="#" class="dropdown-btn ${param.activeSection == null || 'categorias' == param.activeSection ? 'active' : ''}">Categorías</a>
    <div class="dropdown-container">
        <form id="listadoCategoriasForm" action="<%=request.getContextPath()%>/listCategorias" method="get" style="display: none;">
            <input type="hidden" id="action" name="action" value="">
        </form>
        <a href="#" onclick="setActionAndSubmit('listado'); return false;">Listado</a>
        <a href="<%=request.getContextPath()%>/altaCategoria.jsp">Nueva Categoria</a>
        <a href="#" onclick="setActionAndSubmit('modificar'); return false;">Modificar Categoria</a>
        <a href="#" onclick="setActionAndSubmit('baja'); return false;">Baja Categoria</a>
    </div>

    <!-- Libros -->
    <a href="#" class="dropdown-btn ${param.activeSection == null || 'libros' == param.activeSection ? 'active' : ''}">Libros</a>
    <div class="dropdown-container">
        <form id="listadoLibrosForm" action="<%=request.getContextPath()%>/listLibros?action=user" method="get" style="display: none;">
            <input type="hidden" id="actionLibro" name="actionLibro" value=""/>
        </form>
        <a href="#" onclick="setActionAndSubmitLibros('listado'); return false;">Listado</a>
        <a href="#" onclick="setActionAndSubmit('altaLibro'); return false;">Nuevo Libro</a>
        <a href="#" onclick="setActionAndSubmitLibros('modificar'); return false;">Modificar Libro</a>
        <a href="#" onclick="setActionAndSubmitLibros('baja'); return false;">Baja Libro</a>
    </div>

    <!-- Ejemplares -->
    <a href="#" class="dropdown-btn ${param.activeSection == null || 'ejemplares' == param.activeSection ? 'active' : ''}">Ejemplares</a>
    <div class="dropdown-container">
        <form id="listadoEjemplaresForm" action="<%=request.getContextPath()%>/listEjemplares" method="get" style="display: none;">
            <input type="hidden" id="actionEjemplares" name="actionEjemplares" value=""/>
        </form>
        <a href="#" onclick="setActionAndSubmitEjemplares('listado'); return false;">Listado</a>
        <a href="#" onclick="setActionAndSubmitLibros('ejemplares'); return false;">Nuevo Ejemplar</a>
        <a href="#" onclick="setActionAndSubmitEjemplares('modificar'); return false;">Modificar Ejemplar</a>
        <a href="#" onclick="setActionAndSubmitEjemplares('baja'); return false;">Baja Ejemplar</a>
    </div>

    <!-- Préstamos -->
    <a href="#" class="dropdown-btn ${param.activeSection == null || 'prestamos' == param.activeSection ? 'active' : ''}">Prestamos</a>
    <div class="dropdown-container">
        <form id="listadoPrestamosForm" action="<%=request.getContextPath()%>/listPrestamos" method="get" style="display: none;"></form>
        <a href="#" onclick="document.getElementById('listadoPrestamosForm').submit(); return false;">Registrar Estado</a>
    </div>

    <!-- Clientes -->
    <a href="#" class="dropdown-btn ${param.activeSection == null || 'clientes' == param.activeSection ? 'active' : ''}">Clientes</a>
    <div class="dropdown-container">
        <form id="listadoClientesForm" action="<%=request.getContextPath()%>/listClientes" method="get" style="display: none;">
            <input type="hidden" name="action" id="actionInput">
        </form>
        <a href="#" onclick="setActionAndSubmitClientes('privilegios'); return false;">Otorgar Privilegios</a>
        <a href="#" onclick="setActionAndSubmitClientes('pago'); return false;">Registrar pago</a>
        <a href="#" onclick="setActionAndSubmitLibros('userDashboard'); return false;">Vista Usuario</a>
    </div>

    <!-- Reseñas -->
    <a href="#" class="dropdown-btn ${param.activeSection == null || 'reviews' == param.activeSection ? 'active' : ''}">Reseñas</a>
    <div class="dropdown-container">
        <a href="<%=request.getContextPath()%>/listReviewsPendientes">Moderacion</a>
    </div>
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
	function setActionAndSubmitLibros(actionValue) {
    	document.getElementById('actionLibro').value = actionValue;
        document.getElementById('listadoLibrosForm').submit();
    }
	function setActionAndSubmitEjemplares(actionValue) {
    	document.getElementById('actionEjemplares').value = actionValue;
        document.getElementById('listadoEjemplaresForm').submit();
    }
	function setActionAndSubmitClientes(actionValue) {
        document.getElementById('actionInput').value = actionValue;
        document.getElementById('listadoClientesForm').submit();
    }

</script>
