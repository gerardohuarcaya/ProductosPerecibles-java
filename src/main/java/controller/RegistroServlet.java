package controller;

import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class RegistroServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        // Una sesión invitada no debe impedir que el formulario de registro se abra.
        if (sesion != null && sesion.getAttribute("usuario") != null
                && !SesionInvitado.esInvitado(request)) {
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
            return;
        }
        request.getRequestDispatcher("/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String nombre = limpiar(request.getParameter("nombre"));
        String usuario = limpiar(request.getParameter("usuario"));
        String correo = limpiar(request.getParameter("correo")).toLowerCase();
        String contraseña = request.getParameter("contraseña");
        String confirmar = request.getParameter("confirmar");

        if (nombre.isEmpty() || usuario.isEmpty() || correo.isEmpty()
                || contraseña == null || confirmar == null
                || contraseña.isEmpty() || confirmar.isEmpty()) {
            volverConError(request, response, "campos");
            return;
        }

        if (nombre.length() > 100 || !usuario.matches("[A-Za-z0-9._-]{4,30}")
                || correo.length() > 120
                || !correo.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            volverConError(request, response, "formato");
            return;
        }

        if (contraseña.length() < 8
                || contraseña.getBytes(StandardCharsets.UTF_8).length > 72) {
            volverConError(request, response, "contrasena");
            return;
        }

        if (!contraseña.equals(confirmar)) {
            volverConError(request, response, "coinciden");
            return;
        }

        String resultado = usuarioDAO.registrar(nombre, usuario, correo, contraseña);

        if ("ok".equals(resultado)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?registro=ok");
        } else if ("duplicado".equals(resultado)) {
            volverConError(request, response, "duplicado");
        } else {
            volverConError(request, response, "bd");
        }
    }

    private String limpiar(String valor) {
        return valor == null ? "" : valor.trim();
    }

    private void volverConError(HttpServletRequest request, HttpServletResponse response,
            String codigo) throws IOException {
        response.sendRedirect(request.getContextPath() + "/registro.jsp?error=" + codigo);
    }
}
