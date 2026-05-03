import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maverickapp/models/respuestaApi.dart';
import 'package:maverickapp/models/cliente.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClienteService {
  final _storage = const FlutterSecureStorage();

  Future<RespuestaApi<List<Cliente>?>?> ObtenerClientes() async {
    try {
      final _baseUrl = await _storage.read(key: "baseUrl");
      final _token = await _storage.read(key: "token");

      final url = Uri.parse("$_baseUrl/Cliente/obtener");

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };

      final response = await http.get(url, headers: headers);
      Map<String, dynamic> bodyJson = jsonDecode(response.body);
      final respuestApi = RespuestaApi<List<Cliente>?>.fromJson(
        bodyJson,
        (datos) =>
            List<Cliente>.from((datos as List).map((x) => Cliente.fromJson(x))),
      );
      return respuestApi;

    } catch (e) {
      return new RespuestaApi<List<Cliente>?>(
        exito: false,
        mensaje: 'Error al obtener clientes: $e',
        datos: null,
      );
    }
  }
}
