import Nat "mo:base/Nat";

module {
  public type ProveedorProductos = {
    idProveedor : Nat;
    nombreProveedor : Text;
    direccionProveedor : Text;
    telefonoProveedor : Nat;
  };
};