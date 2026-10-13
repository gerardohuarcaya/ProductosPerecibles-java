package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    private static final String URL =
            "jdbc:mysql://localhost:3306/productos_perecibles"
            + "?useSSL=false"
            + "&serverTimezone=UTC"
            + "&allowPublicKeyRetrieval=true";
    private static final String USUARIO = "root";
    
    private static final String CONTRASEÑA = "admin";
    
    public static Connection obtenerConexion() {
        Connection conexion = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            conexion = DriverManager.getConnection(
                    URL,
                    USUARIO,
                    CONTRASEÑA
            );
            
            System.out.println("Conexión a MySQL exitosa.");
           
        } catch (ClassNotFoundException e) {
            
            System.out.println(
                    "No se encontró el controlador JDBC de MySQL."
            );
        
        } catch (SQLException e) {
            System.out.println(
                    "Error al conectar con MySQL: "
                    + e.getMessage()
            );
        } 
        
        return conexion;
        
    }
}