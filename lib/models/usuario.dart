class Usuario {
  final int? id;
  final String? nombre;
  final String? apellidos;
  final String? email;
  final String? passwordHash;
  final bool? admin;
  final bool? activo;
  final DateTime? fechaCreacion;

  Usuario({
    this.id,
    this.nombre,
    this.apellidos,
    this.email,
    this.passwordHash,
    this.admin,
    this.activo,
    this.fechaCreacion,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"],
    nombre: json["nombre"],
    apellidos: json["apellidos"],
    email: json["email"],
    passwordHash: json["passwordHash"],
    admin: json["admin"],
    activo: json["activo"],
    fechaCreacion: json["fechaCreacion"] != null
        ? DateTime.parse(json["fechaCreacion"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "apellidos": apellidos,
    "email": email,
    "passwordHash": passwordHash,
    "admin": admin,
    "activo": activo,
    "fechaCreacion": fechaCreacion?.toIso8601String(),
  };
}
