
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vencimientos | Productos Perecibles</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
    <div class="contenedor">

        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">

            <%
                request.setAttribute("tituloPagina", "Control de vencimientos");
            %>

            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="seccion-vencimientos">

                <div class="resumen-vencimientos">
                    <div class="tarjeta-resumen">
                        <h2>Próximos a vencer</h2>
                        <p>La cantidad se mostrará al conectar con MySQL.</p>
                    </div>

                    <div class="tarjeta-resumen">
                        <h2>Productos vencidos</h2>
                        <p>La cantidad se mostrará al conectar con MySQL.</p>
                    </div>
                </div>

                <div class="tabla-contenedor">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Producto</th>
                                <th>Categoría</th>
                                <th>Cantidad</th>
                                <th>Fecha de vencimiento</th>
                                <th>Días restantes</th>
                                <th>Estado</th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td colspan="7">
                                    Los productos próximos a vencer y vencidos
                                    aparecerán aquí cuando conectemos la página
                                    con Java y MySQL.
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

