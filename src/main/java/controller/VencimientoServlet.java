package controller;

import dao.ProductoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/VencimientoServlet")
public class VencimientoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (SesionInvitado.esInvitado(request)) {
            DemoDataStore demo = SesionInvitado.obtenerDatosDemo(request);
            request.setAttribute("proximos", demo.listarVencimientos(false));
            request.setAttribute("vencidos", demo.listarVencimientos(true));
            request.setAttribute("totalProximos", demo.listarVencimientos(false).size());
            request.setAttribute("totalVencidos", demo.listarVencimientos(true).size());
            request.setAttribute("modoDemo", Boolean.TRUE);
        } else {
            ProductoDAO dao = new ProductoDAO();
            request.setAttribute("proximos", dao.listarVencimientos(false));
            request.setAttribute("vencidos", dao.listarVencimientos(true));
            request.setAttribute("totalProximos", dao.contarVencimientos(false));
            request.setAttribute("totalVencidos", dao.contarVencimientos(true));
        }
        request.getRequestDispatcher("/vencimientos.jsp").forward(request, response);
    }
}