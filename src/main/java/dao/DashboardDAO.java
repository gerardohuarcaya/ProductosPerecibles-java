package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Dashboard;

public class DashboardDAO {

    public Dashboard obtenerResumen() {

        Dashboard dashboard = new Dashboard();

        String sqlTotal = "SELECT COUNT(*) FROM producto";

        String sqlDisponibles
                = "SELECT COUNT(*) FROM producto WHERE cantidad > 0";

        String sqlProximosVencer
                = "SELECT COUNT(*) FROM producto "
                + "WHERE fecha_vencimiento >= CURDATE() "
                + "AND fecha_vencimiento <= DATE_ADD(CURDATE(), INTERVAL 7 DAY)";

        String sqlVencidos
                = "SELECT COUNT(*) FROM producto "
                + "WHERE fecha_vencimiento < CURDATE()";

        try (Connection conexion = Conexion.obtenerConexion()) {

            try (PreparedStatement ps
                    = conexion.prepareStatement(sqlTotal); ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    dashboard.setTotalProductos(rs.getInt(1));
                }
            }

            try (PreparedStatement ps
                    = conexion.prepareStatement(sqlDisponibles); ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    dashboard.setProductosDisponibles(rs.getInt(1));
                }
            }

            try (PreparedStatement ps
                    = conexion.prepareStatement(sqlProximosVencer); ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    dashboard.setProductosProximosVencer(rs.getInt(1));
                }
            }

            try (PreparedStatement ps
                    = conexion.prepareStatement(sqlVencidos); ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    dashboard.setProductosVencidos(rs.getInt(1));
                }
            }

        } catch (SQLException e) {
            System.out.println(
                    "Error al obtener datos del Dashboard: "
                    + e.getMessage()
            );
        }

        return dashboard;
    }
}
