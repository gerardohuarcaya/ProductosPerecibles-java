<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect(request.getContextPath() + "/DashboardServlet");
        return;
    }
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear cuenta - Productos Perecibles</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <main class="login-container">
        <section class="login-box registro-box">
            <div class="login-marca">
                <img class="img-fluid" src="${pageContext.request.contextPath}/img/marca-oceano.svg" alt="Logotipo Productos Perecibles">
            </div>

            <h1>Productos Perecibles</h1>
            <h2><i class="bi bi-person-plus me-2"></i>Crear una cuenta</h2>
            <p>Completa tus datos para registrarte en el sistema.</p>

            <% if ("campos".equals(error)) { %>
                <div class="alert alert-warning py-2" role="alert">Completa todos los campos.</div>
            <% } else if ("formato".equals(error)) { %>
                <div class="alert alert-warning py-2" role="alert">Revisa tu nombre, correo y usuario. El usuario debe tener entre 4 y 30 caracteres y usar letras, números, punto, guion o guion bajo.</div>
            <% } else if ("contrasena".equals(error)) { %>
                <div class="alert alert-warning py-2" role="alert">La contraseña debe tener al menos 8 caracteres.</div>
            <% } else if ("coinciden".equals(error)) { %>
                <div class="alert alert-warning py-2" role="alert">Las contraseñas no coinciden.</div>
            <% } else if ("duplicado".equals(error)) { %>
                <div class="alert alert-danger py-2" role="alert">Ese nombre de usuario o correo ya está registrado.</div>
            <% } else if ("bd".equals(error)) { %>
                <div class="alert alert-danger py-2" role="alert">No se pudo completar el registro. Verifica la conexión y la configuración de la base de datos.</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/registro" method="POST" class="needs-validation" novalidate>
                <div class="campo">
                    <label for="nombre">Nombre completo</label>
                    <input class="form-control" type="text" id="nombre" name="nombre"
                           maxlength="100" autocomplete="name" placeholder="Ej. Gerardo Huarcaya" required>
                </div>

                <div class="campo">
                    <label for="usuario">Nombre de usuario</label>
                    <input class="form-control" type="text" id="usuario" name="usuario"
                           minlength="4" maxlength="30" pattern="[A-Za-z0-9._-]+"
                           autocomplete="username" placeholder="Ej. gerardo" required>
                    <small class="text-secondary">De 4 a 30 caracteres: letras, números, punto, guion o guion bajo.</small>
                </div>

                <div class="campo">
                    <label for="correo">Correo electrónico</label>
                    <input class="form-control" type="email" id="correo" name="correo"
                           maxlength="120" autocomplete="email" placeholder="nombre@correo.com" required>
                </div>

                <div class="campo">
                    <label for="contraseña">Contraseña</label>
                    <input class="form-control" type="password" id="contraseña" name="contraseña"
                           minlength="8" maxlength="72" autocomplete="new-password"
                           placeholder="Mínimo 8 caracteres" required>
                </div>

                <div class="campo">
                    <label for="confirmar">Confirmar contraseña</label>
                    <input class="form-control" type="password" id="confirmar" name="confirmar"
                           minlength="8" maxlength="72" autocomplete="new-password"
                           placeholder="Repite tu contraseña" required>
                </div>

                <button class="btn btn-primary w-100" type="submit">
                    <i class="bi bi-person-check me-1"></i>Crear cuenta
                </button>
            </form>

            <p class="text-center mt-4 mb-0">
                ¿Ya tienes una cuenta?
                <a class="enlace-registro" href="${pageContext.request.contextPath}/login.jsp">Inicia sesión</a>
            </p>
            <p class="nota-registro text-center mt-3 mb-0">
                <i class="bi bi-shield-lock me-1"></i>Tu contraseña se almacena de forma protegida.
            </p>
        </section>
    </main>

    <%@ include file="/WEB-INF/vistas/scripts.jsp" %>
</body>
</html>
