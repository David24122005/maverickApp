import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:maverickapp/models/autenticacion.dart';
import 'package:maverickapp/models/respuestaApi.dart';

class Autenticacionservice {
  final _storage = const FlutterSecureStorage();

  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<RespuestaApi<AutenticacionRespuesta>?> login(
    String email,
    String passwordHash,
  ) async {
    try {
      String? _baseUrl = await _storage.read(key: "baseUrl");
      final url = Uri.parse("$_baseUrl/Autenticacion/login");

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({"email": email, "passwordHash": passwordHash}),
      );
      Map<String, dynamic> bodyJson = jsonDecode(response.body);

      final respuestaApi = RespuestaApi<AutenticacionRespuesta>.fromJson(
        bodyJson,
        (datos) => AutenticacionRespuesta.fromJson(datos),
      );
      return respuestaApi;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
