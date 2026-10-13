<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Iniciar sesión - Productos Perecibles</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>

<body>

    <main class="login-container">

        <section class="login-box">

            <h1>Productos Perecibles</h1>

            <h2>Iniciar sesión</h2>

            <p>Ingresa tus datos para continuar</p>

            <%
                String error = request.getParameter("error");

                if ("campos".equals(error)) {
            %>

                <div class="mensaje-error">
                    Completa todos los campos.
                </div>

            <%
                } else if ("credenciales".equals(error)) {
            %>

                <div class="mensaje-error">
                    Usuario o contraseña incorrectos.
                </div>

            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/login"
                  method="POST">

                <div class="campo">

                    <label for="identificador">
                        Usuario o correo electrónico
                    </label>

                    <input
                        type="text"
                        id="identificador"
                        name="identificador"
                        placeholder="Ingresa tu usuario o correo"
                        required>
                </div>

                <div class="campo">

                    <label for="contraseña">
                        Contraseña
                    </label>

                    <input
                        type="password"
                        id="contraseña"
                        name="contraseña"
                        placeholder="Ingresa tu contraseña"
                        required>
                </div>

                <button type="submit">
                    Iniciar sesión
                </button>

            </form>

        </section>

    </main>

</body>
</html>
