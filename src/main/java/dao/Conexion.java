package dao;

import java.sql.*;

public class Conexion {

    private static final String URL = configurarCodificacion(
            System.getenv().getOrDefault(
                    "DB_URL",
                    "jdbc:mysql://localhost:3306/productos_perecibles?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true"
            )
    );
    private static final String USUARIO = System.getenv().getOrDefault("DB_USER", "root");
    private static final String CONTRASENA = System.getenv().getOrDefault("DB_PASSWORD", "");

    private static String configurarCodificacion(String url) {
        if (url == null || url.trim().isEmpty()) {
            throw new IllegalStateException("La URL de conexión DB_URL está vacía.");
        }

        // Fuerza UTF-8 incluso si DB_URL ya tenía otra codificación configurada.
        String urlUTF8 = url.replaceAll("(?i)([?&]characterEncoding=)[^&]*", "$1UTF-8");
        if (!urlUTF8.equals(url)) {
            return urlUTF8;
        }

        String separador = url.contains("?") ? "&" : "?";
        return url + separador + "characterEncoding=UTF-8";
    }

    public static Connection obtenerConexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USUARIO, CONTRASENA);
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontró el controlador JDBC: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error al conectar con MySQL: " + e.getMessage());
        }
        return null;
    }

    public static boolean probarConexion() {
        try (Connection conexion = obtenerConexion()) {
            if (conexion != null && conexion.isValid(5)) {
                System.out.println("CONEXION EXITOSA A MYSQL");
                return true;
            }
        } catch (SQLException e) {
            System.out.println("ERROR EN LA PRUEBA: " + e.getMessage());
        }
        return false;
    }
}
