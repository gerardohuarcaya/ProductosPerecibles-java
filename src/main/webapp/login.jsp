<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión - Productos Perecibles</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <main class="login-container">
        <section class="login-box">
            <div class="login-marca">
                <img class="img-fluid" src="${pageContext.request.contextPath}/img/marca-oceano.svg" alt="Logotipo Productos Perecibles">
            </div>
            <h1>Productos Perecibles</h1>
            <h2>Iniciar sesión</h2>
            <p>Ingresa tus datos para continuar</p>

            <%
                String error = request.getParameter("error");
                String registro = request.getParameter("registro");

                if ("ok".equals(registro)) {
            %>
                <div class="alert alert-success py-2" role="alert">
                    Tu cuenta se creó correctamente. Ya puedes iniciar sesión.
                </div>
            <%
                } else if ("campos".equals(error)) {
            %>
                <div class="mensaje-error">Completa todos los campos.</div>
            <%
                } else if ("credenciales".equals(error)) {
            %>
                <div class="mensaje-error">Usuario o contraseña incorrectos.</div>
            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="campo">
                    <label for="identificador">Usuario o correo electrónico</label>
                    <input class="form-control" type="text" id="identificador" name="identificador"
                           placeholder="Ingresa tu usuario o correo" autocomplete="username" required>
                </div>

                <div class="campo">
                    <label for="contraseña">Contraseña</label>
                    <input class="form-control" type="password" id="contraseña" name="contraseña"
                           placeholder="Ingresa tu contraseña" autocomplete="current-password" required>
                </div>

                <button class="btn btn-primary w-100" type="submit">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Iniciar sesión
                </button>
            </form>

            <div class="my-3 text-center">
                <span class="text-secondary">O si solo necesitas probar el sistema</span>
            </div>
            <form action="${pageContext.request.contextPath}/login" method="POST">
                <input type="hidden" name="modo" value="invitado">
                <button class="btn btn-outline-secondary w-100" type="submit">
                    <i class="bi bi-person-walking me-1"></i>Entrar como invitado
                </button>
            </form>

            <p class="text-center mt-4 mb-0">
                ¿No tienes una cuenta?
                <a class="enlace-registro" href="${pageContext.request.contextPath}/registro">Crear cuenta</a>
            </p>
        </section>
    </main>

    <%@ include file="/WEB-INF/vistas/scripts.jsp" %>
</body>
</html>
