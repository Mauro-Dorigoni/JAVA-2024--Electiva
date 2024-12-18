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
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Registro Pago</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/adminForms.css">
    <link rel="stylesheet" href="assets/CSS/vistaAdmin.css">
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
		    <jsp:param name="activeSection" value="clientes" />
		</jsp:include>

        <!-- Main Content -->
		<div class="main-content">
		    <div class="form-container">
		        <h1>Registro de Pago de Cliente</h1>
		        <form action="<%=request.getContextPath()%>/registerPago" method="POST">
		            <div class="form-group">
		                <label for="cliente">Cliente:</label>
		                <select id="cliente" name="idCliente" onchange="updateFechaUltimoPago()" required>
		                    <option value="">Seleccione un cliente</option>
		                    <% for(Cliente cliente : clientes) { %>
		                        <option value="<%= cliente.getId() %>" 
		                                data-ultimoPago="<%= cliente.getFechaUltimoPago() != null ? cliente.getFechaUltimoPago() : "No ha realizado pagos todavía" %>">
		                            <%= cliente.getId() %> - <%= cliente.getMail() %> (<%= cliente.isAdmin() ? "Admin" : "User" %>)
		                        </option>
		                    <% } %>
		                </select>
		            </div>
		            <div class="form-group">
		                <label for="ultimoPago">Último Pago:</label>
		                <input type="text" id="ultimoPago" name="ultimoPago" value="Seleccione un cliente" readonly>
		            </div>
		            <div class="form-group">
		                <label for="fechaPago">Fecha de Pago:</label>
		                <input type="date" id="fechaPago" name="fechaPago" required>
		            </div>
		            <div class="form-group">
		                <input class="btn btn-custom btn-block btn-md" type="submit" value="REGISTRAR PAGO"/>
		            </div>
		        </form>
		    </div>
		</div>
	</div>
		
		<script>
		    function updateFechaUltimoPago() {
		        const clienteDropdown = document.getElementById('cliente');
		        const selectedOption = clienteDropdown.options[clienteDropdown.selectedIndex];
		        const ultimoPago = selectedOption.getAttribute('data-ultimoPago');
		        document.getElementById('ultimoPago').value = ultimoPago;
		    }
		</script>
    
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

    <div class="footer" style="position:fixed">
        <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>