package dao;
import java.sql.*;
public class Conexion {
 private static final String URL=System.getenv().getOrDefault("DB_URL","jdbc:mysql://localhost:3306/productos_perecibles?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
 private static final String USUARIO=System.getenv().getOrDefault("DB_USER","root");
 private static final String CONTRASENA=System.getenv().getOrDefault("DB_PASSWORD","");
 public static Connection obtenerConexion(){
  try { Class.forName("com.mysql.cj.jdbc.Driver"); return DriverManager.getConnection(URL,USUARIO,CONTRASENA); }
  catch(ClassNotFoundException e){System.out.println("No se encontró el controlador JDBC: "+e.getMessage());}
  catch(SQLException e){System.out.println("Error al conectar con MySQL: "+e.getMessage());}
  return null;
 }
}