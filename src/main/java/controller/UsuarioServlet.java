package controller;

import dao.UsuarioGestionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
        HttpSession s=request.getSession(false);
        if(s==null||s.getAttribute("usuario")==null){response.sendRedirect(request.getContextPath()+"/login.jsp");return;}
        request.setAttribute("usuarios",new UsuarioGestionDAO().listar(request.getParameter("buscar")));
        request.getRequestDispatcher("/usuarios.jsp").forward(request,response);
    }
}