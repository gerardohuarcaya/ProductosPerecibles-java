package controller;

import dao.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Dashboard;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Dashboard dashboard;
        if (SesionInvitado.esInvitado(request) || request.getSession(false) == null
                || request.getSession(false).getAttribute("usuario") == null) {
            SesionInvitado.obtener(request);
            dashboard = SesionInvitado.obtenerDatosDemo(request).obtenerDashboard();
            request.setAttribute("modoDemo", Boolean.TRUE);
        } else {
            dashboard = new DashboardDAO().obtenerResumen();
        }
        request.setAttribute("dashboard", dashboard);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}