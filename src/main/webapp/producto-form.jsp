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

            <section class="seccion-formulario card border-0 shadow-sm p-3 p-md-4">
                <h2>Datos del producto</h2>

                <form class="row g-3" action="${pageContext.request.contextPath}/ProductoServlet" method="post">
                    <input
                        type="hidden"
                        name="id_producto"
                        value="<%= editar ? p.getIdProducto() : "" %>">

                    <label class="form-label col-12 col-sm-4 col-form-label" for="codigo">Código</label>
                    <input
                        class="form-control col-12 col-sm-8"
                        id="codigo"
                        name="codigo"
                        value="<%= p.getCodigo() == null ? "" : p.getCodigo() %>"
                        required>

                    <label class="form-label col-12 col-sm-4 col-form-label" for="nombre">Nombre</label>
                    <input
                        class="form-control col-12 col-sm-8"
                        id="nombre"
                        name="nombre"
                        value="<%= p.getNombre() == null ? "" : p.getNombre() %>"
                        required>

                    <label class="form-label col-12 col-sm-4 col-form-label" for="categoria">Categoría</label>
                    <input
                        class="form-control col-12 col-sm-8"
                        id="categoria"
                        name="categoria"
                        value="<%= p.getCategoria() == null ? "" : p.getCategoria() %>"
                        required>

                    <label class="form-label col-12 col-sm-4 col-form-label" for="cantidad">Cantidad</label>
                    <input
                        type="number"
                        class="form-control col-12 col-sm-8"
                        id="cantidad"
                        name="cantidad"
                        min="0"
                        value="<%= p.getCantidad() %>"
                        required>

                    <label class="form-label col-12 col-sm-4 col-form-label" for="fecha_vencimiento">Fecha de vencimiento</label>
                    <input
                        type="date"
                        class="form-control col-12 col-sm-8"
                        id="fecha_vencimiento"
                        name="fecha_vencimiento"
                        value="<%= p.getFechaVencimiento() == null ? "" : p.getFechaVencimiento() %>"
                        required>

                    <div class="d-flex flex-wrap gap-2 mt-2"><button class="btn btn-primary" type="submit"><i class="bi bi-save me-1"></i>Guardar producto</button>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/ProductoServlet">Cancelar</a></div>
                </form>
            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
