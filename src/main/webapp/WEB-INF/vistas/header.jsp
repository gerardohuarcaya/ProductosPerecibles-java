<%
    String titulo = (String) request.getAttribute("tituloPagina");
    String imagenEncabezado = "https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=1900&q=85";

    if ("Productos".equals(titulo) || "Registrar producto".equals(titulo)
            || "Editar producto".equals(titulo) || "Detalle del producto".equals(titulo)) {
        imagenEncabezado = "https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=1900&q=85";
    } else if ("Movimientos".equals(titulo)) {
        imagenEncabezado = "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=1900&q=85";
    } else if ("Control de vencimientos".equals(titulo)) {
        imagenEncabezado = "https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=1900&q=85";
    } else if ("Gestión de usuarios".equals(titulo)) {
        imagenEncabezado = "https://images.unsplash.com/photo-1521737711867-e3b97375f902?auto=format&fit=crop&w=1900&q=85";
    }
%>
<% if (Boolean.TRUE.equals(session.getAttribute("modoInvitado"))) { %>
<div class="alert alert-warning mx-3 mt-3 mb-0" role="status">
    <strong>Modo invitado / demostración:</strong> estás usando datos de ejemplo guardados temporalmente en esta sesión. No se consulta ni modifica la base de datos en la nube.
</div>
<% } %>
<header class="encabezado" aria-label="Encabezado de Productos Perecibles">
    <img
        class="encabezado-imagen img-fluid w-100 h-100"
        src="<%= imagenEncabezado %>"
        alt=""
        aria-hidden="true"
        fetchpriority="high"
        decoding="async">
    <div class="encabezado-capa" aria-hidden="true"></div>

    <div class="encabezado-contenido">
        <div class="encabezado-marca">
            <img class="encabezado-logo img-fluid" src="${pageContext.request.contextPath}/img/marca-oceano.svg" alt="Logotipo Productos Perecibles" width="58" height="58">
            <div class="encabezado-texto">
                <span class="encabezado-etiqueta">
                    <i class="bi bi-grid-1x2-fill" aria-hidden="true"></i>
                    SISTEMA DE INVENTARIO
                </span>
                <h1><%= titulo == null ? "Productos Perecibles" : titulo %></h1>
                <p>Administra tus existencias y mantén el control de las fechas de vencimiento.</p>
            </div>
        </div>
        <span class="encabezado-sello">
            <i class="bi bi-check2-circle" aria-hidden="true"></i>
            Inventario organizado
        </span>
    </div>
</header>