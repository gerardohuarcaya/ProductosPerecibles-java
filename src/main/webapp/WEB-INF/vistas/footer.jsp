<footer class="pie-pagina">
    <div class="pie-contenido">
        <div class="pie-columna pie-identidad">
            <p>Una herramienta para organizar existencias y realizar un mejor seguimiento de las fechas de vencimiento.</p>
        </div>

        <div class="pie-columna">
            <h2>Accesos rápidos</h2>
            <a href="${pageContext.request.contextPath}/DashboardServlet">Panel principal</a>
            <a href="${pageContext.request.contextPath}/ProductoServlet">Gestión de productos</a>
            <a href="${pageContext.request.contextPath}/MovimientoServlet">Movimientos</a>
        </div>

        <div class="pie-columna">
            <h2>Control y seguimiento</h2>
            <a href="${pageContext.request.contextPath}/VencimientoServlet">Fechas de vencimiento</a>
            <a href="${pageContext.request.contextPath}/UsuarioServlet">Gestión de usuarios</a>
            <span class="pie-nota"><i class="bi bi-shield-check" aria-hidden="true"></i> Información organizada para tu gestión</span>
        </div>
    </div>

    <div class="pie-base">
        <span>© <span id="anio-actual">2026</span> Productos Perecibles</span>
        <span>Control de inventario · Seguimiento de vencimientos</span>
    </div>
</footer>
<%@ include file="/WEB-INF/vistas/scripts.jsp" %>