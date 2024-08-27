<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Login</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <style>
	    .footer {
	        background-color: #e08b72;
	        padding: 20px;
	        text-align: center;
	        position: fixed;
	        width: 100%;
	        bottom: 0;
	    }
	
	    .footer p {
	        color: white;
	        font-weight: bold;
	        margin: 0;
    }
</style>
</head>
<body>
    <div id="login">
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="login-form" class="form" action="<%=request.getContextPath()%>/login" method="post">
                            <h3 class="text-center text-info">Login</h3>
                            <div class="form-group">
                                <label for="username" class="text-info">Direccion de e-mail</label>
                                <input type="email" name="username" id="username" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Contraseña</label>
                                <input type="password" name="password" id="password" class="form-control">
                            </div>
                            <div class="form-group d-flex justify-content-between align-items-center">
                                <a href="<%=request.getContextPath()%>/register.jsp" id="register-link" class="text-info">Registrarse</a>
                                <input type="submit" name="submit" class="btn btn-custom btn-md" value="INGRESAR">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
	    <p>Todos los derechos reservados Universidad Tecnológica Nacional Facultad Regional Rosario</p>
	</div>
</body>
</html>
