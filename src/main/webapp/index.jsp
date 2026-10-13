<%@page import="model.Dashboard"%>

<%
    Dashboard dashboard = (Dashboard) request.getAttribute("dashboard");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard - Productos Perecibles</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/estilos.css">
</head>

<body>

    <div class="contenedor">

        <aside class="menu-lateral">

            <div class="logo">
                <h2>Productos<br>Perecibles</h2>
            </div>

            <nav>

                <a href="<%= request.getContextPath() %>/DashboardServlet"
                   class="menu-item activo">
                    Dashboard
                </a>

                <a href="#" class="menu-item">
                    Productos
                </a>

                <a href="#" class="menu-item">
                    Movimientos
                </a>

                <a href="#" class="menu-item">
                    Vencimientos
                </a>

                <a href="#" class="menu-item">
                    Usuarios
                </a>

            </nav>

            <div class="menu-inferior">

                <a href="<%= request.getContextPath() %>/LogoutServlet"
                   class="menu-item cerrar-sesion">
                    Cerrar sesión
                </a>

            </div>

        </aside>


        <main class="contenido">

            <header class="encabezado">

                <div>
                    <h1>Dashboard</h1>
                    <p>Resumen de la gestión de productos perecibles</p>
                </div>

            </header>


            <section class="tarjetas">

                <div class="tarjeta">

                    <div class="tarjeta-icono">
                        ?
                    </div>

                    <div>
                        <p>Total de productos</p>

                        <h2>
                            <%= dashboard != null
                                    ? dashboard.getTotalProductos()
                                    : 0 %>
                        </h2>
                    </div>

                </div>


                <div class="tarjeta">

                    <div class="tarjeta-icono">
                        ?
                    </div>

                    <div>
                        <p>Productos disponibles</p>

                        <h2>
                            <%= dashboard != null
                                    ? dashboard.getProductosDisponibles()
                                    : 0 %>
                        </h2>
                    </div>

                </div>


                <div class="tarjeta">

                    <div class="tarjeta-icono">
                        ?
                    </div>

                    <div>
                        <p>Próximos a vencer</p>

                        <h2>
                            <%= dashboard != null
                                    ? dashboard.getProductosProximosVencer()
                                    : 0 %>
                        </h2>
                    </div>

                </div>


                <div class="tarjeta">

                    <div class="tarjeta-icono">
                        !
                    </div>

                    <div>
                        <p>Productos vencidos</p>

                        <h2>
                            <%= dashboard != null
                                    ? dashboard.getProductosVencidos()
                                    : 0 %>
                        </h2>
                    </div>

                </div>

            </section>


            <section class="panel-vacio">

                <h2>Gestión de productos perecibles</h2>

                <p>
                    Desde este Dashboard podrás consultar el estado
                    general de los productos registrados.
                </p>

            </section>

        </main>

    </div>

</body>
</html>
