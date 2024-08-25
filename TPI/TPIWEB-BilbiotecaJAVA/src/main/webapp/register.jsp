<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Registro</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/CSS/general.css">
    <style>
        .text-center {
            text-align: center;
        }

        .form-outline input {
            height: calc(2.25rem + 2px);
        }

        .btn-custom {
            background-color: #e08b72;
            color: white;
            height: calc(2.25rem + 2px);
        }

        .btn-custom:hover {
            background-color: #d76a55;
        }

        .error-message {
            color: red;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container py-5 h-100">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col-12 col-lg-9 col-xl-7">
                <div class="card shadow-2-strong card-registration" style="border-width: 2px; border-color: #e08b72;">
                    <div class="card-body p-4 p-md-5">
                        <h3 class="mb-4 pb-2 pb-md-0 mb-md-5 text-center" style="color:#e08b72;">Registrarse</h3>
                        <form id="register-link" class="form" action="<%=request.getContextPath()%>/register" method="post" onsubmit="return validatePasswords()">
    
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <div class="form-outline">
                                        <input type="text" id="firstName" name="firstName" class="form-control form-control-lg" required />
                                        <label class="form-label" for="firstName" style="color: #e08b72;">Nombre</label>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <div class="form-outline">
                                        <input type="text" id="lastName" name="lastName" class="form-control form-control-lg" required />
                                        <label class="form-label" for="lastName" style="color: #e08b72;">Apellido</label>
                                    </div>
                                </div>
                            </div>
    
                            <div class="row">
                                <div class="col-md-12 mb-4 pb-2">
                                    <div class="form-outline">
                                        <input type="email" id="emailAddress" name="emailAddress" class="form-control form-control-lg" required />
                                        <label class="form-label" for="emailAddress" style="color:#e08b72;">Email</label>
                                    </div>
                                </div>
                            </div>
                
                            <div class="row">
                                <div class="col-md-12 mb-4 pb-2">
                                    <div class="form-outline">
                                        <input type="text" id="dni" name="dni" class="form-control form-control-lg" required />
                                        <label class="form-label" for="dni" style="color:#e08b72;">Documento Nacional de Identidad</label>
                                    </div>
                                </div>
                            </div>
    
                            <div class="row">
                                <div class="col-md-6 mb-4 pb-2">
                                    <div class="form-outline">
                                        <input type="password" id="form3Example4c" name="form3Example4c" class="form-control form-control-lg" required />
                                        <label class="form-label" for="form3Example4c" style="color: #e08b72;">Contraseña</label>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-4 pb-2">
                                    <div class="form-outline">
                                        <input type="password" id="form3Example4cd" name="form3Example4cd" class="form-control form-control-lg" required />
                                        <label class="form-label" for="form3Example4cd" style="color: #e08b72;">Repita la Contraseña</label>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <p id="error-message" class="error-message">Las contraseñas no coinciden.</p>
                                </div>
                            </div>
    
                            <div class="mt-4 pt-2">
                                <input class="btn btn-custom btn-block btn-md" type="submit" value="REGISTRARSE" />
                            </div>
    
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function validatePasswords() {
            var password = document.getElementById("form3Example4c").value;
            var confirmPassword = document.getElementById("form3Example4cd").value;
            var errorMessage = document.getElementById("error-message");

            if (password !== confirmPassword) {
                errorMessage.style.display = "block";  // Muestra el mensaje de error
                return false;  // Previene el envío del formulario
            } else {
                errorMessage.style.display = "none";  // Oculta el mensaje de error
                return true;  // Permite el envío del formulario
            }
        }
    </script>
</body>
</html>


