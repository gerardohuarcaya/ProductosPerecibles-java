<%@ page import="model.Producto" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    Producto p = (Producto) request.getAttribute("producto");

    if (p == null) {
        p = new Producto();
    }

    boolean editar = p.getIdProducto() > 0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Producto</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <div class="contenedor">
        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">
            <%
                request.setAttribute(
                    "tituloPagina",
                    editar ? "Editar producto" : "Registrar producto"
                );
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="seccion-formulario">
                <h2>Datos del producto</h2>

                <form action="${pageContext.request.contextPath}/ProductoServlet" method="post">
                    <input
                        type="hidden"
                        name="id_producto"
                        value="<%= editar ? p.getIdProducto() : "" %>">

                    <label for="codigo">Código</label>
                    <input
                        id="codigo"
                        name="codigo"
                        value="<%= p.getCodigo() == null ? "" : p.getCodigo() %>"
                        required>

                    <label for="nombre">Nombre</label>
                    <input
                        id="nombre"
                        name="nombre"
                        value="<%= p.getNombre() == null ? "" : p.getNombre() %>"
                        required>

                    <label for="categoria">Categoría</label>
                    <input
                        id="categoria"
                        name="categoria"
                        value="<%= p.getCategoria() == null ? "" : p.getCategoria() %>"
                        required>

                    <label for="cantidad">Cantidad</label>
                    <input
                        type="number"
                        id="cantidad"
                        name="cantidad"
                        min="0"
                        value="<%= p.getCantidad() %>"
                        required>

                    <label for="fecha_vencimiento">Fecha de vencimiento</label>
                    <input
                        type="date"
                        id="fecha_vencimiento"
                        name="fecha_vencimiento"
                        value="<%= p.getFechaVencimiento() == null ? "" : p.getFechaVencimiento() %>"
                        required>

                    <button type="submit">Guardar producto</button>
                    <a href="${pageContext.request.contextPath}/ProductoServlet">Cancelar</a>
                </form>
            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
