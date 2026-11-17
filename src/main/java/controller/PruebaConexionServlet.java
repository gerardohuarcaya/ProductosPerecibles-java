
package controller;

import dao.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "PruebaConexionServlet", urlPatterns = {"/prueba-conexion"})
public class PruebaConexionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html lang='es'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<title>Prueba de conexión MySQL</title>");
            out.println("</head>");
            out.println("<body>");

            out.println("<h2>Prueba de conexión MySQL</h2>");

            if (Conexion.probarConexion()) {
                out.println("<h3 style='color:green'>CONEXIÓN EXITOSA</h3>");
                out.println("<p>Java está conectado a productos_perecibles.</p>");
            } else {
                out.println("<h3 style='color:red'>ERROR DE CONEXIÓN</h3>");
                out.println("<p>Revisa la configuración de MySQL.</p>");
            }

            out.println("</body>");
            out.println("</html>");
        }
    }
}
