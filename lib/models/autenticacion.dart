import 'package:maverickapp/models/usuario.dart';

class Autenticacion {
  final String? email;
  final String? passwordHash;

  Autenticacion({this.email, this.passwordHash});

  factory Autenticacion.fromJson(Map<String, dynamic> json) =>
      Autenticacion(email: json["email"], passwordHash: json["passwordHash"]);

  Map<String, dynamic> toJson() => {
    "email": email,
    "passwordHash": passwordHash,
  };
}

class AutenticacionRespuesta {
  final String? token;
  final Usuario? usuario;

  AutenticacionRespuesta({this.token, this.usuario});

  factory AutenticacionRespuesta.fromJson(Map<String, dynamic> json) =>
      AutenticacionRespuesta(
        token: json["token"],
        usuario: json["usuario"] != null
            ? Usuario.fromJson(json["usuario"])
            : null,
      );

  Map<String, dynamic> toJson() => {"token": token, "usuario": usuario};
}
