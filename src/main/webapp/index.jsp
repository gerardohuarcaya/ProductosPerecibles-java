<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Dashboard" %>
<%
    Dashboard dashboard = (Dashboard) request.getAttribute("dashboard");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard - Productos Perecibles</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <div class="contenedor">
        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">
            <% request.setAttribute("tituloPagina", "Dashboard"); %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="tarjetas">
                <div class="tarjeta">
                    <p>Total de productos</p>
                    <h2><%= dashboard == null ? 0 : dashboard.getTotalProductos() %></h2>
                </div>

                <div class="tarjeta">
                    <p>Productos disponibles</p>
                    <h2><%= dashboard == null ? 0 : dashboard.getProductosDisponibles() %></h2>
                </div>

                <div class="tarjeta">
                    <p>Próximos a vencer</p>
                    <h2><%= dashboard == null ? 0 : dashboard.getProductosProximosVencer() %></h2>
                </div>

                <div class="tarjeta">
                    <p>Productos vencidos</p>
                    <h2><%= dashboard == null ? 0 : dashboard.getProductosVencidos() %></h2>
                </div>
            </section>

            <section class="panel-vacio">
                <h2>Gestión de productos perecibles</h2>
                <p>Consulta y administra el inventario desde el menú.</p>
            </section>
        <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
