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

            <section class="seccion-movimientos">
                <h2>Registrar entrada o salida</h2>

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

                <form action="${pageContext.request.contextPath}/MovimientoServlet" method="post">
                    <label for="id_producto">Producto</label>
                    <select id="id_producto" name="id_producto" required>
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

                    <label for="tipo">Tipo</label>
                    <select id="tipo" name="tipo" required>
                        <option value="ENTRADA">Entrada</option>
                        <option value="SALIDA">Salida</option>
                    </select>

                    <label for="cantidad">Cantidad</label>
                    <input type="number" id="cantidad" name="cantidad" min="1" required>

                    <label for="observacion">Observación</label>
                    <input type="text" id="observacion" name="observacion" maxlength="255">

                    <button type="submit">Registrar movimiento</button>
                </form>

                <h2>Historial</h2>

                <form action="${pageContext.request.contextPath}/MovimientoServlet" method="get">
                    <label for="filtro">Filtrar</label>
                    <select id="filtro" name="tipo">
                        <option value="">Todos</option>
                        <option value="ENTRADA" <%= "ENTRADA".equals(tipo) ? "selected" : "" %>>Entrada</option>
                        <option value="SALIDA" <%= "SALIDA".equals(tipo) ? "selected" : "" %>>Salida</option>
                    </select>
                    <button type="submit">Filtrar</button>
                </form>

                <table>
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
                </table>
            </section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
