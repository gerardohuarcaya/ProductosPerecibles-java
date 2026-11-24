package controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.Usuario;

/** Acceso temporal de demostración sin credenciales ni conexión a MySQL. */
public final class SesionInvitado {
    private SesionInvitado() { }

    public static Usuario obtener(HttpServletRequest request) {
        HttpSession sesion = request.getSession(true);
        Object actual = sesion.getAttribute("usuario");
        if (actual instanceof Usuario && !Boolean.TRUE.equals(sesion.getAttribute("modoInvitado"))) {
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
        obtenerDatosDemo(sesion);
        return invitado;
    }

    public static DemoDataStore obtenerDatosDemo(HttpServletRequest request) {
        obtener(request);
        return obtenerDatosDemo(request.getSession(false));
    }

    private static DemoDataStore obtenerDatosDemo(HttpSession sesion) {
        Object datos = sesion.getAttribute("datosDemo");
        if (datos instanceof DemoDataStore) return (DemoDataStore) datos;
        DemoDataStore nuevo = new DemoDataStore();
        sesion.setAttribute("datosDemo", nuevo);
        return nuevo;
    }

    public static boolean esInvitado(HttpServletRequest request) {
        HttpSession sesion = request.getSession(false);
        return sesion != null && Boolean.TRUE.equals(sesion.getAttribute("modoInvitado"));
    }
}