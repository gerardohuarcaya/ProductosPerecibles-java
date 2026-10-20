
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos | Productos Perecibles</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

    <div class="contenedor">

        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">

            <%
                request.setAttribute("tituloPagina", "Productos");
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="seccion-productos">

                <div class="acciones-pagina">
                    <form action="${pageContext.request.contextPath}/productos.jsp"
                          method="get">

                        <label for="buscar">Buscar producto:</label>

                        <input type="search"
                               id="buscar"
                               name="buscar"
                               placeholder="Escribe el nombre del producto">

                        <button type="submit">Buscar</button>
                    </form>

                    <a href="${pageContext.request.contextPath}/producto-form.jsp">
                        Registrar producto
                    </a>
                </div>

                <div class="tabla-contenedor">

                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>Categoría</th>
                                <th>Cantidad</th>
                                <th>Fecha de vencimiento</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td colspan="7">
                                    Los productos aparecerán aquí cuando
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


