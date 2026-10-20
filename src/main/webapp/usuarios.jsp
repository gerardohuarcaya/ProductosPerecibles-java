
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Usuarios | Productos Perecibles</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
    <div class="contenedor">

        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">

            <%
                request.setAttribute("tituloPagina", "Gestión de usuarios");
            %>

            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="seccion-usuarios">

                <div class="acciones-pagina">
                    <form action="${pageContext.request.contextPath}/usuarios.jsp"
                          method="get">

                        <label for="buscar">Buscar usuario:</label>

                        <input type="search"
                               id="buscar"
                               name="buscar"
                               placeholder="Nombre o correo electrónico">

                        <button type="submit">Buscar</button>
                    </form>

                    <a href="#">Registrar usuario</a>
                </div>

                <div class="tabla-contenedor">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>Nombre de usuario</th>
                                <th>Correo electrónico</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td colspan="6">
                                    Los usuarios aparecerán aquí cuando
                                    conectemos esta página con Java y MySQL.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>

        </main>
    </div>
</body>
</html>

