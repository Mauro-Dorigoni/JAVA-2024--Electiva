<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="entidades.*" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.*" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
    if(userEmail == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Cliente cliente = (Cliente) request.getAttribute("cliente");
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambio de Contrase�a</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <link rel="stylesheet" href="assets/CSS/header&footer.css">
    <link rel="stylesheet" href="assets/CSS/vistaUser.css">
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
            <!-- Puedes agregar m�s campos ocultos aqu� si es necesario -->
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
	        Cambio de Contrase�a
	    </div>
    </div>

<div class="main-content">
    <div id="login">
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="login-form" class="form" action="<%=request.getContextPath()%>/changePass" method="post">
                            <h3 class="text-center text-info">Cambio de Contrase�a</h3>
                            <input type="hidden" id="userEmail" name="userEmail" value="<%=userEmail%>">
                            <div class="form-group">
                                <label for="curpassword" class="text-info">Contrase�a Actual</label>
                                <input type="password" name="curpassword" id="curpassword" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="newpassword" class="text-info">Nueva Contrase�a</label>
                                <input type="password" name="newpassword" id="newpassword" class="form-control">
                            </div>
                            <div class="form-group d-flex justify-content-between align-items-center">
                                <button type="button" class="btn btn-secondary" onclick="window.history.back()" style="width:48%">Volver</button>
                                <input type="submit" name="submit" class="btn btn-custom btn-md" value="Cambiar" style="width:48%">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

  	
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
	            <form id="redirectForm" action="<%=request.getContextPath()%>/listLibros" method="get" style="display: none;">
				    <input type="hidden" name="actionLibro" value="userDashboard">
				</form>
                <%
                    String messageType = (String) request.getAttribute("messageType");
                    if (messageType != null && messageType.equals("success")) {
                    	session.invalidate();
                %>
                <!-- Si es un �xito, muestra el bot�n que redirige a login.jsp -->
                <button type="button" class="btn btn-primary" id="acceptButton" onclick="window.location.href='<%= request.getContextPath() %>/login.jsp'">Acepto</button>
                <%
                    } else {
                %>
                <!-- Si no es �xito, muestra el bot�n de cerrar -->
                <button type="button" class="btn btn-secondary" id="modalFooterCloseButton">Volver</button>
                <%
                    }
                %>
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
        <p>Todos los derechos reservados Universidad Tecnol�gica Nacional Facultad Regional Rosario</p>
    </div>
</body>
</html>