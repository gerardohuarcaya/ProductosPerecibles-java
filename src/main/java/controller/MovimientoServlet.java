package controller;

import dao.MovimientoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/MovimientoServlet")
public class MovimientoServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
        HttpSession s=request.getSession(false);
        if(s==null||s.getAttribute("usuario")==null){response.sendRedirect(request.getContextPath()+"/login.jsp");return;}
        request.setAttribute("movimientos",new MovimientoDAO().listar(request.getParameter("tipo")));
        request.getRequestDispatcher("/movimientos.jsp").forward(request,response);
    }
}