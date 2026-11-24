package controller;

import dao.UsuarioGestionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (SesionInvitado.esInvitado(request)) {
            request.setAttribute("usuarios", SesionInvitado.obtenerDatosDemo(request).listarUsuarios());
            request.setAttribute("modoDemo", Boolean.TRUE);
        } else {
            request.setAttribute("usuarios", new UsuarioGestionDAO().listar(request.getParameter("buscar")));
        }
        request.getRequestDispatcher("/usuarios.jsp").forward(request, response);
    }
}