package controller;

import dao.UsuarioDAO;
import model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // MODO DE PRUEBA: permite entrar sin usuario ni contraseña.
        if ("invitado".equals(request.getParameter("modo"))) {
            HttpSession sesionAnterior = request.getSession(false);
            if (sesionAnterior != null) {
                sesionAnterior.invalidate();
            }
            SesionInvitado.obtener(request);
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
            return;
        }

        // MODO NORMAL: se conserva la autenticación original para reactivarla
        // o utilizarla cuando se quiera probar el acceso con una cuenta real.
        String identificador = request.getParameter("identificador");
        String contraseña = request.getParameter("contraseña");

        if (identificador == null || identificador.trim().isEmpty()
                || contraseña == null || contraseña.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=campos");
            return;
        }

        Usuario usuario = usuarioDAO.validarUsuario(identificador.trim(), contraseña);

        if (usuario != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);
            sesion.removeAttribute("modoInvitado");
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=credenciales");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
