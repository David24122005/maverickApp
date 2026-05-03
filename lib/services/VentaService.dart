import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:maverickapp/models/respuestaApi.dart';
import 'package:maverickapp/models/venta.dart';

class VentaService {
  final _storage = const FlutterSecureStorage();
  Future<RespuestaApi<List<Venta>?>?> ObtenerVentas() async {
    try {
      String? _baseUrl = await _storage.read(key: "baseUrl");
      String? _token = await _storage.read(key: "token");

      final url = Uri.parse("$_baseUrl/Venta/obtener");

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };

      final response = await http.get(url, headers: headers);
      Map<String, dynamic> bodyJson = jsonDecode(response.body);
      final respuestApi = RespuestaApi<List<Venta>?>.fromJson(
        bodyJson,
        (datos) =>
            List<Venta>.from((datos as List).map((x) => Venta.fromJson(x))),
      );

      return respuestApi;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
