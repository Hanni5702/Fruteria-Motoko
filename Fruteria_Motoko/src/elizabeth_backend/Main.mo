import Array "mo:base/Array";
import Nat "mo:base/Nat";

import EmpleadoVentas "EmpleadoVentas";
import ProveedorProductos "ProveedorProductos";
import FacturaClientes "FacturaClientes";
import ProductoEnVenta "ProductoEnVenta";
import PedidoGenerados "PedidoGenerados";

actor {
  var empleados : [EmpleadoVentas.EmpleadoVentas] = [];
  var proveedores : [ProveedorProductos.ProveedorProductos] = [];
  var facturas : [FacturaClientes.FacturaClientes] = [];
  var productos : [ProductoEnVenta.ProductoEnVenta] = [];
  var pedidos : [PedidoGenerados.PedidoGenerados] = [];

  // CRUD EmpleadoVentas
  public shared func registroEmpleadoVentas(empleadoNuevo : EmpleadoVentas.EmpleadoVentas) : async () {
    empleados := Array.append(empleados, [empleadoNuevo]);
  };

  public shared func obtenerEmpleadoVentas(id : Nat) : async ?EmpleadoVentas.EmpleadoVentas {
    for (empleado in empleados.vals()) {
      if (empleado.idEmpleado == id) {
        return ?empleado;
      };
    };
    return null;
  };

  public shared func actualizarEmpleadoVentas(empleadoActualizado : EmpleadoVentas.EmpleadoVentas) : async Bool {
    var updated = false;
    empleados := Array.map<EmpleadoVentas.EmpleadoVentas, EmpleadoVentas.EmpleadoVentas>(
      empleados,
      func(empleado : EmpleadoVentas.EmpleadoVentas) : EmpleadoVentas.EmpleadoVentas {
        if (empleado.idEmpleado == empleadoActualizado.idEmpleado) {
          updated := true;
          return empleadoActualizado;
        } else {
          return empleado;
        };
      },
    );
    return updated;
  };

  public shared func eliminarEmpleadoVentas(id : Nat) : async Bool {
    let originalLength = Array.size(empleados);
    empleados := Array.filter<EmpleadoVentas.EmpleadoVentas>(
      empleados,
      func(empleado : EmpleadoVentas.EmpleadoVentas) : Bool {
        empleado.idEmpleado != id;
      },
    );
    return Array.size(empleados) < originalLength;
  };

  // CRUD ProveedorProductos
  public shared func registroProveedorProductos(proveedorNuevo : ProveedorProductos.ProveedorProductos) : async () {
    proveedores := Array.append(proveedores, [proveedorNuevo]);
  };

  public shared func obtenerProveedorProductos(id : Nat) : async ?ProveedorProductos.ProveedorProductos {
    for (proveedor in proveedores.vals()) {
      if (proveedor.idProveedor == id) {
        return ?proveedor;
      };
    };
    return null;
  };

  public shared func actualizarProveedorProductos(proveedorActualizado : ProveedorProductos.ProveedorProductos) : async Bool {
    var updated = false;
    proveedores := Array.map<ProveedorProductos.ProveedorProductos, ProveedorProductos.ProveedorProductos>(
      proveedores,
      func(proveedor : ProveedorProductos.ProveedorProductos) : ProveedorProductos.ProveedorProductos {
        if (proveedor.idProveedor == proveedorActualizado.idProveedor) {
          updated := true;
          return proveedorActualizado;
        } else {
          return proveedor;
        };
      },
    );
    return updated;
  };

  public shared func eliminarProveedorProductos(id : Nat) : async Bool {
    let originalLength = Array.size(proveedores);
    proveedores := Array.filter<ProveedorProductos.ProveedorProductos>(
      proveedores,
      func(proveedor : ProveedorProductos.ProveedorProductos) : Bool {
        proveedor.idProveedor != id;
      },
    );
    return Array.size(proveedores) < originalLength;
  };

  // CRUD FacturaClientes
  public shared func registroFacturaClientes(facturaNueva : FacturaClientes.FacturaClientes) : async () {
    facturas := Array.append(facturas, [facturaNueva]);
  };

  public shared func obtenerFacturaClientes(id : Nat) : async ?FacturaClientes.FacturaClientes {
    for (factura in facturas.vals()) {
      if (factura.idFactura == id) {
        return ?factura;
      };
    };
    return null;
  };

  public shared func actualizarFacturaClientes(facturaActualizada : FacturaClientes.FacturaClientes) : async Bool {
    var updated = false;
    facturas := Array.map<FacturaClientes.FacturaClientes, FacturaClientes.FacturaClientes>(
      facturas,
      func(factura : FacturaClientes.FacturaClientes) : FacturaClientes.FacturaClientes {
        if (factura.idFactura == facturaActualizada.idFactura) {
          updated := true;
          return facturaActualizada;
        } else {
          return factura;
        };
      },
    );
    return updated;
  };

  public shared func eliminarFacturaClientes(id : Nat) : async Bool {
    let originalLength = Array.size(facturas);
    facturas := Array.filter<FacturaClientes.FacturaClientes>(
      facturas,
      func(factura : FacturaClientes.FacturaClientes) : Bool {
        factura.idFactura != id;
      },
    );
    return Array.size(facturas) < originalLength;
  };

  // CRUD ProductoEnVenta
  public shared func registroProductoEnVenta(productoNuevo : ProductoEnVenta.ProductoEnVenta) : async () {
    let precioModificado = switch (productoNuevo.tipoProducto) {
      case ("Verdura") { productoNuevo.precioProducto * 0.9 };
      case ("Fruta") { productoNuevo.precioProducto * 0.95 };
      case ("Otro") { productoNuevo.precioProducto * 1.05 };
    };
    let nuevoProducto = {
      idProductoExistente = productoNuevo.idProductoExistente;
      nombreProducto = productoNuevo.nombreProducto;
      marcaProducto = productoNuevo.marcaProducto;
      tipoProducto = productoNuevo.tipoProducto;
      precioProducto = precioModificado;
      existenciaProducto = productoNuevo.existenciaProducto;
    };
    productos := Array.append(productos, [nuevoProducto]);
  };

  public shared func obtenerProductoEnVenta(id : Nat) : async ?ProductoEnVenta.ProductoEnVenta {
    for (producto in productos.vals()) {
      if (producto.idProductoExistente == id) {
        return ?producto;
      };
    };
    return null;
  };

  public shared func actualizarProductoEnVenta(productoActualizado : ProductoEnVenta.ProductoEnVenta) : async Bool {
    var updated = false;
    productos := Array.map<ProductoEnVenta.ProductoEnVenta, ProductoEnVenta.ProductoEnVenta>(
      productos,
      func(producto : ProductoEnVenta.ProductoEnVenta) : ProductoEnVenta.ProductoEnVenta {
        if (producto.idProductoExistente == productoActualizado.idProductoExistente) {
          updated := true;
          let precioModificado = switch (productoActualizado.tipoProducto) {
            case ("Verdura") { productoActualizado.precioProducto * 0.9 };
            case ("Fruta") { productoActualizado.precioProducto * 0.95 };
            case ("Otro") { productoActualizado.precioProducto * 1.05 };
          };
          return {
            idProductoExistente = productoActualizado.idProductoExistente;
            nombreProducto = productoActualizado.nombreProducto;
            marcaProducto = productoActualizado.marcaProducto;
            tipoProducto = productoActualizado.tipoProducto;
            precioProducto = precioModificado;
            existenciaProducto = productoActualizado.existenciaProducto;
          };
        } else {
          return producto;
        };
      },
    );
    return updated;
  };

  public shared func eliminarProductoEnVenta(id : Nat) : async Bool {
    let originalLength = Array.size(productos);
    productos := Array.filter<ProductoEnVenta.ProductoEnVenta>(
      productos,
      func(producto : ProductoEnVenta.ProductoEnVenta) : Bool {
        producto.idProductoExistente != id;
      },
    );
    return Array.size(productos) < originalLength;
  };

  // CRUD PedidoGenerados
  public shared func registroPedidoGenerados(pedidoNuevo : PedidoGenerados.PedidoGenerados) : async () {
    let costoModificado = if (pedidoNuevo.entregaPedido) {
      pedidoNuevo.costoPedido + 150.0;
    } else {
      pedidoNuevo.costoPedido;
    };
    let nuevoPedido = {
      idPedido = pedidoNuevo.idPedido;
      productosPedido = pedidoNuevo.productosPedido;
      costoPedido = costoModificado;
      nombreSolicitantePedido = pedidoNuevo.nombreSolicitantePedido;
      estadoPedido = pedidoNuevo.estadoPedido;
      entregaPedido = pedidoNuevo.entregaPedido;
    };
    pedidos := Array.append(pedidos, [nuevoPedido]);
  };

  public shared func obtenerPedidoGenerados(id : Nat) : async ?PedidoGenerados.PedidoGenerados {
    for (pedido in pedidos.vals()) {
      if (pedido.idPedido == id) {
        return ?pedido;
      };
    };
    return null;
  };

  public shared func actualizarPedidoGenerados(pedidoActualizado : PedidoGenerados.PedidoGenerados) : async Bool {
    var updated = false;
    pedidos := Array.map<PedidoGenerados.PedidoGenerados, PedidoGenerados.PedidoGenerados>(
      pedidos,
      func(pedido : PedidoGenerados.PedidoGenerados) : PedidoGenerados.PedidoGenerados {
        if (pedido.idPedido == pedidoActualizado.idPedido) {
          updated := true;
          let costoModificado = if (pedidoActualizado.entregaPedido) {
            pedidoActualizado.costoPedido + 150.0;
          } else {
            pedidoActualizado.costoPedido;
          };
          return {
            idPedido = pedidoActualizado.idPedido;
            productosPedido = pedidoActualizado.productosPedido;
            costoPedido = costoModificado;
            nombreSolicitantePedido = pedidoActualizado.nombreSolicitantePedido;
            estadoPedido = pedidoActualizado.estadoPedido;
            entregaPedido = pedidoActualizado.entregaPedido;
          };
        } else {
          return pedido;
        };
      },
    );
    return updated;
  };

  public shared func eliminarPedidoGenerados(id : Nat) : async Bool {
    let originalLength = Array.size(pedidos);
    pedidos := Array.filter<PedidoGenerados.PedidoGenerados>(
      pedidos,
      func(pedido : PedidoGenerados.PedidoGenerados) : Bool {
        pedido.idPedido != id;
      },
    );
    return Array.size(pedidos) < originalLength;
  };
};
