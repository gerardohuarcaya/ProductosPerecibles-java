package dao;

import model.Dashboard;

public class PruebaDashboard {

    public static void main(String[] args) {

        DashboardDAO dashboardDAO = new DashboardDAO();

        Dashboard dashboard = dashboardDAO.obtenerResumen();

        System.out.println("===== PRUEBA DASHBOARD =====");
        System.out.println("Total productos: "
                + dashboard.getTotalProductos());

        System.out.println("Productos disponibles: "
                + dashboard.getProductosDisponibles());

        System.out.println("Productos próximos a vencer: "
                + dashboard.getProductosProximosVencer());

        System.out.println("Productos vencidos: "
                + dashboard.getProductosVencidos());
    }
}
