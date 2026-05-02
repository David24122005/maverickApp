import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maverickapp/models/autenticacion.dart';
import 'package:maverickapp/models/respuestaApi.dart';

class Autenticacionservice {
  final String? _baseUrl = "http://localhost:5000/api";
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<RespuestaApi<AutenticacionRespuesta>?> login(
    String email,
    String passwordHash,
  ) async {
    try {
      final url = Uri.parse("$_baseUrl/Autenticacion/login");

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({"email": email, "passwordHash": passwordHash}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> bodyJson = jsonDecode(response.body);

        final respuestaApi = RespuestaApi<AutenticacionRespuesta>.fromJson(
          bodyJson,
          (datos) => AutenticacionRespuesta.fromJson(datos),
        );
        return respuestaApi;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
