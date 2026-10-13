package model;

public class Dashboard {

    private int totalProductos;
    private int productosDisponibles;
    private int productosProximosVencer;
    private int productosVencidos;

    public Dashboard() {
    }

    public Dashboard(int totalProductos, int productosDisponibles,
                     int productosProximosVencer, int productosVencidos) {
        this.totalProductos = totalProductos;
        this.productosDisponibles = productosDisponibles;
        this.productosProximosVencer = productosProximosVencer;
        this.productosVencidos = productosVencidos;
    }

    public int getTotalProductos() {
        return totalProductos;
    }

    public void setTotalProductos(int totalProductos) {
        this.totalProductos = totalProductos;
    }

    public int getProductosDisponibles() {
        return productosDisponibles;
    }

    public void setProductosDisponibles(int productosDisponibles) {
        this.productosDisponibles = productosDisponibles;
    }

    public int getProductosProximosVencer() {
        return productosProximosVencer;
    }

    public void setProductosProximosVencer(int productosProximosVencer) {
        this.productosProximosVencer = productosProximosVencer;
    }

    public int getProductosVencidos() {
        return productosVencidos;
    }

    public void setProductosVencidos(int productosVencidos) {
        this.productosVencidos = productosVencidos;
    }
}
