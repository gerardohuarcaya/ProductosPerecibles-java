package controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Dashboard;
import model.Movimiento;
import model.Producto;
import model.Usuario;

/**
 * Datos de demostración guardados únicamente en la sesión del navegador.
 * No consulta MySQL y se pierden al cerrar la sesión o reiniciar el servidor.
 */
public class DemoDataStore {
    private final List<Producto> productos = new ArrayList<>();
    private final List<Movimiento> movimientos = new ArrayList<>();
    private int siguienteProducto = 4;
    private int siguienteMovimiento = 3;

    public DemoDataStore() {
        LocalDate hoy = LocalDate.now();
        productos.add(crearProducto(1, "DEMO-001", "Leche evaporada", "Lácteos", 24, hoy.plusDays(3)));
        productos.add(crearProducto(2, "DEMO-002", "Yogur natural", "Lácteos", 12, hoy.minusDays(4)));
        productos.add(crearProducto(3, "DEMO-003", "Manzana", "Frutas", 40, hoy.plusDays(20)));
        agregarMovimientoInicial(1, "ENTRADA", 24, "Carga inicial de demostración");
        agregarMovimientoInicial(2, "ENTRADA", 12, "Carga inicial de demostración");
    }

    private Producto crearProducto(int id, String codigo, String nombre, String categoria, int cantidad, LocalDate fecha) {
        Producto p = new Producto();
        p.setIdProducto(id); p.setCodigo(codigo); p.setNombre(nombre); p.setCategoria(categoria);
        p.setCantidad(cantidad); p.setFechaVencimiento(Date.valueOf(fecha));
        p.setDiasRestantes((int) java.time.temporal.ChronoUnit.DAYS.between(LocalDate.now(), fecha));
        return p;
    }

    private void agregarMovimientoInicial(int idProducto, String tipo, int cantidad, String observacion) {
        Producto p = buscarProducto(idProducto);
        Movimiento m = new Movimiento();
        m.setIdMovimiento(siguienteMovimiento++); m.setIdProducto(idProducto);
        m.setCodigo(p.getCodigo()); m.setNombreProducto(p.getNombre());
        m.setTipo(tipo); m.setCantidad(cantidad); m.setFecha(new Timestamp(System.currentTimeMillis()));
        m.setNombreUsuario("Sistema de demostración"); m.setObservacion(observacion);
        movimientos.add(m);
    }

    public synchronized List<Producto> listarProductos(String buscar) {
        List<Producto> resultado = new ArrayList<>();
        String filtro = buscar == null ? "" : buscar.trim().toLowerCase();
        for (Producto p : productos) {
            if (p.getCodigo().toLowerCase().contains(filtro) || p.getNombre().toLowerCase().contains(filtro)
                    || p.getCategoria().toLowerCase().contains(filtro)) resultado.add(p);
        }
        return resultado;
    }

    public synchronized Producto obtenerProducto(int id) {
        Producto p = buscarProducto(id);
        return p;
    }

    private Producto buscarProducto(int id) {
        for (Producto p : productos) if (p.getIdProducto() == id) return p;
        return null;
    }

    public synchronized boolean guardarProducto(Producto p) {
        if (p == null || p.getCodigo() == null || p.getNombre() == null || p.getFechaVencimiento() == null) return false;
        p.setIdProducto(siguienteProducto++);
        p.setDiasRestantes((int) java.time.temporal.ChronoUnit.DAYS.between(LocalDate.now(), p.getFechaVencimiento().toLocalDate()));
        productos.add(p);
        return true;
    }

    public synchronized boolean actualizarProducto(Producto p) {
        Producto actual = buscarProducto(p.getIdProducto());
        if (actual == null || p.getFechaVencimiento() == null) return false;
        actual.setCodigo(p.getCodigo()); actual.setNombre(p.getNombre()); actual.setCategoria(p.getCategoria());
        actual.setCantidad(p.getCantidad()); actual.setFechaVencimiento(p.getFechaVencimiento());
        actual.setDiasRestantes((int) java.time.temporal.ChronoUnit.DAYS.between(LocalDate.now(), p.getFechaVencimiento().toLocalDate()));
        return true;
    }

    public synchronized boolean eliminarProducto(int id) {
        return productos.removeIf(p -> p.getIdProducto() == id);
    }

    public synchronized List<Movimiento> listarMovimientos(String tipo) {
        List<Movimiento> resultado = new ArrayList<>();
        for (Movimiento m : movimientos) if (tipo == null || tipo.trim().isEmpty() || tipo.equals(m.getTipo())) resultado.add(m);
        return resultado;
    }

    public synchronized boolean registrarMovimiento(int idProducto, String tipo, int cantidad, String observacion) {
        Producto p = buscarProducto(idProducto);
        if (p == null || cantidad <= 0 || (!"ENTRADA".equals(tipo) && !"SALIDA".equals(tipo))) return false;
        if ("SALIDA".equals(tipo) && p.getCantidad() < cantidad) return false;
        p.setCantidad(p.getCantidad() + ("ENTRADA".equals(tipo) ? cantidad : -cantidad));
        Movimiento m = new Movimiento();
        m.setIdMovimiento(siguienteMovimiento++); m.setIdProducto(idProducto);
        m.setCodigo(p.getCodigo()); m.setNombreProducto(p.getNombre());
        m.setTipo(tipo); m.setCantidad(cantidad); m.setFecha(new Timestamp(System.currentTimeMillis()));
        m.setNombreUsuario("Invitado (demo)"); m.setObservacion(observacion);
        movimientos.add(0, m);
        return true;
    }

    public synchronized List<Producto> listarVencimientos(boolean vencidos) {
        List<Producto> resultado = new ArrayList<>();
        LocalDate hoy = LocalDate.now();
        for (Producto p : productos) {
            LocalDate fecha = p.getFechaVencimiento().toLocalDate();
            long dias = java.time.temporal.ChronoUnit.DAYS.between(hoy, fecha);
            p.setDiasRestantes((int) dias);
            if (vencidos ? dias < 0 : dias >= 0 && dias <= 7) resultado.add(p);
        }
        return resultado;
    }

    public synchronized Dashboard obtenerDashboard() {
        int disponibles = 0, proximos = 0, vencidos = 0;
        for (Producto p : productos) {
            if (p.getCantidad() > 0) disponibles++;
            long dias = java.time.temporal.ChronoUnit.DAYS.between(LocalDate.now(), p.getFechaVencimiento().toLocalDate());
            if (dias < 0) vencidos++;
            else if (dias <= 7) proximos++;
        }
        return new Dashboard(productos.size(), disponibles, proximos, vencidos);
    }

    public synchronized List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        Usuario invitado = new Usuario();
        invitado.setIdUsuario(0); invitado.setNombre("Invitado de demostración");
        invitado.setUsuario("invitado"); invitado.setCorreo("No aplica");
        invitado.setEstado(1); invitado.setRol("invitado");
        lista.add(invitado);
        return lista;
    }
}