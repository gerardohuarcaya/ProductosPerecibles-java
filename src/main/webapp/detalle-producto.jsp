
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle del producto | Productos Perecibles</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

    <div class="contenedor">

        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">

            <%
                request.setAttribute("tituloPagina", "Detalle del producto");
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="detalle-producto">

                <h2>Información del producto</h2>

                <p>
                    Aquí se mostrará la información completa del producto
                    seleccionado.
                </p>

                <dl class="lista-detalles">

                    <dt>Código</dt>
                    <dd>Pendiente de conectar con la base de datos</dd>

                    <dt>Nombre</dt>
                    <dd>Pendiente de conectar con la base de datos</dd>

                    <dt>Categoría</dt>
                    <dd>Pendiente de conectar con la base de datos</dd>

                    <dt>Cantidad disponible</dt>
                    <dd>Pendiente de conectar con la base de datos</dd>

                    <dt>Fecha de vencimiento</dt>
                    <dd>Pendiente de conectar con la base de datos</dd>

                    <dt>Estado</dt>
                    <dd>Pendiente de calcular</dd>

                </dl>

                <div class="acciones-formulario">
                    <a href="${pageContext.request.contextPath}/productos.jsp">
                        Volver a productos
                    </a>

                    <a href="${pageContext.request.contextPath}/producto-form.jsp">
                        Ir al formulario
                    </a>
                </div>

            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>

        </main>

    </div>

</body>
</html>
