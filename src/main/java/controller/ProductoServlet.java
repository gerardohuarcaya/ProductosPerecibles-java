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

    @Override
    public void init() { dao = new ProductoDAO(); }

    private boolean modoDemo(HttpServletRequest request) {
        return SesionInvitado.esInvitado(request);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (modoDemo(request)) {
            DemoDataStore demo = SesionInvitado.obtenerDatosDemo(request);
            String accion = request.getParameter("accion");
            if ("nuevo".equals(accion)) {
                request.setAttribute("producto", new Producto());
                request.getRequestDispatcher("/producto-form.jsp").forward(request, response);
                return;
            }
            if ("editar".equals(accion) || "detalle".equals(accion)) {
                Producto p = demo.obtenerProducto(parseId(request.getParameter("id")));
                if (p == null) { response.sendRedirect(request.getContextPath() + "/ProductoServlet"); return; }
                request.setAttribute("producto", p);
                request.getRequestDispatcher("detalle".equals(accion) ? "/detalle-producto.jsp" : "/producto-form.jsp").forward(request, response);
                return;
            }
            if ("eliminar".equals(accion)) {
                demo.eliminarProducto(parseId(request.getParameter("id")));
                response.sendRedirect(request.getContextPath() + "/ProductoServlet");
                return;
            }
            request.setAttribute("productos", demo.listarProductos(request.getParameter("buscar")));
            request.setAttribute("modoDemo", Boolean.TRUE);
            request.getRequestDispatcher("/productos.jsp").forward(request, response);
            return;
        }

        String accion = request.getParameter("accion");
        if ("nuevo".equals(accion)) {
            request.setAttribute("producto", new Producto());
            request.getRequestDispatcher("/producto-form.jsp").forward(request, response);
        } else if ("editar".equals(accion) || "detalle".equals(accion)) {
            Producto p = dao.obtener(parseId(request.getParameter("id")));
            if (p == null) { response.sendRedirect(request.getContextPath() + "/ProductoServlet"); return; }
            request.setAttribute("producto", p);
            request.getRequestDispatcher("detalle".equals(accion) ? "/detalle-producto.jsp" : "/producto-form.jsp").forward(request, response);
        } else if ("eliminar".equals(accion)) {
            dao.eliminar(parseId(request.getParameter("id")));
            response.sendRedirect(request.getContextPath() + "/ProductoServlet");
        } else {
            request.setAttribute("productos", dao.listar(request.getParameter("buscar")));
            request.getRequestDispatcher("/productos.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            Producto p = new Producto();
            String id = request.getParameter("id_producto");
            if (id != null && !id.trim().isEmpty()) p.setIdProducto(Integer.parseInt(id));
            p.setCodigo(request.getParameter("codigo").trim());
            p.setNombre(request.getParameter("nombre").trim());
            p.setCategoria(request.getParameter("categoria").trim());
            p.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            p.setFechaVencimiento(Date.valueOf(request.getParameter("fecha_vencimiento")));

            boolean ok;
            if (modoDemo(request)) {
                DemoDataStore demo = SesionInvitado.obtenerDatosDemo(request);
                ok = p.getIdProducto() > 0 ? demo.actualizarProducto(p) : demo.guardarProducto(p);
            } else {
                ok = p.getIdProducto() > 0 ? dao.actualizar(p) : dao.guardar(p);
            }
            response.sendRedirect(request.getContextPath() + "/ProductoServlet?mensaje=" + (ok ? "guardado" : "error"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/ProductoServlet?mensaje=error");
        }
    }

    private int parseId(String valor) {
        try { return Integer.parseInt(valor); } catch (Exception e) { return -1; }
    }
}