
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar producto | Productos Perecibles</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

    <div class="contenedor">

        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">

            <%
                request.setAttribute("tituloPagina", "Registrar producto");
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="seccion-formulario">

                <h2>Datos del producto</h2>

                <form action="#" method="post">

                    <div class="campo-formulario">
                        <label for="codigo">Código del producto</label>
                        <input type="text"
                               id="codigo"
                               name="codigo"
                               placeholder="Ingresa el código"
                               required>
                    </div>

                    <div class="campo-formulario">
                        <label for="nombre">Nombre del producto</label>
                        <input type="text"
                               id="nombre"
                               name="nombre"
                               placeholder="Ingresa el nombre"
                               required>
                    </div>

                    <div class="campo-formulario">
                        <label for="categoria">Categoría</label>
                        <input type="text"
                               id="categoria"
                               name="categoria"
                               placeholder="Ejemplo: lácteos o frutas"
                               required>
                    </div>

                    <div class="campo-formulario">
                        <label for="cantidad">Cantidad disponible</label>
                        <input type="number"
                               id="cantidad"
                               name="cantidad"
                               min="0"
                               required>
                    </div>

                    <div class="campo-formulario">
                        <label for="fecha_vencimiento">
                            Fecha de vencimiento
                        </label>
                        <input type="date"
                               id="fecha_vencimiento"
                               name="fecha_vencimiento"
                               required>
                    </div>

                    <div class="acciones-formulario">
                        <button type="submit">Guardar producto</button>

                        <a href="${pageContext.request.contextPath}/productos.jsp">
                            Cancelar
                        </a>
                    </div>

                </form>

            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>

        </main>

    </div>

</body>
</html>
