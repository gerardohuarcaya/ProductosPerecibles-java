<aside class="menu-lateral">
    <div class="logo-marca">
        <img src="${pageContext.request.contextPath}/img/marca-oceano.svg" alt="Logotipo Productos Perecibles">
        <div>
            <strong>Productos Perecibles</strong>
            <span>Gestión inteligente de inventario</span>
        </div>
    </div>

    <nav aria-label="Navegación principal">
        <a href="${pageContext.request.contextPath}/DashboardServlet">Dashboard</a>
        <a href="${pageContext.request.contextPath}/ProductoServlet">Productos</a>
        <a href="${pageContext.request.contextPath}/MovimientoServlet">Movimientos</a>
        <a href="${pageContext.request.contextPath}/VencimientoServlet">Vencimientos</a>
        <a href="${pageContext.request.contextPath}/UsuarioServlet">Usuarios</a>
    </nav>

    <div class="menu-inferior">
        <a class="cerrar-sesion" href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</aside>
