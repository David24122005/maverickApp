import 'package:maverickapp/models/producto.dart';

class Proveedor {
  final int? id;
  final String? nombre;
  final String? email;
  final String? telefono;
  final String? direccion;
  final String? rfc;
  final bool? activo;
  final List<Producto>? productos;
  final DateTime? fechaCreacion;

  Proveedor({
    this.id,
    this.nombre,
    this.email,
    this.telefono,
    this.direccion,
    this.rfc,
    this.activo,
    this.productos,
    this.fechaCreacion,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
    id: json["id"],
    nombre: json["nombre"],
    email: json["email"],
    telefono: json["telefono"],
    direccion: json["direccion"],
    rfc: json["rfc"],
    activo: json["activo"],
    productos: json["productos"] != null
        ? List<Producto>.from(
            json["productos"].map((x) => Producto.fromJson(x)),
          )
        : null,
    fechaCreacion: json["fechaCreacion"] != null
        ? DateTime.parse(json["fechaCreacion"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "email": email,
    "telefono": telefono,
    "direccion": direccion,
    "rfc": rfc,
    "activo": activo,
    "fechaCreacion": fechaCreacion?.toIso8601String(),
    "productos": productos != null
        ? List<dynamic>.from(productos!.map((x) => x.toJson()))
        : null,
  };
}
