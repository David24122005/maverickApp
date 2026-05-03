import 'package:maverickapp/models/detalleVenta.dart';
import 'package:maverickapp/models/usuario.dart';
import 'package:maverickapp/models/cliente.dart';

class Venta {
  final int? id;
  final String? numeroVenta;
  final int? usuarioId;
  final Usuario? usuario;
  final int? clienteId;
  final Cliente? cliente;
  final double? subtotalBruto;
  final double? subtotal;
  final double? iva;
  final double? total;
  final double? descuento;
  final DateTime? fechaCreacion;
  final List<Detalleventa>? detalles;

  Venta({
    this.id,
    this.numeroVenta,
    this.usuarioId,
    this.usuario,
    this.clienteId,
    this.cliente,
    this.subtotalBruto,
    this.subtotal,
    this.iva,
    this.total,
    this.descuento,
    this.fechaCreacion,
    this.detalles,
  });

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
    id: json["id"],
    numeroVenta: json["numeroVenta"],
    usuarioId: json["usuarioId"],
    usuario: json["usuario"] != null ? Usuario.fromJson(json["usuario"]) : null,
    clienteId: json["clienteId"],
    cliente: json["cliente"] != null ? Cliente.fromJson(json["cliente"]) : null,
    subtotalBruto: (json["subtotalBruto"]! as num).toDouble(),
    subtotal: (json["subtotal"]! as num).toDouble(),
    iva: (json["iva"]! as num).toDouble(),
    total: (json["total"]! as num).toDouble(),
    descuento: (json["descuento"]! as num).toDouble(),
    fechaCreacion: json["fechaCreacion"] != null
        ? DateTime.parse(json["fechaCreacion"])
        : null,
    detalles: json["detalles"] != null
        ? List<Detalleventa>.from(
            json["detalles"].map((x) => Detalleventa.fromJson(x)),
          )
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numeroVenta": numeroVenta,
    "usuarioId": usuarioId,
    "usuario": usuario,
    "clienteId": clienteId,
    "cliente": cliente,
    "subtotalBruto": subtotalBruto,
    "subtotal": subtotal,
    "iva": iva,
    "total": total,
    "descuento": descuento,
    "fechaCreacion": fechaCreacion?.toIso8601String(),
    "detalles": detalles != null
        ? List<dynamic>.from(detalles!.map((x) => x.toJson()))
        : null,
  };
}
