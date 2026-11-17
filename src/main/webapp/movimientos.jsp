<%@ page import="java.util.List, model.Movimiento, model.Producto" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    List<Movimiento> lista = (List<Movimiento>) request.getAttribute("movimientos");
    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
    String tipo = request.getParameter("tipo");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Movimientos</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <div class="contenedor">
        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">
            <%
                request.setAttribute("tituloPagina", "Movimientos");
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="seccion-movimientos card border-0 shadow-sm p-3 p-md-4">
                <h2 class="h5 mb-3">Registrar entrada o salida</h2>

                <%
                    if ("ok".equals(request.getParameter("resultado"))) {
                %>
                    <p>Movimiento registrado correctamente.</p>
                <%
                    } else if ("error".equals(request.getParameter("resultado"))) {
                %>
                    <p>No se pudo registrar. Comprueba el stock y los datos.</p>
                <%
                    }
                %>

                <form class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-3 align-items-end mb-4" action="${pageContext.request.contextPath}/MovimientoServlet" method="post">
                    <label class="form-label" for="id_producto">Producto</label>
                    <select class="form-select"
                        id="id_producto" name="id_producto" required>
                        <option value="">Selecciona</option>
                        <%
                            if (productos != null) {
                                for (Producto p : productos) {
                        %>
                            <option value="<%= p.getIdProducto() %>">
                                <%= p.getCodigo() %> - <%= p.getNombre() %> (Stock: <%= p.getCantidad() %>)
                            </option>
                        <%
                                }
                            }
                        %>
                    </select>

                    <label class="form-label" for="tipo">Tipo</label>
                    <select class="form-select"
                        id="tipo" name="tipo" required>
                        <option value="ENTRADA">Entrada</option>
                        <option value="SALIDA">Salida</option>
                    </select>

                    <label class="form-label" for="cantidad">Cantidad</label>
                    <input type="number" class="form-control"
                        id="cantidad" name="cantidad" min="1" required>

                    <label class="form-label" for="observacion">Observación</label>
                    <input type="text" class="form-control"
                        id="observacion" name="observacion" maxlength="255">

                    <div class="col-12"><button class="btn btn-primary" type="submit"><i class="bi bi-arrow-left-right me-1"></i>Registrar movimiento</button></div>
                </form>

                <h2 class="h5 mt-4 mb-3">Historial</h2>

                <form class="row g-2 align-items-end mb-3" action="${pageContext.request.contextPath}/MovimientoServlet" method="get">
                    <label class="form-label" for="filtro">Filtrar</label>
                    <select class="form-select"
                        id="filtro" name="tipo">
                        <option value="">Todos</option>
                        <option value="ENTRADA" <%= "ENTRADA".equals(tipo) ? "selected" : "" %>>Entrada</option>
                        <option value="SALIDA" <%= "SALIDA".equals(tipo) ? "selected" : "" %>>Salida</option>
                    </select>
                    <button class="btn btn-outline-primary col-12 col-md-auto" type="submit"><i class="bi bi-funnel me-1"></i>Filtrar</button>
                </form>

                <div class="table-responsive tabla-contenedor"><table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Producto</th>
                            <th>Tipo</th>
                            <th>Cantidad</th>
                            <th>Fecha</th>
                            <th>Usuario</th>
                            <th>Observación</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (lista != null && !lista.isEmpty()) {
                                for (Movimiento m : lista) {
                        %>
                            <tr>
                                <td><%= m.getCodigo() %></td>
                                <td><%= m.getNombreProducto() %></td>
                                <td><%= m.getTipo() %></td>
                                <td><%= m.getCantidad() %></td>
                                <td><%= m.getFecha() %></td>
                                <td><%= m.getNombreUsuario() %></td>
                                <td><%= m.getObservacion() == null ? "" : m.getObservacion() %></td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="7">No hay movimientos registrados.</td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table></div>
            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
