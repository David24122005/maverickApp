import 'package:maverickapp/models/categoria.dart';
import 'package:maverickapp/models/proveedor.dart';

class Producto {
  final int? id;
  final String? sku;
  final String? codigoBarras;
  final int? stock;
  final String? nombre;
  final String? descripcion;
  final double? precioCompra;
  final double? precioVenta;
  final String? marca;
  final String? modelo;
  final int? categoriaId;
  final Categoria? categoria;
  final int? proveedorId;
  final Proveedor? proveedor;
  final bool? activo;
  final DateTime? fechaCreacion;

  Producto({
    this.id,
    this.sku,
    this.codigoBarras,
    this.stock,
    this.nombre,
    this.descripcion,
    this.precioVenta,
    this.precioCompra,
    this.marca,
    this.modelo,
    this.categoriaId,
    this.categoria,
    this.proveedorId,
    this.proveedor,
    this.activo,
    this.fechaCreacion,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
    id: json["id"],
    sku: json["sku"],
    codigoBarras: json["codigoBarras"],
    stock: json["stock"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    precioCompra: (json["precioCompra"]! as num).toDouble(),
    precioVenta: (json["precioVenta"]! as num).toDouble(),
    marca: json["marca"],
    modelo: json["modelo"],
    categoriaId: json["categoriaId"],
    categoria: json["categoria"],
    proveedorId: json["proveedorId"],
    proveedor: json["proveedor"],
    activo: json["activo"],
    fechaCreacion: json["fechaCreacion"] != null
        ? DateTime.parse(json["fechaCreacion"])
        : null,
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "codigoBarras": codigoBarras,
    "stock": stock,
    "nombre": nombre,
    "descripcion": descripcion,
    "precioCompra": precioCompra,
    "precioVenta": precioVenta,
    "marca": marca,
    "modelo": modelo,
    "categoriaId": categoriaId,
    "categoria": categoria,
    "proveedorId": proveedorId,
    "proveedor": proveedor,
    "activo": activo,
    "fechaCreacion": fechaCreacion?.toIso8601String(),
  };
}
