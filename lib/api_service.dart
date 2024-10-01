import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/app_model.dart';

class ApiService {
  final String baseUrl = "http://localhost:5106/api";

  Future<List<AppModel>> fetchApps() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/apps"));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((app) => AppModel.fromJson(app)).toList();
      } else {
        throw Exception('Failed to load apps');
      }
    } catch (e) {
      throw Exception('Failed to load apps: $e');
    }
  }
}
