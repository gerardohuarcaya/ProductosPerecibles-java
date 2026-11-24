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
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Si no existe una sesión autenticada, se crea una sesión temporal invitada.
        SesionInvitado.obtener(request);

        System.out.println("========== DASHBOARD SERVLET EJECUTADO ==========");

        DashboardDAO dashboardDAO = new DashboardDAO();
        Dashboard dashboard = dashboardDAO.obtenerResumen();
        request.setAttribute("dashboard", dashboard);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
