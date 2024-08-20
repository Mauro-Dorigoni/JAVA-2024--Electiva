<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Login</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/assets/background-image-books.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            padding: 0;
        }
        #login .container #login-row #login-column #login-box {
            margin-top: 120px;
            max-width: 600px;
            border: 2px solid #e08b72;
            background-color: #ffffff;
            padding: 20px;
            box-sizing: border-box;
        }
        #login .container #login-row #login-column #login-box #login-form {
            display: flex;
            flex-direction: column;
        }
        #login .container #login-row #login-column #login-box #login-form .form-group {
            margin-bottom: 1rem;
        }
        #login .container #login-row #login-column #login-box #login-form .form-group:last-child {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        #login .container #login-row #login-column #login-box #login-form #register-link {
            margin-top: 0;
        }
        .text-info {
            color: #e08b72 !important;
        }
        .btn-custom {
            background-color: #e08b72;
            border: none;
            color: #ffffff;
        }
        .btn-custom:hover {
            background-color: #d07a5a; 
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
                                <label for="username" class="text-info">Usuario o e-mail</label>
                                <input type="text" name="username" id="username" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Contraseņa</label>
                                <input type="password" name="password" id="password" class="form-control">
                            </div>
                            <div class="form-group d-flex justify-content-between align-items-center">
                                <a href="#" id="register-link" class="text-info">Registrarse</a>
                                <input type="submit" name="submit" class="btn btn-custom btn-md" value="INGRESAR">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
