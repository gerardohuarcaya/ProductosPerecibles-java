package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Movimiento;

public class MovimientoDAO {
    public List<Movimiento> listar(String tipo) {
        List<Movimiento> lista=new ArrayList<>();
        String sql="SELECT m.id_movimiento,m.id_producto,m.id_usuario,m.tipo,m.cantidad,m.fecha,m.observacion,p.codigo,p.nombre AS nombre_producto,u.nombre AS nombre_usuario FROM movimiento m INNER JOIN producto p ON m.id_producto=p.id_producto INNER JOIN usuario u ON m.id_usuario=u.id_usuario WHERE (? IS NULL OR m.tipo=?) ORDER BY m.fecha DESC";
        try(Connection con=Conexion.obtenerConexion()) {
            if(con==null) return lista;
            try(PreparedStatement ps=con.prepareStatement(sql)) {
                String filtro=(tipo==null||tipo.trim().isEmpty())?null:tipo;
                ps.setString(1,filtro); ps.setString(2,filtro);
                try(ResultSet rs=ps.executeQuery()) { while(rs.next()) {
                    Movimiento m=new Movimiento(); m.setIdMovimiento(rs.getInt("id_movimiento"));
                    m.setIdProducto(rs.getInt("id_producto")); m.setIdUsuario(rs.getInt("id_usuario"));
                    m.setTipo(rs.getString("tipo")); m.setCantidad(rs.getInt("cantidad")); m.setFecha(rs.getTimestamp("fecha"));
                    m.setObservacion(rs.getString("observacion")); m.setCodigo(rs.getString("codigo"));
                    m.setNombreProducto(rs.getString("nombre_producto")); m.setNombreUsuario(rs.getString("nombre_usuario")); lista.add(m);
                }}
            }
        } catch(SQLException e) { System.out.println("Error al listar movimientos: "+e.getMessage()); }
        return lista;
    }
}