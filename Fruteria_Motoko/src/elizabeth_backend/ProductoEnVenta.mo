import Nat "mo:base/Nat";
import Float "mo:base/Float";

module {
  public type ProductoEnVenta = {
    idProductoExistente : Nat;
    nombreProducto : Text;
    marcaProducto : Text;
    tipoProducto : Text;
    precioProducto : Float;
    existenciaProducto : Bool;
  };
};