<%
    String titulo = (String) request.getAttribute("tituloPagina");
    String imagenEncabezado = "https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=1800&q=85";

    if ("Productos".equals(titulo) || "Registrar producto".equals(titulo)
            || "Editar producto".equals(titulo) || "Detalle del producto".equals(titulo)) {
        imagenEncabezado = "https://images.unsplash.com/photo-1604719312566-8912e9c8a213?auto=format&fit=crop&w=1800&q=85";
    } else if ("Movimientos".equals(titulo)) {
        imagenEncabezado = "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=1800&q=85";
    } else if ("Control de vencimientos".equals(titulo)) {
        imagenEncabezado = "https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=1800&q=85";
    } else if ("Gestión de usuarios".equals(titulo)) {
        imagenEncabezado = "https://images.unsplash.com/photo-1521737711867-e3b97375f902?auto=format&fit=crop&w=1800&q=85";
    }
%>
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
            <div class="encabezado-texto">
                <span class="encabezado-etiqueta">
                    <i class="bi bi-leaf-fill" aria-hidden="true"></i>
                    CONTROL DE INVENTARIO
                </span>
                <h1><%= titulo == null ? "Productos Perecibles" : titulo %></h1>
                <p>Organiza tus productos, controla las existencias y anticipa los vencimientos.</p>
            </div>
        </div>
        <span class="encabezado-sello">
            <i class="bi bi-box-seam" aria-hidden="true"></i>
            Gestión inteligente
        </span>
    </div>
</header>