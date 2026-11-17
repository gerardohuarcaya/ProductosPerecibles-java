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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
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
                <%
                    if (p != null) {
                %>
                    <h2><%= p.getNombre() %></h2>

                    <dl>
                        <dt>Código</dt>
                        <dd><%= p.getCodigo() %></dd>

                        <dt>Categoría</dt>
                        <dd><%= p.getCategoria() %></dd>

                        <dt>Cantidad</dt>
                        <dd><%= p.getCantidad() %></dd>

                        <dt>Vencimiento</dt>
                        <dd><%= p.getFechaVencimiento() %></dd>
                    </dl>

                    <a href="${pageContext.request.contextPath}/ProductoServlet?accion=editar&id=<%= p.getIdProducto() %>">Editar</a>
                <%
                    } else {
                %>
                    <p>Producto no encontrado.</p>
                <%
                    }
                %>

                <a href="${pageContext.request.contextPath}/ProductoServlet">Volver</a>
            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
