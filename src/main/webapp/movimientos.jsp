
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movimientos | Productos Perecibles</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
    <div class="contenedor">

        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">

            <%
                request.setAttribute("tituloPagina", "Movimientos");
            %>

            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="seccion-movimientos">

                <div class="acciones-pagina">
                    <form action="${pageContext.request.contextPath}/movimientos.jsp"
                          method="get">

                        <label for="tipo">Filtrar por tipo:</label>

                        <select id="tipo" name="tipo">
                            <option value="">Todos los movimientos</option>
                            <option value="ENTRADA">Entradas</option>
                            <option value="SALIDA">Salidas</option>
                        </select>

                        <button type="submit">Filtrar</button>
                    </form>
                </div>

                <div class="tabla-contenedor">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Producto</th>
                                <th>Tipo de movimiento</th>
                                <th>Cantidad</th>
                                <th>Fecha</th>
                                <th>Usuario responsable</th>
                                <th>Observación</th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td colspan="7">
                                    Los movimientos aparecerán aquí
                                    cuando conectemos la página con Java y MySQL.
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

