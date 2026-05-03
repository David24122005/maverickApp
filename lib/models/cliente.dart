class Cliente {
  final int? id;
  final String? nombre;
  final String? rfc;
  final String? telefono;
  final String? email;
  final bool? activo;
  final DateTime? fechaCreacion;

  Cliente({
    this.id,
    this.nombre,
    this.rfc,
    this.telefono,
    this.email,
    this.activo,
    this.fechaCreacion,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    id: json["id"],
    nombre: json["nombre"],
    rfc: json["rfc"],
    telefono: json["telefono"],
    email: json["email"],
    activo: json["activo"],
    fechaCreacion: json["fechaCreacion"] != null
        ? DateTime.parse(json["fechaCreacion"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "rfc": rfc,
    "telefono": telefono,
    "email": email,
    "activo": activo,
    "fechaCreacion": fechaCreacion,
  };
}
