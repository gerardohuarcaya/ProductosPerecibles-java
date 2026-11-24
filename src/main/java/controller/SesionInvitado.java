package controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.Usuario;

/**
 * Acceso temporal para pruebas sin credenciales.
 * El usuario invitado usa id 0; las operaciones que registran movimientos
 * deben guardar id_usuario como NULL para respetar la clave foránea.
 */
public final class SesionInvitado {

    private SesionInvitado() {
    }

    public static Usuario obtener(HttpServletRequest request) {
        HttpSession sesion = request.getSession(true);
        Object actual = sesion.getAttribute("usuario");

        if (actual instanceof Usuario) {
            return (Usuario) actual;
        }

        Usuario invitado = new Usuario();
        invitado.setIdUsuario(0);
        invitado.setNombre("Invitado");
        invitado.setUsuario("invitado");
        invitado.setCorreo("");
        invitado.setEstado(1);
        invitado.setRol("invitado");
        sesion.setAttribute("usuario", invitado);
        sesion.setAttribute("modoInvitado", Boolean.TRUE);
        return invitado;
    }

    public static boolean esInvitado(HttpServletRequest request) {
        HttpSession sesion = request.getSession(false);
        if (sesion == null) {
            return false;
        }
        Object actual = sesion.getAttribute("usuario");
        return actual instanceof Usuario
                && "invitado".equals(((Usuario) actual).getUsuario());
    }
}
