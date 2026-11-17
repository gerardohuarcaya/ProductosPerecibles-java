
package dao;

import model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

public class UsuarioDAO {

    public Usuario validarUsuario(String identificador, String contraseña) {

        Usuario usuario = null;

        String sql = "SELECT id_usuario, nombre, usuario, correo, "
                + "contraseña, estado, rol "
                + "FROM usuario "
                + "WHERE (usuario = ? OR correo = ?) "
                + "AND estado = 1";

        try (Connection conexion = Conexion.obtenerConexion()) {

            if (conexion == null) {
                System.out.println("No hay conexión con MySQL.");
                return null;
            }

            try (PreparedStatement sentencia = conexion.prepareStatement(sql)) {

                sentencia.setString(1, identificador);
                sentencia.setString(2, identificador);

                try (ResultSet resultado = sentencia.executeQuery()) {

                    if (resultado.next()) {

                        String hash = resultado.getString("contraseña");

                        if (hash != null && BCrypt.checkpw(contraseña, hash)) {

                            usuario = new Usuario();

                            usuario.setIdUsuario(resultado.getInt("id_usuario"));
                            usuario.setNombre(resultado.getString("nombre"));
                            usuario.setUsuario(resultado.getString("usuario"));
                            usuario.setCorreo(resultado.getString("correo"));
                            usuario.setContraseña(hash);
                            usuario.setEstado(resultado.getInt("estado"));
                            usuario.setRol(resultado.getString("rol"));
                        }
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al validar usuario: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            System.out.println("El hash de contraseña no es válido.");
        }

        return usuario;
    }
}
