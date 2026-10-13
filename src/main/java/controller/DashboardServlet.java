package controller;

import dao.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Dashboard;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }
        
        System.out.println("========== DASHBOARD SERVLET EJECUTADO ==========");
        
        DashboardDAO dashboardDAO = new DashboardDAO();

        Dashboard dashboard = dashboardDAO.obtenerResumen();

        request.setAttribute("dashboard", dashboard);

        request.getRequestDispatcher("index.jsp")
                .forward(request, response);
    }
}