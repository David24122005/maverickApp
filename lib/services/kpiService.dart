import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maverickapp/models/Kpis/dashboardKpi.dart';
import 'package:http/http.dart' as http;
import 'package:maverickapp/models/respuestaApi.dart';

class Kpiservice {
  final _storage = const FlutterSecureStorage();

  Future<RespuestaApi<DashboardKpi>?> ObtenerKpiDashboard() async {
    try {
      String? _baseUrl = await _storage.read(key: "baseUrl");
      String? _token = await _storage.read(key: "token");
      
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      final url = Uri.parse("$_baseUrl/Kpi/obtener/dashboard");

      final response = await http.get(url, headers: headers);
      Map<String, dynamic> bodyJson = jsonDecode(response.body);

      final respuestaApi = RespuestaApi<DashboardKpi>.fromJson(
        bodyJson,
        (datos) => DashboardKpi.fromJson(datos),
      );
      return respuestaApi;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
