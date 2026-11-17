<%@ page import="model.Producto" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    Producto p = (Producto) request.getAttribute("producto");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Detalle</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <div class="contenedor">
        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">
            <%
                request.setAttribute("tituloPagina", "Detalle del producto");
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="detalle-producto card border-0 shadow-sm p-3 p-md-4">
                <%
                    if (p != null) {
                %>
                    <h2><%= p.getNombre() %></h2>

                    <dl class="row g-2 mb-4">
                        <dt class="col-12 col-sm-4">Código</dt>
                        <dd class="col-12 col-sm-8"><%= p.getCodigo() %></dd>

                        <dt class="col-12 col-sm-4">Categoría</dt>
                        <dd class="col-12 col-sm-8"><%= p.getCategoria() %></dd>

                        <dt class="col-12 col-sm-4">Cantidad</dt>
                        <dd class="col-12 col-sm-8"><%= p.getCantidad() %></dd>

                        <dt class="col-12 col-sm-4">Vencimiento</dt>
                        <dd class="col-12 col-sm-8"><%= p.getFechaVencimiento() %></dd>
                    </dl>

                    <a class="btn btn-primary me-2 mb-2" href="${pageContext.request.contextPath}/ProductoServlet?accion=editar&id=<%= p.getIdProducto() %>"><i class="bi bi-pencil me-1"></i>Editar</a>
                <%
                    } else {
                %>
                    <p>Producto no encontrado.</p>
                <%
                    }
                %>

                <a class="btn btn-outline-secondary mb-2" href="${pageContext.request.contextPath}/ProductoServlet"><i class="bi bi-arrow-left me-1"></i>Volver</a>
            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
