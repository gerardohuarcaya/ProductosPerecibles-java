package controller;

import dao.MovimientoDAO;
import dao.ProductoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;

@WebServlet("/MovimientoServlet")
public class MovimientoServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
        HttpSession s=request.getSession(false);
        if(s==null||s.getAttribute("usuario")==null){response.sendRedirect(request.getContextPath()+"/login.jsp");return;}
        request.setAttribute("movimientos",new MovimientoDAO().listar(request.getParameter("tipo")));
        request.setAttribute("productos",new ProductoDAO().listar(null));
        request.getRequestDispatcher("/movimientos.jsp").forward(request,response);
    }

    @Override protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
        request.setCharacterEncoding("UTF-8");
        HttpSession s=request.getSession(false);
        if(s==null||s.getAttribute("usuario")==null){response.sendRedirect(request.getContextPath()+"/login.jsp");return;}
        try{
            Usuario usuario=(Usuario)s.getAttribute("usuario");
            int idProducto=Integer.parseInt(request.getParameter("id_producto"));
            int cantidad=Integer.parseInt(request.getParameter("cantidad"));
            String tipo=request.getParameter("tipo");
            String observacion=request.getParameter("observacion");
            boolean ok=new MovimientoDAO().registrar(idProducto,usuario.getIdUsuario(),tipo,cantidad,observacion);
            response.sendRedirect(request.getContextPath()+"/MovimientoServlet?resultado="+(ok?"ok":"error"));
        }catch(Exception e){response.sendRedirect(request.getContextPath()+"/MovimientoServlet?resultado=error");}
    }
}