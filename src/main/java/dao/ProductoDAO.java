package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Producto;

public class ProductoDAO {
    private Producto mapear(ResultSet rs) throws SQLException {
        Producto p = new Producto();
        p.setIdProducto(rs.getInt("id_producto"));
        p.setCodigo(rs.getString("codigo"));
        p.setNombre(rs.getString("nombre"));
        p.setCategoria(rs.getString("categoria"));
        p.setCantidad(rs.getInt("cantidad"));
        p.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
        try { p.setDiasRestantes(rs.getInt("dias_restantes")); } catch (SQLException e) { /* consulta sin cálculo */ }
        return p;
    }

    public List<Producto> listar(String buscar) {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto WHERE (? IS NULL OR codigo LIKE ? OR nombre LIKE ? OR categoria LIKE ?) ORDER BY nombre";
        try (Connection con = Conexion.obtenerConexion()) {
            if (con == null) return lista;
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                String filtro = (buscar == null || buscar.trim().isEmpty()) ? null : "%" + buscar.trim() + "%";
                ps.setString(1, filtro); ps.setString(2, filtro); ps.setString(3, filtro); ps.setString(4, filtro);
                try (ResultSet rs = ps.executeQuery()) { while (rs.next()) lista.add(mapear(rs)); }
            }
        } catch (SQLException e) { System.out.println("Error al listar productos: " + e.getMessage()); }
        return lista;
    }

    public Producto obtener(int id) {
        String sql = "SELECT * FROM producto WHERE id_producto = ?";
        try (Connection con = Conexion.obtenerConexion()) {
            if (con == null) return null;
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return mapear(rs); }
            }
        } catch (SQLException e) { System.out.println("Error al consultar producto: " + e.getMessage()); }
        return null;
    }

    public boolean guardar(Producto p) {
        String sql = "INSERT INTO producto (codigo,nombre,categoria,cantidad,fecha_vencimiento) VALUES (?,?,?,?,?)";
        try (Connection con = Conexion.obtenerConexion()) {
            if (con == null) return false;
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1,p.getCodigo()); ps.setString(2,p.getNombre()); ps.setString(3,p.getCategoria());
                ps.setInt(4,p.getCantidad()); ps.setDate(5,p.getFechaVencimiento());
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) { System.out.println("Error al guardar producto: " + e.getMessage()); return false; }
    }

    public boolean actualizar(Producto p) {
        String sql = "UPDATE producto SET codigo=?, nombre=?, categoria=?, cantidad=?, fecha_vencimiento=? WHERE id_producto=?";
        try (Connection con = Conexion.obtenerConexion()) {
            if (con == null) return false;
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1,p.getCodigo()); ps.setString(2,p.getNombre()); ps.setString(3,p.getCategoria());
                ps.setInt(4,p.getCantidad()); ps.setDate(5,p.getFechaVencimiento()); ps.setInt(6,p.getIdProducto());
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) { System.out.println("Error al actualizar producto: " + e.getMessage()); return false; }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM producto WHERE id_producto=?";
        try (Connection con = Conexion.obtenerConexion()) {
            if (con == null) return false;
            try (PreparedStatement ps = con.prepareStatement(sql)) { ps.setInt(1,id); return ps.executeUpdate() > 0; }
        } catch (SQLException e) { System.out.println("No se pudo eliminar el producto (puede tener movimientos): " + e.getMessage()); return false; }
    }

    public List<Producto> listarVencimientos(boolean vencidos) {
        List<Producto> lista = new ArrayList<>();
        String operador = vencidos ? "< CURDATE()" : "BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)";
        String sql = "SELECT producto.*, DATEDIFF(fecha_vencimiento,CURDATE()) AS dias_restantes FROM producto WHERE fecha_vencimiento " + operador + " ORDER BY fecha_vencimiento";
        try (Connection con = Conexion.obtenerConexion()) {
            if (con == null) return lista;
            try (PreparedStatement ps=con.prepareStatement(sql); ResultSet rs=ps.executeQuery()) {
                while(rs.next()) lista.add(mapear(rs));
            }
        } catch(SQLException e) { System.out.println("Error al consultar vencimientos: " + e.getMessage()); }
        return lista;
    }

    public int contarVencimientos(boolean vencidos) {
        String sql = vencidos ? "SELECT COUNT(*) FROM producto WHERE fecha_vencimiento < CURDATE()" :
            "SELECT COUNT(*) FROM producto WHERE fecha_vencimiento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)";
        try(Connection con=Conexion.obtenerConexion()) {
            if(con==null) return 0;
            try(PreparedStatement ps=con.prepareStatement(sql); ResultSet rs=ps.executeQuery()) { if(rs.next()) return rs.getInt(1); }
        } catch(SQLException e) { System.out.println("Error al contar vencimientos: " + e.getMessage()); }
        return 0;
    }
}