package model;

import java.sql.Timestamp;

public class Movimiento {
    private int idMovimiento, idProducto, idUsuario, cantidad;
    private String codigo, nombreProducto, tipo, nombreUsuario, observacion;
    private Timestamp fecha;
    public int getIdMovimiento(){return idMovimiento;} public void setIdMovimiento(int v){idMovimiento=v;}
    public int getIdProducto(){return idProducto;} public void setIdProducto(int v){idProducto=v;}
    public int getIdUsuario(){return idUsuario;} public void setIdUsuario(int v){idUsuario=v;}
    public int getCantidad(){return cantidad;} public void setCantidad(int v){cantidad=v;}
    public String getCodigo(){return codigo;} public void setCodigo(String v){codigo=v;}
    public String getNombreProducto(){return nombreProducto;} public void setNombreProducto(String v){nombreProducto=v;}
    public String getTipo(){return tipo;} public void setTipo(String v){tipo=v;}
    public String getNombreUsuario(){return nombreUsuario;} public void setNombreUsuario(String v){nombreUsuario=v;}
    public String getObservacion(){return observacion;} public void setObservacion(String v){observacion=v;}
    public Timestamp getFecha(){return fecha;} public void setFecha(Timestamp v){fecha=v;}
}