<%@ page import="java.util.List, model.Producto" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    List<Producto> proximos = (List<Producto>) request.getAttribute("proximos");
    List<Producto> vencidos = (List<Producto>) request.getAttribute("vencidos");
    Integer tp = (Integer) request.getAttribute("totalProximos");
    Integer tv = (Integer) request.getAttribute("totalVencidos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vencimientos</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <div class="contenedor">
        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">
            <%
                request.setAttribute("tituloPagina", "Control de vencimientos");
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <h2>Próximos a vencer: <%= tp == null ? 0 : tp %></h2>
            <table>
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Producto</th>
                        <th>Categoría</th>
                        <th>Cantidad</th>
                        <th>Vencimiento</th>
                        <th>Días restantes</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (proximos != null && !proximos.isEmpty()) {
                            for (Producto p : proximos) {
                    %>
                        <tr>
                            <td><%= p.getCodigo() %></td>
                            <td><%= p.getNombre() %></td>
                            <td><%= p.getCategoria() %></td>
                            <td><%= p.getCantidad() %></td>
                            <td><%= p.getFechaVencimiento() %></td>
                            <td><%= p.getDiasRestantes() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="6">No hay productos próximos a vencer.</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <h2>Productos vencidos: <%= tv == null ? 0 : tv %></h2>
            <table>
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Producto</th>
                        <th>Categoría</th>
                        <th>Cantidad</th>
                        <th>Vencimiento</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (vencidos != null && !vencidos.isEmpty()) {
                            for (Producto p : vencidos) {
                    %>
                        <tr>
                            <td><%= p.getCodigo() %></td>
                            <td><%= p.getNombre() %></td>
                            <td><%= p.getCategoria() %></td>
                            <td><%= p.getCantidad() %></td>
                            <td><%= p.getFechaVencimiento() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5">No hay productos vencidos.</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
