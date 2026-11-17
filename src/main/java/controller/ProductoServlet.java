package controller;

import dao.ProductoDAO;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Producto;

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {
    private ProductoDAO dao;
    @Override public void init() { dao = new ProductoDAO(); }

    private boolean sesionValida(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession s=request.getSession(false);
        if(s==null || s.getAttribute("usuario")==null) { response.sendRedirect(request.getContextPath()+"/login.jsp"); return false; }
        return true;
    }

    @Override protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
        if(!sesionValida(request,response)) return;
        String accion=request.getParameter("accion");
        if("nuevo".equals(accion)) {
            request.setAttribute("producto",new Producto());
            request.getRequestDispatcher("/producto-form.jsp").forward(request,response);
        } else if("editar".equals(accion)) {
            try { request.setAttribute("producto",dao.obtener(Integer.parseInt(request.getParameter("id")))); }
            catch(Exception e) { response.sendRedirect(request.getContextPath()+"/ProductoServlet"); return; }
            request.getRequestDispatcher("/producto-form.jsp").forward(request,response);
        } else if("detalle".equals(accion)) {
            try { request.setAttribute("producto",dao.obtener(Integer.parseInt(request.getParameter("id")))); }
            catch(Exception e) { response.sendRedirect(request.getContextPath()+"/ProductoServlet"); return; }
            request.getRequestDispatcher("/detalle-producto.jsp").forward(request,response);
        } else if("eliminar".equals(accion)) {
            try { dao.eliminar(Integer.parseInt(request.getParameter("id"))); } catch(Exception e) { }
            response.sendRedirect(request.getContextPath()+"/ProductoServlet");
        } else {
            request.setAttribute("productos",dao.listar(request.getParameter("buscar")));
            request.getRequestDispatcher("/productos.jsp").forward(request,response);
        }
    }

    @Override protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
        request.setCharacterEncoding("UTF-8");
        if(!sesionValida(request,response)) return;
        try {
            Producto p=new Producto();
            String id=request.getParameter("id_producto");
            if(id!=null && !id.trim().isEmpty()) p.setIdProducto(Integer.parseInt(id));
            p.setCodigo(request.getParameter("codigo").trim());
            p.setNombre(request.getParameter("nombre").trim());
            p.setCategoria(request.getParameter("categoria").trim());
            p.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            p.setFechaVencimiento(Date.valueOf(request.getParameter("fecha_vencimiento")));
            boolean ok=(p.getIdProducto()>0)?dao.actualizar(p):dao.guardar(p);
            response.sendRedirect(request.getContextPath()+"/ProductoServlet?mensaje="+(ok?"guardado":"error"));
        } catch(Exception e) {
            response.sendRedirect(request.getContextPath()+"/ProductoServlet?mensaje=error");
        }
    }
}