import 'package:maverickapp/models/venta.dart';
import 'package:maverickapp/models/producto.dart';

class Detalleventa {
  final int? id;
  final int? ventaId;
  final Venta? venta;
  final int? productoId;
  final Producto? producto;
  final int? cantidad;
  final double? precioUnitario;
  final double? subtotal;
  final DateTime? fechaCreacion;

  Detalleventa({
    this.id,
    this.ventaId,
    this.venta,
    this.productoId,
    this.producto,
    this.cantidad,
    this.precioUnitario,
    this.subtotal,
    this.fechaCreacion,
  });
  factory Detalleventa.fromJson(Map<String, dynamic> json) => Detalleventa(
    id: json["id"],
    ventaId: json["ventaId"],
    venta: json["venta"],
    productoId: json["productoId"],
    producto: json["producto"] != null
        ? Producto.fromJson(json["producto"])
        : null,
    cantidad: json["cantidad"],
    precioUnitario: (json["precioUnitario"]! as num).toDouble(),
    subtotal: (json["subtotal"]! as num).toDouble(),
    fechaCreacion: json["fechaCreacion"] != null
        ? DateTime.parse(json["fechaCreacion"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ventaId": ventaId,
    "venta": venta,
    "productoid": productoId,
    "producto": producto,
    "cantidad": cantidad,
    "precioUnitario": precioUnitario,
    "subtotal": subtotal,
    "fechaCreacion": fechaCreacion?.toIso8601String(),
  };
}
