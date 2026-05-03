import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:maverickapp/models/categoria.dart';
import 'package:maverickapp/models/respuestaApi.dart';

class CategoriaService {
  final _storage = const FlutterSecureStorage();

  Future<RespuestaApi<List<Categoria>?>?> obtenerCategorias() async {
    try {
      final _baseUrl = await _storage.read(key: "baseUrl");
      final _token = await _storage.read(key: "token");

      final url = Uri.parse("$_baseUrl/Categoria/obtener");
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      final response = await http.get(url, headers: headers);
      Map<String, dynamic> bodyJson = jsonDecode(response.body);
      final respuestApi = RespuestaApi<List<Categoria>?>.fromJson(
        bodyJson,
        (datos) => List<Categoria>.from(
          (datos as List).map((x) => Categoria.fromJson(x)),
        ),
      );
      return respuestApi;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
