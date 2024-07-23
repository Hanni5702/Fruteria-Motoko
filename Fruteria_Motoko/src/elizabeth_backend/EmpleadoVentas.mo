import Nat "mo:base/Nat";
import Float "mo:base/Float";

module {
  public type EmpleadoVentas = {
    idEmpleado : Nat;
    nombreEmpleado : Text;
    apellidosEmpleado : Text;
    sueldoEmpleado : Float;
    direccionEmpleado : Text;
    telefonoEmpleado : Nat;
  };
};
