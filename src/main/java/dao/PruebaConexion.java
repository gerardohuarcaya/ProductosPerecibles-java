
package dao;
import java.sql.Connection;

public class PruebaConexion {
    public static void main(String[] args) {
        Connection conexion = Conexion.obtenerConexion();
        
        if(conexion != null) {
            System.out.println("PRUEBA EXITOSA: Java está conectado a MySQL.");
        } else {
            System.out.println("PRUEBA FALLIDA: No se pudo conectar a MySQL");
        }
    }   
}
