<aside class="menu-lateral">
    <div class="logo-marca">
        <img class="img-fluid" src="${pageContext.request.contextPath}/img/marca-oceano.svg" alt="Logotipo Productos Perecibles">
        <div class="logo-texto">
            <strong>Productos Perecibles</strong>
            <span>Gestión inteligente de inventario</span>
        </div>
        <button class="menu-toggle" type="button" aria-label="Mostrar menú" aria-expanded="false" aria-controls="menu-principal">
            <i class="bi bi-list" aria-hidden="true"></i>
        </button>
    </div>

    <nav id="menu-principal" class="menu-navegacion" aria-label="Navegación principal">
        <span class="menu-seccion">MENÚ PRINCIPAL</span>
        <a class="menu-enlace" href="${pageContext.request.contextPath}/DashboardServlet">
            <i class="bi bi-grid-1x2-fill" aria-hidden="true"></i><span>Dashboard</span>
        </a>
        <a class="menu-enlace" href="${pageContext.request.contextPath}/ProductoServlet">
            <i class="bi bi-box-seam" aria-hidden="true"></i><span>Productos</span>
        </a>
        <a class="menu-enlace" href="${pageContext.request.contextPath}/MovimientoServlet">
            <i class="bi bi-arrow-left-right" aria-hidden="true"></i><span>Movimientos</span>
        </a>
        <a class="menu-enlace" href="${pageContext.request.contextPath}/VencimientoServlet">
            <i class="bi bi-calendar2-check" aria-hidden="true"></i><span>Vencimientos</span>
        </a>
        <a class="menu-enlace" href="${pageContext.request.contextPath}/UsuarioServlet">
            <i class="bi bi-people-fill" aria-hidden="true"></i><span>Usuarios</span>
        </a>
    </nav>

    <div class="menu-inferior">
        <div class="menu-estado">
            <span class="estado-punto"></span>
            <span>Sistema de inventario</span>
        </div>
        <a class="cerrar-sesion" href="${pageContext.request.contextPath}/logout">
            <i class="bi bi-box-arrow-right" aria-hidden="true"></i><span>Cerrar sesión</span>
        </a>
    </div>
</aside>