<%@ page import="java.util.List, model.Producto" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
    String buscar = request.getParameter("buscar");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Productos</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <div class="contenedor">
        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">
            <%
                request.setAttribute("tituloPagina", "Productos");
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="seccion-productos card border-0 shadow-sm p-3 p-md-4">
                <form class="row g-3 align-items-end mb-3" action="${pageContext.request.contextPath}/ProductoServlet" method="get">
                    <label class="form-label col-12 col-md-auto mb-0" for="buscar">Buscar producto:</label>
                    <input
                        class="form-control flex-grow-1 col"
                        id="buscar"
                        name="buscar"
                        value="<%= buscar == null ? "" : buscar %>"
                        placeholder="Código, nombre o categoría">
                    <button class="btn btn-primary col-12 col-md-auto" type="submit"><i class="bi bi-search me-1"></i>Buscar</button>
                </form>

                <a
                    href="${pageContext.request.contextPath}/ProductoServlet?accion=nuevo"
                    class="btn btn-success btn-registrar text-decoration-none">
                    + Registrar producto
                </a>

                <div class="tabla-contenedor table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>Categoría</th>
                                <th>Cantidad</th>
                                <th>Vencimiento</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (productos != null && !productos.isEmpty()) {
                                    for (Producto p : productos) {
                            %>
                                <tr>
                                    <td><%= p.getCodigo() %></td>
                                    <td><%= p.getNombre() %></td>
                                    <td><%= p.getCategoria() %></td>
                                    <td><%= p.getCantidad() %></td>
                                    <td><%= p.getFechaVencimiento() %></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/ProductoServlet?accion=detalle&id=<%= p.getIdProducto() %>">Ver</a>
                                        |
                                        <a href="${pageContext.request.contextPath}/ProductoServlet?accion=editar&id=<%= p.getIdProducto() %>">Editar</a>
                                        |
                                        <a
                                            href="${pageContext.request.contextPath}/ProductoServlet?accion=eliminar&id=<%= p.getIdProducto() %>"
                                            onclick="return confirm('¿Eliminar?')">
                                            Eliminar
                                        </a>
                                    </td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="6">No hay productos registrados.</td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
