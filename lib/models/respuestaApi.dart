class RespuestaApi<T> {
  final bool exito;
  final String mensaje;
  final T? datos;

  RespuestaApi({required this.exito, required this.mensaje, this.datos});

  factory RespuestaApi.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return RespuestaApi<T>(
      exito: json["exito"] ?? json["Exito"] ?? false,
      mensaje: json["mensaje"] ?? json["Mensaje"] ?? "",
      datos: json["datos"] != null ? fromJsonT(json["datos"]) : null,
    );
  }
}
