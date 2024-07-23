import Nat "mo:base/Nat";
import Float "mo:base/Float";

module {
  public type FacturaClientes = {
    idFactura : Nat;
    nombreClienteFactura : Nat;
    montoFactura : Float;
    diaEmisionFactura : Nat;
    mesEmisionFactura : Nat;
    anoEmisionFactura : Nat;
  };
};
