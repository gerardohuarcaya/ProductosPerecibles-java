package controller;

import dao.MovimientoDAO;
import dao.ProductoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;

@WebServlet("/MovimientoServlet")
public class MovimientoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (SesionInvitado.esInvitado(request)) {
            DemoDataStore demo = SesionInvitado.obtenerDatosDemo(request);
            request.setAttribute("movimientos", demo.listarMovimientos(request.getParameter("tipo")));
            request.setAttribute("productos", demo.listarProductos(null));
            request.setAttribute("modoDemo", Boolean.TRUE);
        } else {
            request.setAttribute("movimientos", new MovimientoDAO().listar(request.getParameter("tipo")));
            request.setAttribute("productos", new ProductoDAO().listar(null));
        }
        request.getRequestDispatcher("/movimientos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id_producto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            String tipo = request.getParameter("tipo");
            String observacion = request.getParameter("observacion");
            boolean ok;
            if (SesionInvitado.esInvitado(request)) {
                ok = SesionInvitado.obtenerDatosDemo(request).registrarMovimiento(id, tipo, cantidad, observacion);
            } else {
                Usuario usuario = (Usuario) request.getSession(false).getAttribute("usuario");
                ok = new MovimientoDAO().registrar(id, usuario.getIdUsuario(), tipo, cantidad, observacion);
            }
            response.sendRedirect(request.getContextPath() + "/MovimientoServlet?resultado=" + (ok ? "ok" : "error"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/MovimientoServlet?resultado=error");
        }
    }
}