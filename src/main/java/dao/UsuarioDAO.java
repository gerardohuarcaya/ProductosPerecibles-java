package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

public class UsuarioDAO {

    public Usuario validarUsuario(String identificador, String contraseña) {
        model.Usuario usuario = null;

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
                            usuario = new model.Usuario();
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

    /**
     * Registra una cuenta activa. El rol no se recibe desde el formulario:
     * MySQL debe asignar el rol predeterminado definido en la tabla.
     *
     * @return "ok", "duplicado" o "error".
     */
    public String registrar(String nombre, String usuario, String correo, String contraseña) {
        String consulta = "SELECT id_usuario FROM usuario "
                + "WHERE usuario = ? OR correo = ? LIMIT 1";
        String insercion = "INSERT INTO usuario "
                + "(nombre, usuario, correo, contraseña, estado) "
                + "VALUES (?, ?, ?, ?, 1)";

        try (Connection conexion = Conexion.obtenerConexion()) {
            if (conexion == null) {
                return "error";
            }

            try (PreparedStatement buscar = conexion.prepareStatement(consulta)) {
                buscar.setString(1, usuario);
                buscar.setString(2, correo);

                try (ResultSet resultado = buscar.executeQuery()) {
                    if (resultado.next()) {
                        return "duplicado";
                    }
                }
            }

            String hash = BCrypt.hashpw(contraseña, BCrypt.gensalt(12));

            try (PreparedStatement insertar = conexion.prepareStatement(insercion)) {
                insertar.setString(1, nombre);
                insertar.setString(2, usuario);
                insertar.setString(3, correo);
                insertar.setString(4, hash);
                insertar.executeUpdate();
                return "ok";
            }
        } catch (SQLException e) {
            // También cubre una colisión detectada por índices UNIQUE en MySQL.
            if (e.getErrorCode() == 1062) {
                return "duplicado";
            }
            System.out.println("Error al registrar usuario: " + e.getMessage());
            return "error";
        }
    }
}
