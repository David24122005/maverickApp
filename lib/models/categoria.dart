import 'package:maverickapp/models/producto.dart';

class Categoria {
  final int? id;
  final String? nombre;
  final String? descripcion;
  final List<Producto>? productos;

  Categoria({this.id, this.nombre, this.descripcion, this.productos});
  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    id: json["id"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    productos: json["productos"] != null
        ? List<Producto>.from(
            json["productos"].map((x) => Producto.fromJson(x)),
          )
        : null,
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "descripcion": descripcion,
    "productos": productos != null
        ? List<dynamic>.from(productos!.map((x) => x.toJson()))
        : null,
  };
}
