import Nat "mo:base/Nat";
import Float "mo:base/Float";

module {
  public type PedidoGenerados = {
    idPedido : Nat;
    productosPedido : Text;
    costoPedido : Float;
    nombreSolicitantePedido : Text;
    estadoPedido : Text;
    entregaPedido : Bool;
  };
};
