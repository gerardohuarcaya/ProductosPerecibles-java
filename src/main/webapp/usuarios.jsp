<%@ page import="java.util.List, model.Usuario" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    List<Usuario> lista = (List<Usuario>) request.getAttribute("usuarios");
    String buscar = request.getParameter("buscar");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Usuarios</title>
    <%@ include file="/WEB-INF/vistas/recursos.jsp" %>
</head>
<body>
    <div class="contenedor">
        <%@ include file="/WEB-INF/vistas/sidebar.jsp" %>

        <main class="contenido-principal">
            <%
                request.setAttribute("tituloPagina", "Gestión de usuarios");
            %>
            <%@ include file="/WEB-INF/vistas/header.jsp" %>

            <section class="card border-0 shadow-sm p-3 p-md-4"><form class="row g-3 align-items-end mb-3" action="${pageContext.request.contextPath}/UsuarioServlet" method="get">
                <label class="form-label col-12 col-md-auto mb-0" for="buscar">Buscar usuario</label>
                <input
                    class="form-control col"
                    id="buscar"
                    name="buscar"
                    value="<%= buscar == null ? "" : buscar %>"
                    placeholder="Nombre o correo">
                <button class="btn btn-primary col-12 col-md-auto" type="submit"><i class="bi bi-search me-1"></i>Buscar</button>
            </form>

            <div class="table-responsive tabla-contenedor"><table class="table table-hover align-middle mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Usuario</th>
                        <th>Correo</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (lista != null && !lista.isEmpty()) {
                            for (Usuario u : lista) {
                    %>
                        <tr>
                            <td><%= u.getIdUsuario() %></td>
                            <td><%= u.getNombre() %></td>
                            <td><%= u.getUsuario() %></td>
                            <td><%= u.getCorreo() %></td>
                            <td><%= u.getEstado() == 1 ? "Activo" : "Inactivo" %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5">No hay usuarios registrados.</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table></div></section>

            <%@ include file="/WEB-INF/vistas/footer.jsp" %>
        </main>
    </div>
</body>
</html>
