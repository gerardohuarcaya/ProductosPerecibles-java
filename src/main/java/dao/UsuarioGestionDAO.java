
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Usuario;

public class UsuarioGestionDAO {

    public List<Usuario> listar(String buscar) {

        List<Usuario> lista = new ArrayList<>();

        String sql = "SELECT id_usuario, nombre, usuario, correo, estado, rol "
                + "FROM usuario "
                + "WHERE (? IS NULL OR nombre LIKE ? OR usuario LIKE ? OR correo LIKE ?) "
                + "ORDER BY nombre";

        try (Connection con = Conexion.obtenerConexion()) {

            if (con == null) {
                return lista;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                String filtro = (buscar == null || buscar.trim().isEmpty())
                        ? null : "%" + buscar.trim() + "%";

                ps.setString(1, filtro);
                ps.setString(2, filtro);
                ps.setString(3, filtro);
                ps.setString(4, filtro);

                try (ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {

                        Usuario u = new Usuario();

                        u.setIdUsuario(rs.getInt("id_usuario"));
                        u.setNombre(rs.getString("nombre"));
                        u.setUsuario(rs.getString("usuario"));
                        u.setCorreo(rs.getString("correo"));
                        u.setEstado(rs.getInt("estado"));
                        u.setRol(rs.getString("rol"));

                        lista.add(u);
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al listar usuarios: " + e.getMessage());
        }

        return lista;
    }
}
